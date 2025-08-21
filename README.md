
<div align="center">

<img width="125" height="125" alt="Icons-iOS-Default-1024x1024@1x" src="https://github.com/user-attachments/assets/9e0f42ea-9168-4893-8d06-ad55b94fb6f6" />

<h2><strong>Iota</strong></h2>
  
![](https://img.shields.io/badge/-Swift-informational?style=flat&logo=swift&logoColor=white&color=007AFF)
![](https://img.shields.io/badge/-SwiftUI-informational?style=flat&logo=swift&logoColor=white&color=AF52DE)
![](https://img.shields.io/badge/-SwiftData-informational?style=flat&logo=swift&logoColor=white&color=AF52DE)
![](https://img.shields.io/badge/-iOS-informational?style=flat&logo=apple&logoColor=white&color=FF8C00)

</div>

> ⚠️ **Caution**
> 
> This repository represents an early‑stage project. The codebase is evolving rapidly and major refactors are expected. APIs, folder names and internal structures may change without notice. If you build on top of Iota today, be prepared to rebase often.

<img width="5507" height="1577" alt="Light Banner from Rayan App Resources" src="https://github.com/user-attachments/assets/30ef3dbc-3873-431a-aa1e-bdbce6840542" />

## Overview

A light hearted iOS app for taking pictures and logging interesting things you see (Ideation)

## Prerequisites

This project targets cutting‑edge Apple platforms and requires recent tooling:

- **Xcode 26.0 or later** – the project uses SwiftUI features only available in Xcode 26
- **iOS 26.0 or later** – while backports exist for some APIs, many views depend on iOS 26 glass effects and tab bar behaviours
- **Swift 6.0 or later** – asynchronous functions, `@Observable` and other Swift 6 features are heavily used

> ⚠️ Earlier versions of Xcode or iOS might compile parts of the code, but you will lose animations, glass effects and other modern UI elements. Be aware that running on older devices is not a project goal at this time.

## Project Structure

Iota uses a **numbered directory scheme** to convey logical and chronological order. Each top‑level folder begins with a numeral followed by its name:

### 📁 1 Resources
Static assets and support files:
- **Designs:** reusable layout styles and backgrounds
- **Assets.xcassets:** images, icons and colours
- **Standards:** constants, helpers, modifiers and backport wrappers
- **Backports.swift:** compatibility helpers for older OS versions
- **Keys.xcconfig:** environment variables such as your PostHog key

### 📁 2 Managers
The business logic layer. Managers encapsulate networking, data caching and state handling:

- **ManagerCoordinator:** orchestrates data loading across managers at app start

> 📖 The `1 ARCHITECTURE.md` file in this folder contains an in‑depth explanation of the MVVM‑C approach and design patterns.

### 📁 3 Components
Reusable SwiftUI building blocks such as buttons, input fields, profile pictures and web views. These encapsulate styling and behaviour for composition in multiple contexts.

### 📁 4 Features
Self‑contained feature modules. Each feature exposes a SwiftUI view and, if necessary, its own manager(s):

- **TabBar:** bottom navigation and sheet presentation

### 📁 5 Views
Top‑level screens composed from components and features:

- **1 Tabs:** home, explore, notifications and user profile tabs
- **2 Sheets:** modals such as compose, profile and settings
- **3 Screens:** navigation flows for authentication and onboarding
- **RouterView.swift:** central router for screen selection based on app state

> 💡 The numbering convention ensures foundational files appear first in Xcode's navigator. While renaming is possible, it requires adjusting target settings in Xcode.

## Development Notes

- **SwiftUI previews:** every view includes `#Preview` with representative dummy data
- **Clean, modular files:** each Swift file defines a single type or cohesive extensions. Use `// MARK:` comments for section separation
- **Asynchronous patterns:** managers use `async/await`, `Task` and `AsyncStream` without blocking the main thread
- **Error handling:** API calls use `do/catch` with user feedback and haptic signals, degrading gracefully
- **Analytics opt‑in:** PostHog tracking enabled by default if key is provided. Ensure privacy policy compliance

## License

This project is released under a dual license-policy framework. See `LICENSE.md` and `POLICY.md` for full details.

<img width="5507" height="1635" alt="Banner Design Aug 19 2025" src="https://github.com/user-attachments/assets/1b0a317d-2770-4b46-ae90-6cf947a59e66" />
