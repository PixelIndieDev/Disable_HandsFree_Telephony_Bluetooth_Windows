# How to Permanently Disable Hands-Free Telephony on Bluetooth Headphones in Windows 10 / Windows 11

![Registry](https://img.shields.io/badge/File-.reg-orange)

If you're using Bluetooth headphones like the Sony WH-1000XM5, WH-1000XM4, or similar, and you're frustrated with Windows 10/11 constantly enabling "Hands-Free Telephony", here's a permanent fix.
Even if you disable Hands-Free Telephony in the Sound Control Panel, it often turns itself back on after reboots or re-pairing. So that's not a working solution.

My method I have not seen that much on the ethernet, so I made a [Reddit post](https://www.reddit.com/user/VibrantPixelDev/comments/1m96ivg/how_to_permanently_disable_handsfree_telephony_on/) in the past and now I made it into a `.reg` file, so you can apply it quickly in case Windows resets the values again.

## Installation / Usage
1. **Download the `.reg` file** from this repository
2. **Double-click the file** to apply the changes to your Windows Registry
3. **Reboot your pc or turn on and off Bluetooth**

------------------------------

## Experimental Method: Actual permanent Hands-Free Telephony disabling
This method prevents Windows Update from automatically re-enabling Hands-Free Telephony by restricting the SYSTEM account's ability to modify the specific registry's.

> [!CAUTION]
> This technique is in testing. While I have found no issues, modifying registry permissions can have unexpected side effects. Proceed with caution. If you find any issues, check the Full Control for the SYSTEM account to restore the permission and please report the issue to this Github.

1. Press Win + R, type regedit, and press Enter
2. Navigate to *HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\BthHFEnum*
3. Right-click the **BthHFEnum folder** -> Permissions -> Advanced.
4. Click Disable inheritance and choose "Convert inherited permissions into explicit permissions on this object."
5. Select **SYSTEM** from the list and click Edit.
6. Uncheck **Full Control** (only **Read** should remain checked).
7. Click OK -> Apply -> OK.

Now we will do the same for BthHFAud

8. Navigate to *HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\BthHFAud*
9. Right-click the **BthHFAud folder** -> Permissions -> Advanced.
10. Click Disable inheritance and choose "Convert inherited permissions into explicit permissions on this object."
11. Select **SYSTEM** from the list and click Edit.
12. Uncheck **Full Control** (only **Read** should remain checked).
13. Click OK -> Apply -> OK.

### What this does:
This prevents the SYSTEM account to be able to set values in those two specific folders.

------------------------------

The `.reg` file uses the solution that I posted [on Reddit](https://www.reddit.com/user/VibrantPixelDev/comments/1m96ivg/how_to_permanently_disable_handsfree_telephony_on/)
