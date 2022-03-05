--===========================================================================
--
--  This is the main master program for the Pico for the
--     use cases:
--        1: Master Pico -> Slave Pico
--        2: Master Pico -> Slave ItsyBitsy
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

with Pico;

with SPI_Master_Pico;

procedure Main_Master_Pico is

   Data_Out_16   : HAL.SPI.SPI_Data_16b (1 .. 1);
   Status_Out : HAL.SPI.SPI_Status;

   Data_In_16 : HAL.SPI.SPI_Data_16b (1 .. 1) := (others => 0);
   Status_In  : HAL.SPI.SPI_Status;

   Word : HAL.UInt16;

   use HAL;
   use HAL.SPI;
   use RP.SPI;

begin
   RP.Clock.Initialize (Pico.XOSC_Frequency);
   RP.Device.Timer.Enable;
   Pico.LED.Configure (RP.GPIO.Output);

   SPI_Master_Pico.Initialize;

   loop
      --  construct the values for the transmission
      for Higher_Byte in HAL.UInt8'Range loop
         for Lower_Byte in HAL.UInt8'Range loop
            Word := Shift_Left (Value  => HAL.UInt16 (Higher_Byte),
                                Amount => 8) or HAL.UInt16 (Lower_Byte);
            Data_Out_16 (1) := Word;
            SPI_Master_Pico.SPI.Transmit (Data_Out_16, Status_Out);
            SPI_Master_Pico.SPI.Receive (Data_In_16, Status_In, 0);
            RP.Device.Timer.Delay_Milliseconds (100);
            Pico.LED.Toggle;
         end loop;
      end loop;
   end loop;
end Main_Master_Pico;
