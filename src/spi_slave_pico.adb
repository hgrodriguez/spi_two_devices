package body SPI_Slave_Pico is

   procedure Initialize is
   begin
      SCK.Configure (RP.GPIO.Input, RP.GPIO.Floating, RP.GPIO.SPI);
      NSS.Configure (RP.GPIO.Input, RP.GPIO.Floating, RP.GPIO.SPI);
      MOSI.Configure (RP.GPIO.Input, RP.GPIO.Floating, RP.GPIO.SPI);
      MISO.Configure (RP.GPIO.Output, RP.GPIO.Floating, RP.GPIO.SPI);

      SPI.Configure (Config);
   end Initialize;

end SPI_Slave_Pico;
