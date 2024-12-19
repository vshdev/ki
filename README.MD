# The KI Operating System
pronounced: "Keey"
By Devin "vano" Caromea

## Why:
this is, from the developer, a Challenge Imposed for the reason of being Fed up with Ultra-Heavy Desktop Operating Systems of Today. If you look at windows 11, it takes around 20GB for the Entire System. Unlike this, Intended to fit on a Single 1.44Mb Floppy Diskette.

## System Details:
Bootloader:
- Kernel is Loaded into Memory Before Called. THis is so the Disk can be removed after Booting.
- Is Written in Assembly, EFI isn't Supported, Logically, As it would take 512 More Unneccesarry bytes of Data for Similar Effect.
Kernel:
- Can Only hold 1 External Process at the same time.
- Unlike UNIX Systems, Theres no need to login to a Root or Custom User.
Filesystem:
- Files are Stored in a Custom Filesystem Called KIFI
