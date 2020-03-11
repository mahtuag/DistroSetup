#!/usr/bin/python3

#
# NOTE: This script is a work in progress
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


def auto_detect_root_boot(username: str) -> [str, str]:
    print('Attempting to find boot and root file systems automatically.')
    print(f'If you mounted them via your filesystem as the user {username}, this should work!')
    base_location = Path('/media').joinpath(username)
    print(f'Checking for directories at {base_location}')
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

    # First modify config.txt
    cfg_entry = 'dtoverlay=dwc2'
    cfg_path = bootfs.joinpath('config.txt')
    print(f'Checking for {cfg_entry} in {cfg_path}')
    with open(cfg_path, 'r') as cfg_file:
        cfg = cfg_file.read()
    if cfg_entry not in cfg:
        print(f'Did not find {cfg_entry} in {cfg_path}. Adding it now...')
        with open(cfg_path, 'a') as cfg_file:
            cfg_file.write(cfg_entry)
    else:
        print(f'Found {cfg_entry} in {cfg_path}. Nothing to do here!')

    # Next modify cmdline.txt
    add_cmdline = 'rootwait modules-load=dwc2,g_ether '
    cmdline_path = bootfs.joinpath('cmdline.txt')
    print(f'Checking for {add_cmdline} in {cmdline_path}')
    with open(cmdline_path, 'r') as cmdline_file:
        cmdline = cmdline_file.read()
    if add_cmdline not in cmdline:
        print(f'Did not find {add_cmdline} in {cmdline_path}. Adding it now...')
        cmdline = cmdline.replace('rootwait ', 'rootwait modules-load=dwc2,g_ether ')
        with open(cmdline_path, 'w') as cmdline_file:
            cmdline_file.write(cmdline)
    else:
        print(f'Found {add_cmdline} in {cmdline_path}. Nothing to do here!')


def ensure_wifi(bootfs: Path) -> None:
    pass


def setup() -> None:
    print('Setting up a Raspberry Pi Zero(-W(H))')
    print('This script only runs on Linux!')
    username = os.getenv('USERNAME')
    rootfs, bootfs = auto_detect_root_boot(username)
    if not bootfs:
        exit(1)  # bail out
    ensure_ssh(bootfs)
    ensure_ethernet_gadget(bootfs)
    print('Done setting up Raspberry Pi Zero(-W(H))')


if __name__ == '__main__':
    setup()
