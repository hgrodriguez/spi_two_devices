with HAL.SPI;

with RP.Device;
with RP.GPIO;
with RP.SPI;

with ItsyBitsy;

package SPI_Master_ItsyBitsy is

   -----------------------------------------------------------------------
   --  Master section
   SPI  : RP.SPI.SPI_Port renames RP.Device.SPI_1;
   MISO : RP.GPIO.GPIO_Point renames ItsyBitsy.GP28;
   NSS  : RP.GPIO.GPIO_Point renames ItsyBitsy.GP29;
   SCK  : RP.GPIO.GPIO_Point renames ItsyBitsy.GP26;
   MOSI : RP.GPIO.GPIO_Point renames ItsyBitsy.GP27;

   Config          : constant RP.SPI.SPI_Configuration
     := (Role   => RP.SPI.Master,
         Baud   => 10_000_000,
         Data_Size => HAL.SPI.Data_Size_16b,
         others => <>);

   procedure Initialize;

end SPI_Master_ItsyBitsy;
