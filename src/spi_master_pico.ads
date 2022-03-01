with HAL.SPI;

with RP.Device;
with RP.GPIO;
with RP.SPI;

with Pico;

package SPI_Master_Pico is

   -----------------------------------------------------------------------
   --  Master section
   SPI  : RP.SPI.SPI_Port renames RP.Device.SPI_0;
   MISO : RP.GPIO.GPIO_Point renames Pico.GP0;
   NSS  : RP.GPIO.GPIO_Point renames Pico.GP1;
   SCK  : RP.GPIO.GPIO_Point renames Pico.GP2;
   MOSI : RP.GPIO.GPIO_Point renames Pico.GP3;

   Config          : constant RP.SPI.SPI_Configuration
     := (Role   => RP.SPI.Master,
         Baud   => 10_000_000,
         Data_Size => HAL.SPI.Data_Size_16b,
         others => <>);

   procedure Initialize;

end SPI_Master_Pico;
