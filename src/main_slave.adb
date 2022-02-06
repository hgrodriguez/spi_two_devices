with HAL;
with HAL.SPI;

with RP.Clock;
with RP.GPIO;
with RP.SPI;
with RP.Device;

with Pico;

with SPI_Slave;

procedure Main_Slave is

   procedure Trace_Initialize;
   -----------------------------------------------------------------------
   --  Trace section
   Slave_Status_In        : RP.GPIO.GPIO_Point renames Pico.GP17;
   Slave_Status_Out      : RP.GPIO.GPIO_Point renames Pico.GP16;
   Data_In_NEQ_Data_Out   : RP.GPIO.GPIO_Point renames Pico.GP18;

   procedure Trace_Initialize is
   begin
      Slave_Status_Out.Configure (RP.GPIO.Output);
      Slave_Status_In.Configure (RP.GPIO.Output);
      Data_In_NEQ_Data_Out.Configure (RP.GPIO.Output);

      Slave_Status_Out.Clear;
      Slave_Status_In.Clear;
      Data_In_NEQ_Data_Out.Clear;
   end Trace_Initialize;

   Data_In      : HAL.SPI.SPI_Data_16b (1 .. 1) := (others => 0);
   Status_In    : HAL.SPI.SPI_Status;

   THE_VALUE   : constant HAL.UInt16 := HAL.UInt16 (16#A5A5#);
   Data_Out    : HAL.SPI.SPI_Data_16b (1 .. 1) := (others => THE_VALUE);
   Status_Out  : HAL.SPI.SPI_Status;

   use HAL.SPI;
   use HAL;

begin
   RP.Clock.Initialize (Pico.XOSC_Frequency);
   RP.Device.Timer.Enable;
   Pico.LED.Configure (RP.GPIO.Output);

   Trace_Initialize;

   SPI_Slave.Initialize;

   loop
      Slave_Status_In.Clear;
      Slave_Status_Out.Clear;
      Data_In_NEQ_Data_Out.Clear;

      --  do this to get the slave ready
      SPI_Slave.SPI.Transmit (Data_Out, Status_Out);
      if Status_Out /= HAL.SPI.Ok then
         Slave_Status_Out.Set;
      end if;

      for I in 1 .. 1 loop
         SPI_Slave.SPI.Receive (Data_In, Status_In);
         if Status_In /= HAL.SPI.Ok then
            Slave_Status_In.Set;
         end if;
         Data_Out (1) := not Data_In (1);
         SPI_Slave.SPI.Transmit (Data_Out, Status_Out);
         if Status_Out /= HAL.SPI.Ok then
            Slave_Status_Out.Set;
         end if;
      end loop;
      RP.Device.Timer.Delay_Milliseconds (10);
      Pico.LED.Toggle;
   end loop;
end Main_Slave;
