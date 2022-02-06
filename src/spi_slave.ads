with HAL.SPI;

with RP.Device;
with RP.GPIO;
with RP.SPI;

with Pico;

package SPI_Slave is

   -----------------------------------------------------------------------
   --  Slave section
   SPI  : RP.SPI.SPI_Port renames RP.Device.SPI_1;
   MISO : RP.GPIO.GPIO_Point renames Pico.GP11;
   NSS  : RP.GPIO.GPIO_Point renames Pico.GP9;
   SCK  : RP.GPIO.GPIO_Point renames Pico.GP10;
   MOSI : RP.GPIO.GPIO_Point renames Pico.GP12;

   Config : constant RP.SPI.SPI_Configuration
     := (Role   => RP.SPI.Slave,
         Baud   => 10_000_000,
         Data_Size => HAL.SPI.Data_Size_16b,
         others => <>);

   procedure Initialize;

end SPI_Slave;
