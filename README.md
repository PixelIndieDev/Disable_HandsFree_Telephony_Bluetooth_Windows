# How to Permanently Disable Hands-Free Telephony on Bluetooth Headphones in Windows 10 / Windows 11

![Registry](https://img.shields.io/badge/File-.reg-orange)

If you're using Bluetooth headphones like the Sony WH-1000XM5, WH-1000XM4, or similar, and you're frustrated with Windows 10/11 constantly enabling "Hands-Free Telephony", here's a permanent fix.
Even if you disable Hands-Free Telephony in the Sound Control Panel, it often turns itself back on after reboots, updating or re-pairing. So that's not a working solution.

My method I have not seen that much on the ethernet, so I made a [Reddit post](https://www.reddit.com/user/VibrantPixelDev/comments/1m96ivg/how_to_permanently_disable_handsfree_telephony_on/) in the past and now I made it into a `.reg` file, so you can apply it quickly in case Windows resets the values again.

## Methods
### Automatic (Recommended)
This method installs a Windows Scheduled Task that automatically re-applies the registry fix on every startup, so you never have to think about it again even after Windows updates.

#### Installation / Usage
> [!IMPORTANT]
> The script must be run as Administrator

1. **Download the `ScheduledTask-DisableHands-FreeTelephony.bat` file** from this repository
2. **Right click the file** and run as administrator
3. **Wait** for it to finish
4. **Reboot your pc or turn on and off Bluetooth**

### Uninstall
1. **Download the `ScheduledTask-Removal-DisableHands-FreeTelephony.bat` file** from this repository
2. **Right click the file** and run as administrator
3. **Wait** for it to finish
4. **The task and its files are now deleted**

### Manual
#### Installation / Usage
1. **Download the `.reg` file** from this repository
2. **Double-click the file** to apply the changes to your Windows Registry
3. **Reboot your pc or turn on and off Bluetooth**


------------------------------

The `.reg` and `.bat` files use the solution that I posted [on Reddit](https://www.reddit.com/user/VibrantPixelDev/comments/1m96ivg/how_to_permanently_disable_handsfree_telephony_on/)
