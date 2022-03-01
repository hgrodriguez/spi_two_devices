with HAL.SPI;

with RP.Device;
with RP.GPIO;
with RP.SPI;

with ItsyBitsy;

package SPI_Slave_ItsyBitsy is

   -----------------------------------------------------------------------
   --  Slave section
   SPI  : RP.SPI.SPI_Port renames RP.Device.SPI_0;
   MISO : RP.GPIO.GPIO_Point renames ItsyBitsy.GP19;
   NSS  : RP.GPIO.GPIO_Point renames ItsyBitsy.GP5;
   SCK  : RP.GPIO.GPIO_Point renames ItsyBitsy.GP18;
   MOSI : RP.GPIO.GPIO_Point renames ItsyBitsy.GP20;

   Config : constant RP.SPI.SPI_Configuration
     := (Role   => RP.SPI.Slave,
         Baud   => 10_000_000,
         Data_Size => HAL.SPI.Data_Size_16b,
         others => <>);

   procedure Initialize;

end SPI_Slave_ItsyBitsy;
