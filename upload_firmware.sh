#!/bin/bash

set -e

PORT=/dev/ttyUSB0
PARTITION_TABLE=""
BOOTLOADER=""
FIRMWARE=""

help()
{
    printf "Usage: $0 [OPTION]\n"
    printf "\n"
    printf "\n"
    printf "General options:\n"
    printf "  -help Show this help\n"
    printf "  -p <port> - specify port name\n"
    printf "  -t <path> - full path to binary file containing partition table \n"
    printf "  -b <path> - full path to binary file containing bootloader \n"
    printf "  -f <path> - full path to binary file containing firmware \n"
}

process_input_options()
{
    while getopts ":h:p:t:b:f:" opt; do
        case $opt in
            h) help
               exit 0
            ;;
            p) PORT=${OPTARG}
            ;;
            t) PARTITION_TABLE=${OPTARG}
            ;;
            b) BOOTLOADER=${OPTARG}
            ;;
            f) FIRMWARE=${OPTARG}
            ;;
        esac
    done
}

main()
{
    process_input_options "$@"
    # shellcheck disable=SC1033
    if [[ $PARTITION_TABLE == "" ]] || [[ $BOOTLOADER == "" ]] || [[ $FIRMWARE == "" ]]; then
        echo "ERROR! Give all arguments!"
        help
        exit 1
    fi
    
    echo "Writing to Port: $PORT"

    read -n 1 -s -r -p "Press any key to continue"
    printf "\nErasing flash"
    esptool.py --port "$PORT" erase_flash || exit 1
    echo "Flashing firmware"
    esptool.py --chip esp32 -p "$PORT" -b 460800 --before=default_reset --after=hard_reset write_flash --flash_mode dio --flash_freq 40m --flash_size 2MB 0x8000 "$PARTITION_TABLE" 0x1000 "$BOOTLOADER" 0x10000 "$FIRMWARE"
}

main "$@"
