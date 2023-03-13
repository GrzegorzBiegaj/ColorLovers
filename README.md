# ColorLovers

Created by Grzegorz Biegaj

## Project description

ColorLoversList is just an iOS demo app presenting clean code and application architecture.
The main feature of the app is to show patterns, palettes and colours comming from color lovers community.  

### How it works:
- App shows lovers (users) list soted by high rating
- User can select one of the lover
- Depending on the selected tab (patterns, palettes, or colours) picture list will be shown
- By selecting particular picture user can see it on the full screen

NOTE:
- Application uses colour lovers API: http://www.colourlovers.com/api

## Architecture
This project implmenentation is using SwiftUI and async await mechanism

### MVVM
Because of using SwiftUI introduction of MVVM pattern was easy possible

### Unit tests
Most of the possible unit tests exists

### Dependency injection
Because of usage unit tests it was necessary to introduce dependecy injection to separate components.

### Dependencies
No any dependencies and dependeny manager

### Programming tools
Xcode version 14.2, swift version 5.0
