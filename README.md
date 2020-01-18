# OpenOCD Toolkit

This contains the files required to use the Raspberry Pi as a programmer on GPIO24 and GPIO25.  

## Directory Stucture

```
openocd
  ./firmware  - contains bin files
  ./interface - contains config files for openocd
  ./target    - contains atsamd21 for openocd
```


## Prepare Build Environment (for OpenOCD)

```
sudo apt install gcc-arm-none-eabi dirmngr libtool autoconf libusb-dev
```

**Clone the OpenOCD repository**

Note: (as of writing 322d2fa12c9b5520e06c1d581ce8b4e3c75750ca):

```
git clone https://git.code.sf.net/p/openocd/code openocd-code
cd openocd-code
./bootstrap
./configure --enable-sysfsgpio --enable-bmc8235gpio
make
sudo make install
```

## Usage

**Note:** Remember to update openocd.cfg before uploading.  Make sure correct bootloader/firmware is being uploaded.

```
sudo openocd
```

## Example Usage - Arduino Bootloader

Lets flash the Arduino Zero (or Adafruit Feather m0) bootloader:

```
cd openocd
wget -O samd21_sam_ba.bin https://github.com/arduino/ArduinoCore-samd/blob/master/bootloaders/zero/samd21_sam_ba.bin?raw=true
openocd -f bootloader.cfg
```

## Padding File

OpenOCD does not allow for uploading of bin files without a firmware attached.  To overcome this, all firmware (CircuitPython, Seesaw, etc) needs to be padded by 0x2000 bits (8 kbytes) for the bootloader.  Use below if you plan on using OpenOCD for uploading new firmware.

```
truncate -s 8192 samd21_sam_ba.bin; cat samd21_sam_ba.bin firmware.bin > boot-firmware.bin
```

* samd21_sam_ba.bin - bootloader
* firmware.bin - firmware binary (CircuitPython, Seesaw, etc)
* boot-firmware.bin - output file to be uploaded using `sudo openocd`