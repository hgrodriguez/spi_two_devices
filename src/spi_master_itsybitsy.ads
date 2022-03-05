--===========================================================================
--
--  This package is the master configuration for the ItsyBitsy
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
with HAL.SPI;

with RP.Device;
with RP.GPIO;
with RP.SPI;

with ItsyBitsy;

package SPI_Master_ItsyBitsy is

   -----------------------------------------------------------------------
   --  Master section
   SPI  : RP.SPI.SPI_Port renames RP.Device.SPI_1;

   SCK  : RP.GPIO.GPIO_Point renames ItsyBitsy.GP26;
   NSS  : RP.GPIO.GPIO_Point renames ItsyBitsy.GP29;
   MOSI : RP.GPIO.GPIO_Point renames ItsyBitsy.GP27;
   MISO : RP.GPIO.GPIO_Point renames ItsyBitsy.GP28;

   -----------------------------------------------------------------------
   --  Configuration for the master part for the ItsyBitsy
   Config          : constant RP.SPI.SPI_Configuration
     := (Role   => RP.SPI.Master,
         Baud   => 10_000_000,
         Data_Size => HAL.SPI.Data_Size_16b,
         others => <>);

   -----------------------------------------------------------------------
   --  Initializes the ItsyBitsy as master
   procedure Initialize;

end SPI_Master_ItsyBitsy;
