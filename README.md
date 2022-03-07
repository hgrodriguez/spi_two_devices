# SPI 2 devices
Demonstration of two SPI devices Master/Slave using Pico and ItsyBitsy

# Overview of the bread board sections

![Sections on Board](https://github.com/hgrodriguez/spi_two_devices/blob/main/documents/SectionsOfBreadboard.jpeg "Sections of the board")

# Use Cases
1. Master Pico -> Slave Pico
2. Master Pico -> Slave ItsyBitsy
3. Master ItsyBitsy -> Slave Pico
4. Master ItsyBitsy -> Slave ItsyBitsy

# Pin layout Pico
## Master Pico

| Name of line | Pin of Pico | GPIO |
|--------------|-------------|------|
| SCLK | 24 | 18 |
| NSS | 22 | 17 |
| MOSI | 25 | 19 |
| MISO | 21 | 16|

## Slave Pico
| Name of line | Pin of Pico | GPIO |
|--------------|-------------|------|
| SCLK | 24 | 18 |
| NSS | 22 | 17 |
| MOSI | 21 | 16 |
| MISO | 25 | 19 |

# Pin layout ItsyBitsy
## Master ItsyBitsy
| Name of line | Pin of Pico | GPIO |
|--------------|-------------|------|
| SCLK | 5 | 26 |
| NSS | 8 | 29 |
| MOSI | 6 | 27 |
| MISO | 7 | 28 |

## Slave ItsyBitsy
| Name of line | Pin of Pico | GPIO |
|--------------|-------------|------|
| SCLK | 5 | 26 |
| NSS | 8 | 29 |
| MOSI | 7 | 28 |
| MISO | 6 | 27 |
