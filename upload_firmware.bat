esptool.py.exe --port %1 erase_flash
esptool.py.exe --port %1 --chip esp32 -b 460800 --before=default_reset --after=hard_reset write_flash --flash_mode dio^
 --flash_freq 40m --flash_size 2MB 0x8000^
 "%2"^
 0x1000 "%3"^
 0x10000 "%4"
