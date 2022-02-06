package body SPI_Master is

   procedure Initialize is
   begin
      MISO.Configure (RP.GPIO.Input, RP.GPIO.Floating, RP.GPIO.SPI);
      NSS.Configure (RP.GPIO.Output, RP.GPIO.Pull_Up, RP.GPIO.SPI);
      SCK.Configure (RP.GPIO.Output, RP.GPIO.Pull_Up, RP.GPIO.SPI);
      MOSI.Configure (RP.GPIO.Output, RP.GPIO.Pull_Up, RP.GPIO.SPI);
      SPI.Configure (Config);
   end Initialize;

end SPI_Master;
