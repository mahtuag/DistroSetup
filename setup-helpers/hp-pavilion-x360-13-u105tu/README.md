# HP Pavilion x360 13-u105tu

I own a HP Pavilion x360 13-u105tu laptop with a touchscreen. Here are fixes
for quirks in the laptop.

## WiFi Does't Work

For some reason, the kernel module ```acer-wmi``` gets loaded when it has no
reason to be active on a non-Acer laptop. This module screws with the wireless
interface.

My hypothesis is that because laptop has an acer-sourced touchscreen, device
detection code somewhere labels my laptop as an acer and loads this module.

The fix is to disable this offending kernel module and blacklist it.

Now you can restart NetworkManager and the wireless interface shouldn't cause
any more troubles.

```bash
sudo modprobe -r acer-wmi
sudo echo "blacklist acer-wmi" >> /etc/modprobe.d/blacklist.conf
sudo systemctl restart NetworkManager.service
```

