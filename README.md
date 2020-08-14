## Dependencies
- python 3.4 or newer


# Linux/MacOS

## Environment setup
To setup python environment with required tools use:
```
cd <repo directory> 
python3 -m venv venv
source ./venv/bin/activate
pip install -r requirements.txt
```

## Uploading the firmware to MCU
Connect your ESP to USB port. If uploading fails try another port.
Activate virtual environment and run following commands:
```
source ./venv/bin/activate
./upload_firmware.sh -p /dev/ttyUSB0 -t path/to/firmware/partition-table.bin -b path/to/firmware/bootloader.bin -f path/to/firmware/firmware.bin
```
The default port for this script is /dev/ttyUSB0, but if your device is connected to a different one use: -p argument and specify your target port.

## Displaying output
To display output from esp32 serial port, connect your ESP via USB cable and run command:
`picocom /dev/ttyUSB0 --baud 115200 `
You will need picocom installed to run this command. When uploading new firmware, make sure that the serial connection via picocom is closed.

# Windows

## Environment setup

Create directory "venv" in the directory of the repository
Setup python virtual environment:
```
C:\>C:\path\to\PythonDirectory\python -m venv path\to\repository\upload_to_esp-master\venv
```
Go to the directory of the repository:
```
cd C:\>path\to\repository\upload_to_esp-master\
```
Activate the virtual environment:
```
venv\Scripts\activate.bat
```

Install requirements from requirements.txt:
```
pip install -r requirements.txt
```

## Uploading the firmware to MCU
Run upload_firmware.bat with port and an absolute path to a directory containing firmware to be uploaded. When giving the path change all \ to \\\\.
```
upload_firmware.bat COM4 C:\\path\\to\\firmware\\directory\\partition-table.bin C:\\path\\to\\firmware\\directory\\bootloader.bin C:\\path\\to\\firmware\\directory\\firmware.bin
```
Make sure your paths don't contain spaces
You can check which port is your device using in Device Manager.

## Displaying output
To display output from esp32 serial port, connect your ESP via USB cable. Download and run PuTTy. Setup correct serial connection with proper port and baud rate 115200. When uploading new firmware, make sure that the serial connection via PuTTy is closed


