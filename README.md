# App Library
A lightweight app launcher for macOS.

![App Library Screenshots](~images/header.jpg)

Launchpad hasn't received any significant updates or love from Apple since it was released with Mac OS X Lion in 2011.  App Library aims to fix that oversight.

## Features
- [x] Launch apps
- [x] Launch installed apps
- [x] Search installed apps
- [x] Hide installed apps in the library with a (right) click
- [x] Add custom search scopes to look for installed apps
- [ ] Keyboard navigation
- [ ] Grid view
- [ ] Grouping

## Installation
App Library requires macOS 14.0 or later.\
Download and unzip the latest `App Library.app.zip` [release](https://github.com/ryanslikesocool/AppLibrary/releases/latest).\
Move the app to your Applications folder (and your dock!)

## Known Issues
- Apps that may have multiple installations, such as Unity, are not currently supported.
- App Library cannot be sandboxed due to the way it uses accessibility features to locate the dock icon.
- When the dock is on the right side of the screen, the spacing between the dock and App Launcher is a little wider.  This is *technically* possible to fix with a few magic numbers, but this is really Apple's fault.

## Acknowledgements
[Mouse Finder](https://github.com/neilsardesai/Mouse-Finder) - Dock icon location code
[ExceptionCatcher](https://github.com/sindresorhus/ExceptionCatcher) - Obj-C Exception handling
[SettingsAccess](https://github.com/orchetect/SettingsAccess) - Settings button
