--===========================================================================
--
--  This package implements the master configuration for the Pico
--
--===========================================================================
--
--  Copyright 2022 (C) Holger Rodriguez
--
--  SPDX-License-Identifier: BSD-3-Clause
--
package body SPI_Master_Pico is

   -----------------------------------------------------------------------
   --  see .ads
   procedure Initialize is
   begin
      SCK.Configure (RP.GPIO.Output, RP.GPIO.Pull_Up, RP.GPIO.SPI);
      NSS.Configure (RP.GPIO.Output, RP.GPIO.Pull_Up, RP.GPIO.SPI);
      MOSI.Configure (RP.GPIO.Output, RP.GPIO.Pull_Up, RP.GPIO.SPI);
      MISO.Configure (RP.GPIO.Input, RP.GPIO.Floating, RP.GPIO.SPI);

      SPI.Configure (Config);
   end Initialize;

end SPI_Master_Pico;
