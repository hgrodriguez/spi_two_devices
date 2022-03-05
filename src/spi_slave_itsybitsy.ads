--===========================================================================
--
--  This package is the slave configuration for the ItsyBitsy
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
with HAL.SPI;

with RP.Device;
with RP.GPIO;
with RP.SPI;

with ItsyBitsy;

package SPI_Slave_ItsyBitsy is

   -----------------------------------------------------------------------
   --  Slave section
   SPI  : RP.SPI.SPI_Port renames RP.Device.SPI_1;

   SCK  : RP.GPIO.GPIO_Point renames ItsyBitsy.GP26;
   NSS  : RP.GPIO.GPIO_Point renames ItsyBitsy.GP29;
   MOSI : RP.GPIO.GPIO_Point renames ItsyBitsy.GP28;
   MISO : RP.GPIO.GPIO_Point renames ItsyBitsy.GP27;

   -----------------------------------------------------------------------
   --  Configuration for the slave part for the ItsyBitsy
   Config : constant RP.SPI.SPI_Configuration
     := (Role   => RP.SPI.Slave,
         Baud   => 10_000_000,
         Data_Size => HAL.SPI.Data_Size_16b,
         others => <>);

   -----------------------------------------------------------------------
   --  Initializes the ItsyBitsy as slave
   procedure Initialize;

end SPI_Slave_ItsyBitsy;
