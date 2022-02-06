with HAL;
with HAL.SPI;

with RP.Clock;
with RP.GPIO;
with RP.SPI;
with RP.Device;

with Pico;

with SPI_Master;

procedure Main_Master is

   procedure Trace_Initialize;
   -----------------------------------------------------------------------
   --  Trace section
   Master_Status_Out      : RP.GPIO.GPIO_Point renames Pico.GP16;
   Slave_Status_In        : RP.GPIO.GPIO_Point renames Pico.GP17;
   Data_In_NEQ_Data_Out   : RP.GPIO.GPIO_Point renames Pico.GP18;

   procedure Trace_Initialize is
   begin
      Master_Status_Out.Configure (RP.GPIO.Output, RP.GPIO.Pull_Down);
      Slave_Status_In.Configure (RP.GPIO.Output, RP.GPIO.Pull_Down);
      Data_In_NEQ_Data_Out.Configure (RP.GPIO.Output, RP.GPIO.Pull_Down);

      Master_Status_Out.Clear;
      Slave_Status_In.Clear;
      Data_In_NEQ_Data_Out.Clear;
   end Trace_Initialize;

   -----------------------------------------------------------------------
   --  Manage my own SS signal
   My_Own_SS : RP.GPIO.GPIO_Point renames Pico.GP15;
   procedure Initialize_Own_SS;
   procedure Initialize_Own_SS is
   begin
      My_Own_SS.Configure (RP.GPIO.Output, RP.GPIO.Pull_Up);
   end Initialize_Own_SS;

   --  THE_VALUE  : constant HAL.UInt16 := HAL.UInt16 (16#55AA#);
   THE_VALUE  : constant HAL.UInt16 := HAL.UInt16 (16#A5A5#);
   Data_Out   : constant HAL.SPI.SPI_Data_16b (1 .. 1)
     := (others => THE_VALUE);
   Status_Out : HAL.SPI.SPI_Status;

   Data_In    : HAL.SPI.SPI_Data_16b (1 .. 1) := (others => 0);
   Status_In  : HAL.SPI.SPI_Status;

   use HAL;
   use HAL.SPI;
   use RP.SPI;

begin
   RP.Clock.Initialize (Pico.XOSC_Frequency);
   RP.Device.Timer.Enable;
   Pico.LED.Configure (RP.GPIO.Output);

   Trace_Initialize;

   Initialize_Own_SS;

   SPI_Master.Initialize;

   loop
      Master_Status_Out.Clear;
      Slave_Status_In.Clear;
      Data_In_NEQ_Data_Out.Clear;

      for I in 1 .. 1 loop
         My_Own_SS.Clear;

         SPI_Master.SPI.Transmit (Data_Out, Status_Out);
         if Status_Out /= HAL.SPI.Ok then
            Master_Status_Out.Set;
         end if;

         if True then
            SPI_Master.SPI.Receive (Data_In, Status_In, 0);
            if Status_In /= HAL.SPI.Ok then
               Slave_Status_In.Set;
            end if;
         end if;

         My_Own_SS.Set;

         if True and then Data_Out (1) /= not Data_In (1) then
            Data_In_NEQ_Data_Out.Set;
         end if;
      end loop;
      RP.Device.Timer.Delay_Milliseconds (100);
      Pico.LED.Toggle;
   end loop;
end Main_Master;
