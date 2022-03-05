with HAL;
with HAL.SPI;

with RP.Clock;
with RP.GPIO;
with RP.SPI;
with RP.Device;

with Pico;

with SPI_Slave_Pico;

procedure Main_Slave_Pico is

   Data_In      : HAL.SPI.SPI_Data_16b (1 .. 1) := (others => 0);
   Status_In    : HAL.SPI.SPI_Status;

   THE_VALUE   : constant HAL.UInt16 := HAL.UInt16 (16#A5A5#);
   Data_Out    : HAL.SPI.SPI_Data_16b (1 .. 1) := (others => THE_VALUE);
   Status_Out  : HAL.SPI.SPI_Status;

   use HAL;

begin
   RP.Clock.Initialize (Pico.XOSC_Frequency);
   RP.Device.Timer.Enable;
   Pico.LED.Configure (RP.GPIO.Output);

   SPI_Slave_Pico.Initialize;

   loop
      --  do this to get the slave ready
      SPI_Slave_Pico.SPI.Transmit (Data_Out, Status_Out);

      for I in 1 .. 1 loop
         SPI_Slave_Pico.SPI.Receive (Data_In, Status_In);
         Data_Out (1) := not Data_In (1);
         SPI_Slave_Pico.SPI.Transmit (Data_Out, Status_Out);
      end loop;
      RP.Device.Timer.Delay_Milliseconds (10);
      Pico.LED.Toggle;
   end loop;
end Main_Slave_Pico;
