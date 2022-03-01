with HAL;
with HAL.SPI;

with RP.Clock;
with RP.GPIO;
with RP.SPI;
with RP.Device;

with ItsyBitsy;

with SPI_Master_ItsyBitsy;

procedure Main_Master_ItsyBitsy is

   --  THE_VALUE  : constant HAL.UInt16 := HAL.UInt16 (16#55AA#);
   THE_VALUE  : constant HAL.UInt16 := HAL.UInt16 (16#DC48#);
   Data_Out   : constant HAL.SPI.SPI_Data_16b (1 .. 1)
     := (others => THE_VALUE);
   Status_Out : HAL.SPI.SPI_Status;

   Data_In    : HAL.SPI.SPI_Data_16b (1 .. 1) := (others => 0);
   Status_In  : HAL.SPI.SPI_Status;

   use HAL;
   use HAL.SPI;
   use RP.SPI;

begin
   RP.Clock.Initialize (ItsyBitsy.XOSC_Frequency);
   RP.Clock.Enable (RP.Clock.PERI);
   RP.Device.Timer.Enable;
   ItsyBitsy.LED.Configure (RP.GPIO.Output);

   SPI_Master_ItsyBitsy.Initialize;

   loop
      for I in 1 .. 1 loop
         SPI_Master_ItsyBitsy.SPI.Transmit (Data_Out, Status_Out);

         SPI_Master_ItsyBitsy.SPI.Receive (Data_In, Status_In, 0);
      end loop;
      RP.Device.Timer.Delay_Milliseconds (100);
      ItsyBitsy.LED.Toggle;
   end loop;
end Main_Master_ItsyBitsy;
