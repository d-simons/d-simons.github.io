---
layout: page
title: Discord AppImage Builds
permalink: /discord/
---

AppImage builds for **[Discord Stable, PTB, and Canary](https://discordapp.com)**

These Discord AppImages are built using [deb2appimage](https://github.com/simoniz0r/deb2appimage) with dependencies from Debian Jessie's repos.  All necessary dependencies for Discord are bundled in the AppImage, so the Discord AppImages should just work on any system.  These AppImages have been verified to run on Linux distributions as old as CentOS 6 and even as new as a rolling distribution, openSUSE Tumbleweed.

The AppImages for Discord have an `--update` argument built in which will build a new AppImage in your `~/Downloads` directory in case a new release hasn't been updated below yet.

**[Discord Stable AppImage](https://github.com/simoniz0r/Discord-AppImage/releases)**

**[Discord PTB AppImage](https://github.com/simoniz0r/Discord-PTB-AppImage/releases)**

**[Discord Canary AppImage](https://github.com/simoniz0r/Discord-Canary-AppImage/releases)**

To use an AppImage, all you have to do is make it executable and run it!  No install is required, but the AppImages for Discord will prompt if you'd like to add them to your menu for easy access.

Prompt that is shown for adding a menu entry:

![desktopintegration](https://u.teknik.io/DSo4J.png)

How to make an AppImage executable in your file manager:

![executable](https://u.teknik.io/rEZBa.gif)

How to make an AppImage executable in your terminal:

```
chmod +x /replace/me/with/path/to/discord-stable-0.0.4-x86_64.AppImage
```
