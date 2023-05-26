# App Library
An app library for macOS.

![App Library Screenshots](~images/header.jpg)

Launchpad hasn't recieved any significant updates (or love) from Apple since it was released with Mac OS X Lion in 2011.  App Library aims to fix that oversight.

## Features
- [x] Launch apps
- [x] Search installed apps
- [x] Hide and show apps in the library with a (right) click
- [x] Add and remove search scopes to look for installed apps
- [ ] Grid view
- [ ] Group by app category

## Known Issues
- App Library cannot be sandboxed due to the way it uses accessibility features to locate the dock icon.
- App Library currently only works with the dock on the bottom of the screen.

## Installation
App Library requires macOS 13.0 to run.\
Download and unzip the latest `App Library.app.zip` [release](https://github.com/ryanslikesocool/AppLibrary/releases/latest).\
Move the app to your Applications folder, and your dock!

## Acknowledgements
[Settings](https://github.com/sindresorhus/Settings) - Settings pane\
[Mouse Finder](https://github.com/neilsardesai/Mouse-Finder) - Dock icon location code