with HAL.SPI;

with RP.Device;
with RP.GPIO;
with RP.SPI;

with Pico;

package SPI_Slave_Pico is

   -----------------------------------------------------------------------
   --  Slave section
   SPI  : RP.SPI.SPI_Port renames RP.Device.SPI_0;

   SCK  : RP.GPIO.GPIO_Point renames Pico.GP18;
   NSS  : RP.GPIO.GPIO_Point renames Pico.GP17;
   MOSI : RP.GPIO.GPIO_Point renames Pico.GP16;
   MISO : RP.GPIO.GPIO_Point renames Pico.GP19;

   Config : constant RP.SPI.SPI_Configuration
     := (Role   => RP.SPI.Slave,
         Baud   => 10_000_000,
         Data_Size => HAL.SPI.Data_Size_16b,
         others => <>);

   procedure Initialize;

end SPI_Slave_Pico;
