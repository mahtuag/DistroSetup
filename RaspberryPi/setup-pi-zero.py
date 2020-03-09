#!/usr/bin/python3

#
# NOTE: This script is a work in progress
# TODO: Check if steps are already done before executing them
# TODO: Mount/unmount partitions using the udiskie package
#

import os
from pathlib import Path
from sys import exit


def check_partition(location: Path, purpose: str) -> bool:
    print(f'Attempting to use {location} as {purpose} partition')
    print(f'Checking if {location} exists')
    if not location.exists():
        print(f'{location} does not exist!')
        return False
    print(f'Checking if {location} is a directory')
    if not location.is_dir():
        print(f'{location} isn\'t a directory!')
        return False
    return True


def auto_detect_root_boot() -> [str, str]:
    print('Attempting to determine locations automatically...')
    base_location_str = os.getenv('BASEDIR')
    if not base_location_str:
        print('Environment variable "BASEDIR" is empty! Set this to "/media/yourname"')
        exit(1)
    base_location = Path(base_location_str)
    print(f'Checking removable media at {base_location}')
    boot_partition = base_location.joinpath('boot')
    root_partition = base_location.joinpath('rootfs')
    if not check_partition(boot_partition, 'boot'):
        return ['', '']
    if not check_partition(root_partition, 'root'):
        return ['', '']
    print('Detected root and boot partitions successfully!')
    return [root_partition, boot_partition]


def ensure_ssh(bootfs: Path) -> None:
    print('Ensuring SSH is enabled')
    ssh_file = bootfs.joinpath('ssh')
    ssh_file.touch()
    print(f'Created file {ssh_file}')


def ensure_ethernet_gadget(bootfs: Path) -> None:
    print('Ensuring Ethernet Gadget Mode is Enabled')
    cfg_path = bootfs.joinpath('config.txt')
    with open(cfg_path, 'a') as cfg_file:
        cfg_file.write('dtoverlay=dwc2')
    cmdline_path = bootfs.joinpath('cmdline.txt')
    with open(cmdline_path, 'r') as cmdline_file:
        cmdline = cmdline_file.read()
    cmdline = cmdline.replace('rootwait ', 'rootwait modules-load=dwc2,g_ether ')
    with open(cmdline_path, 'w') as cmdline_file:
        cmdline_file.write(cmdline)


def setup() -> None:
    print('Setting up a Raspberry Pi Zero(-W(H))')
    print('This script only runs on Linux!')
    _, bootfs = auto_detect_root_boot()
    if not bootfs:
        exit(1)  # bail out
    ensure_ssh(bootfs)
    ensure_ethernet_gadget(bootfs)
    print('Done setting up Raspberry Pi Zero(-W(H))')


if __name__ == '__main__':
    setup()
