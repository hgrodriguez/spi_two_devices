--===========================================================================
--
--  This is the main slave program for the ItsyBitsy for the
--     use cases:
--        2: Master Pico      -> Slave ItsyBitsy
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
with RP.Device;

with ItsyBitsy;

with SPI_Slave_ItsyBitsy;

procedure Main_Slave_ItsyBitsy is

   Data_In      : HAL.SPI.SPI_Data_16b (1 .. 1) := (others => 0);
   Status_In    : HAL.SPI.SPI_Status;

   THE_VALUE   : constant HAL.UInt16 := HAL.UInt16 (16#A5A5#);
   Data_Out    : HAL.SPI.SPI_Data_16b (1 .. 1) := (others => THE_VALUE);
   Status_Out  : HAL.SPI.SPI_Status;

   use HAL;

begin
   RP.Clock.Initialize (ItsyBitsy.XOSC_Frequency);
   RP.Clock.Enable (RP.Clock.PERI);
   RP.Device.Timer.Enable;
   ItsyBitsy.LED.Configure (RP.GPIO.Output);

   SPI_Slave_ItsyBitsy.Initialize;

   loop
      --  do this to get the slave ready
      SPI_Slave_ItsyBitsy.SPI.Transmit (Data_Out, Status_Out);

      for I in 1 .. 1 loop
         SPI_Slave_ItsyBitsy.SPI.Receive (Data_In, Status_In, 0);
         Data_Out (1) := not Data_In (1); -- THE_VALUE
         SPI_Slave_ItsyBitsy.SPI.Transmit (Data_Out, Status_Out);
      end loop;
      RP.Device.Timer.Delay_Milliseconds (10);
      ItsyBitsy.LED.Toggle;
   end loop;
end Main_Slave_ItsyBitsy;
