UABEA Quest Preview 0.1
This is an early partial port, NOT full UABEA
This is a real Android ARM64 asset-tool build using AssetsTools.NET, the managed asset backend used by desktop UABEA. It has a new native Android interface. It is not a finished port of UABEA's Avalonia desktop interface or plugins and does not meet full-feature parity. It is unrelated to the Nebula demo APK from earlier in this conversation.

Not device-tested: Android compilation and synthetic backend tests passed. Installation, launch, document-provider interactions, memory use and controller pointer interaction on Quest remain untested. No Android emulator test was performed.

Included functionality
Feature	Status
Android document picker	Implemented using Android Storage Access Framework; on-device behavior untested
Open standalone Unity serialized assets file	Implemented; synthetic version-17 test passed
List object name, class, Path ID and byte size	Implemented; type/name resolution depends on file metadata/class database
Search/filter entries	Implemented; first 5,000 matching rows are displayed
Field/type-tree inspection	Read-only; embedded type tree or compatible bundled class database required; display capped at 4,000 fields / depth 48
Export raw object bytes	Implemented; synthetic test passed
Import replacement raw object bytes	Implemented as staged replacements; caller must supply correct binary layout
Save serialized assets copy	Implemented; synthetic export/reopen test passed; never automatically rewrites input
UnityFS bundle browsing	Implemented through backend; synthetic uncompressed and LZ4 tests passed
Export bundle entry	Implemented; synthetic byte-for-byte tests passed
Open serialized assets inside a bundle	Implemented; edited assets can be saved as a separate assets file, not repacked into the bundle
Texture previews/import/export and codec tools	Not implemented
Audio/font plugins	Not implemented
Structured value editing	Not implemented; read-only field tree only
Bundle repacking/recompression	Not implemented
Automatic dependency workspace / container mapping	Not implemented
Desktop plugin compatibility	Not implemented
APK extraction, patching, signing or game installation	Not implemented
Immersive VR / tracked wrist UI	Not implemented; intended to run as a flat Android app window
A parsed file is not necessarily a valid or safe game resource after arbitrary raw replacement. There is no semantic repair, guaranteed Unity-version coverage, or assurance that a game will accept the output.

Download contents
UABEA-Quest-Preview.apk: the separately supplied sideloadable APK, package org.community.uabea.questpreview, version 0.1.0, Android API 26 minimum / API 34 target, ARM64 only.
UABEA-Quest-Preview-Source.zip: source, backend assembly, bundled class database, licences and synthetic tests.
UABEA-Quest-Preview-APK.zip: APK plus this README and the notices, for convenient download.
The APK is development-signed, not store-certified. No APK from a game is included. The community component of the package identifier is a namespace label, not evidence of a registered organisation or official community endorsement.

Install on Quest — three steps
Enable Developer Mode through Meta's official account/device setup, connect the headset to your computer by USB data cable, and approve USB debugging on the headset.
With Android platform-tools installed and the APK in the current folder, run adb install -r UABEA-Quest-Preview.apk (Windows from platform-tools: .\adb.exe install -r .\UABEA-Quest-Preview.apk; macOS/Linux: ./adb install -r ./UABEA-Quest-Preview.apk).
Open UABEA Quest Preview from the headset's Unknown Sources app list; location varies with Horizon OS.
This build requires a system document picker/provider. If your Quest does not expose a usable provider, file opening may fail; that remains a real compatibility gate, not something the compilation test proves. Follow Meta's actual eligibility/account requirements. Do not bypass restrictions or disable security to install it.

Official device setup: https://developers.meta.com/vr/documentation/native/android/mobile-device-setup/

Platform-tools: https://developer.android.com/tools/releases/platform-tools

Uninstall using device app controls or adb uninstall org.community.uabea.questpreview. Uninstalling removes this app's private cache/data, not a game's files.

