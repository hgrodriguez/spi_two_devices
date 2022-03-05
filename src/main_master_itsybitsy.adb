--===========================================================================
--
--  This is the main master program for the ItsyBitsy for the
--     use cases:
--        3: Master ItsyBitsy -> Slave Pico
--        4: Master ItsyBitsy -> Slave ItsyBitsy
--
--===========================================================================
--
--  Copyright 2022 (C) Holger Rodriguez
--
--  SPDX-License-Identifier: BSD-3-Clause
--
with HAL;
with HAL.SPI;

with RP.Clock;
with RP.GPIO;
with RP.SPI;
with RP.Device;

with ItsyBitsy;

with SPI_Master_ItsyBitsy;

procedure Main_Master_ItsyBitsy is

   THE_VALUE  : constant HAL.UInt16 := HAL.UInt16 (16#55AA#);
   Data_Out_16   :  HAL.SPI.SPI_Data_16b (1 .. 1)
     := (others => THE_VALUE);
   Status_Out : HAL.SPI.SPI_Status;

   Data_In_16    : HAL.SPI.SPI_Data_16b (1 .. 1) := (others => 0);
   Status_In  : HAL.SPI.SPI_Status;

   Word : HAL.UInt16;

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
      --  construct the values for the transmission
      for Higher_Byte in HAL.UInt8'Range loop
         for Lower_Byte in HAL.UInt8'Range loop
            Word := Shift_Left (Value  => HAL.UInt16 (Higher_Byte),
                                Amount => 8) or HAL.UInt16 (Lower_Byte);
            Data_Out_16 (1) := Word;
            SPI_Master_ItsyBitsy.SPI.Transmit (Data_Out_16, Status_Out);
            SPI_Master_ItsyBitsy.SPI.Receive (Data_In_16, Status_In, 0);
            RP.Device.Timer.Delay_Milliseconds (100);
            ItsyBitsy.LED.Toggle;
         end loop;
      end loop;
   end loop;
end Main_Master_ItsyBitsy;
