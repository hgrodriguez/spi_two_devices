--===========================================================================
--
--  This package is the master configuration for the Pico
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
with HAL.SPI;

with RP.Device;
with RP.GPIO;
with RP.SPI;

with Pico;

package SPI_Master_Pico is

   -----------------------------------------------------------------------
   --  Master section
   SPI  : RP.SPI.SPI_Port renames RP.Device.SPI_0;

   SCK  : RP.GPIO.GPIO_Point renames Pico.GP18;
   NSS  : RP.GPIO.GPIO_Point renames Pico.GP17;
   MOSI : RP.GPIO.GPIO_Point renames Pico.GP19;
   MISO : RP.GPIO.GPIO_Point renames Pico.GP16;

   -----------------------------------------------------------------------
   --  Configuration for the master part for the Pico
   Config          : constant RP.SPI.SPI_Configuration
     := (Role   => RP.SPI.Master,
         Baud   => 10_000_000,
         Data_Size => HAL.SPI.Data_Size_16b,
         others => <>);

   -----------------------------------------------------------------------
   --  Initializes the Pico as master
   procedure Initialize;

end SPI_Master_Pico;
