
# BCAD Music Player

A simple ios music player app built with SwiftUI, allowing users to search for songs via the iTunes Search API, play 30-second previews, and control playback with a persistent player bar. The purpose for this app is only for BCAD tech home test

## App Preview
<img src="docs/screenshots/Screenshot iPhone 17 27-09-2026 at 13.13.48.png" width="250" />
<img src="docs/screenshots/Screenshot iPhone 17 27-09-2026 at 13.13.56.png" width="250" />
<img src="docs/screenshots/Screenshot iPhone 17 27-09-2026 at 13.14.03.png" width="250" />

## Key Features
- Search songs by artist (iTunes Search API)
- Play / pause song preview
- Next / previous song navigation
- Seek playback position via slider
- Auto-play next song when current preview ends
- Loading state indicator
- User-facing error handling (network failure, missing preview, etc.)

## Architecture
This project follows **Clean Architecture** organized into four layers: **Domain**, **Data**, **Presentation**, **Core**
This separation keeps business rules independent of any specific data sources or UI framework 

## Setup & Run

1. Clone this repository (including `.git` metadata, per submission requirement)
2. Open `BCAD Music Player.xcodeproj` in Xcode
3. Build & run (⌘R) on any iOS Simulator

## Testing

Unit tests cover the Domain and Presentation layers using a mock repository (`MockSongRepository`), avoiding real network calls:

- `SearchSongsUseCaseTests` — success and failure cases
- `SongListViewModelTests` — search states (loading/success/error), next/previous song navigation edge cases

Run tests locally via **Product → Test (⌘U)**, scoped to the `BCAD Music PlayerTests` target.

## CI/CD

GitHub Actions (`.github/workflows/ci.yml`) automatically builds the app for iOS Simulator on every push to `main`, and uploads the resulting `.app` as a downloadable build artifact.

## Known Limitations

- **No paid Apple Developer Account** — distribution via TestFlight isn't possible, since it requires Apple Developer Program enrollment. Instead, CI builds and uploads a **Simulator build** as a downloadable artifact, which can be installed via `xcrun simctl install` or by dragging into a running Simulator.
- **Unit tests are not executed inside GitHub Actions CI**, only the build step runs there. This is due to a version mismatch: the project was authored using a very recent Xcode release, while GitHub-hosted runners currently top out at an older Xcode version. This caused the CI runner to be unable to read the project file at all initially. The workaround applied was lowering the project's `objectVersion` (a schema-compatibility number in the `.pbxproj` file) to a value compatible with the runner's available Xcode, which resolved the build step successfully. However, actually *executing* the test suite inside that same CI environment surfaced a separate, deeper compatibility issue in how the older Xcode resolves the scheme's supported simulator destinations — this was not something fixable via straightforward configuration within the available time, so test execution in CI was disabled (`continue-on-error`/removed) as a pragmatic trade-off. **All unit tests pass reliably when run locally in Xcode** (⌘U) — this was verified repeatedly throughout development.
- **Song previews are limited to 30 seconds** 

## Download

Go to the **Actions** tab of this repository → select the latest successful workflow run → download the `BCADMusicPlayer-Simulator` artifact under "Artifacts".
