with HAL.SPI;

with RP.Device;
with RP.GPIO;
with RP.SPI;

with ItsyBitsy;

package SPI_Slave_ItsyBitsy is

   -----------------------------------------------------------------------
   --  Slave section
   SPI  : RP.SPI.SPI_Port renames RP.Device.SPI_1;

   SCK  : RP.GPIO.GPIO_Point renames ItsyBitsy.GP26;
   NSS  : RP.GPIO.GPIO_Point renames ItsyBitsy.GP29;
   MOSI : RP.GPIO.GPIO_Point renames ItsyBitsy.GP28;
   MISO : RP.GPIO.GPIO_Point renames ItsyBitsy.GP27;

   Config : constant RP.SPI.SPI_Configuration
     := (Role   => RP.SPI.Slave,
         Baud   => 10_000_000,
         Data_Size => HAL.SPI.Data_Size_16b,
         others => <>);

   procedure Initialize;

end SPI_Slave_ItsyBitsy;