Use
Put an assets file or supported UnityFS bundle you are entitled to inspect in a location exposed by your device's document picker, such as Downloads. An APK is not itself an assets file. This tool does not extract an APK or read a game's protected private storage.
Select Open file, choose the document and wait. Inputs are copied into private app cache so URI-backed/non-seekable documents can be parsed safely as seekable streams.
Tap a row to select it. View / open shows its read-only field tree or opens a bundle's serialized assets entry. Unsupported types produce an error rather than a fabricated preview.
Select Export raw to save the selected object's bytes, or a bundle entry's bytes, to a document destination you select.
Inside an assets file, Import raw stages a binary replacement for the selected object. It does not interpret PNG/audio/font files. Supplying an image file as a raw Texture2D object replacement is generally not valid.
Select Save assets copy to write a new serialized assets file. If editing an entry from a bundle, this saves that entry separately; it does not modify/repack the bundle.
Reopen and validate the output copy. Keep an untouched original backup. Bundle directory, Open file and Close file ask before discarding staged replacements.
Temporary cached copies may persist until next app launch or cache/data cleanup. Unsaved edits are memory-only and are lost if Android kills/recreates the activity. The preview does not promise background-session recovery. Showing the app in a headset does not imply it has been tested for headset usability.

Limits and safety
Maximum selected input: 128 MiB.
Maximum individual export/replacement object: 128 MiB.
Maximum total staged replacements: 128 MiB.
Bundle expansion guard: 256 MiB based on declared data blocks, checked before full decompression.
These guards are not a guarantee against all malicious files or excessive memory consumption. Backend parsers and metadata loading are not isolated in a security sandbox. Use trusted files and work on copies.
Original input URIs are opened read-only; output uses a separate create-document operation. Do not deliberately select another valuable existing file as an output destination.
No root, broad storage, game-private-data, Internet or other permissions are requested by this build. Android's user-authorized document URI grants are used instead.
Source and build
The upstream snapshot audited was UABEA commit:

057e2f6ae67ebc94a38faca9f946f8577162fa99

Source: https://github.com/nesrak1/UABEA
Backend source: https://github.com/nesrak1/AssetsTools.NET

This preview does not copy UABEA's forms or claim to have ported them. The backend assembly and classdata.tpk were taken from the upstream snapshot. Their provenance/hashes are recorded in 
PROVENANCE.md
; upstream MIT notices are retained. No desktop texture libraries, fonts/icons, or game assets are bundled.

Build environment used: .NET SDK 8.0.428, Android workload 34.0.43, JDK 17, Android platform/build-tools 34. The .NET 8 toolchain was chosen for compatibility with the inspected project; review toolchain support/security status and update before production release.

Install/accept the applicable Android SDK tooling licences using the usual Android SDK process. Then:

Shell

dotnet workload install android
dotnet build UABEA.Quest.csproj -c Release \
  -p:AndroidSdkDirectory=/path/to/android-sdk \
  -p:JavaSdkDirectory=/path/to/jdk17
Build outputs are under bin/Release/net8.0-android/android-arm64/. Configure your own signing key for releases; signing keys are not included. The provided build is development-signed. Rebuilt APKs using a different key cannot update it without uninstalling first.

Run the platform-independent backend tests from the source root:

Shell

dotnet run --project Tests/CoreTests.csproj
Tests use original synthetic serialized-asset/UnityFS fixtures, not game files. They verify name/type/Path ID resolution, field viewing, raw export, staged replacement, saved-copy reopening, close cleanup, uncompressed/LZ4 bundle entry export and embedded-assets navigation. They do not establish compatibility with arbitrary Unity versions, compression formats, real-world bundles or Android runtime behavior.

Remaining full-port work
Validate the Android lifecycle, document providers, launcher and pointer interaction on actual supported Quest OS versions; add error/session recovery.
Port structured editing and validation, text/texture/font/audio workflows and dependency/container management.
Port or replace native codecs for Android ARM64, with a licence and security audit; unsupported codecs must remain clearly unavailable.
Implement bundle save/repack with compression selection and corruption-resistant output handling.
Define an Android-compatible plugin model rather than promising desktop DLL compatibility.
Test a legally obtained matrix of Unity versions, object types, external streamed resources and compression modes; verify outputs independently before claiming parity.
Read 
LEGAL-NOTICES.md
 before use or redistribution. This preview is not an endorsed, audited or finished UABEA release.
