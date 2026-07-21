# Clean Up Project for Portable Devices (Android & iOS) Only

This plan outlines the removal of all non-portable platform files (Linux, macOS, and Web) and the restoration of a properly configured `.metadata` file.

## Proposed Changes

### Project Root

#### [DELETE] [linux](file:///C:/Users/Simon CHARVET/Documents/Projects/MyECoach/linux)
Delete the `linux/` directory.

#### [DELETE] [macos](file:///C:/Users/Simon CHARVET/Documents/Projects/MyECoach/macos)
Delete the `macos/` directory.

#### [DELETE] [web](file:///C:/Users/Simon CHARVET/Documents/Projects/MyECoach/web)
Delete the `web/` directory.

#### [NEW] [.metadata](file:///C:/Users/Simon CHARVET/Documents/Projects/MyECoach/.metadata)
Create a new `.metadata` file tracking only `root`, `android`, and `ios` for the Flutter migration tool.

## Verification Plan

### Manual Verification
- Verify that only `android/`, `ios/`, `lib/`, and `test/` (plus hidden files) remain in the project structure.
- Run `flutter devices` to confirm only mobile/portable targets are relevant.
