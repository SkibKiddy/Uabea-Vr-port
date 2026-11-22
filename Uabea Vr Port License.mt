# Nebula Demo
## Quest installation tutorial & legal notices

Prepared 21 November 2026 · Applies to **Nebula Demo 1.0.0** only

> **What you are installing:** a separate, offline Android app with a flat 2D menu and movement sandbox. It is **not a Gorilla Tag mod**, modified game APK, multiplayer client, or tracked VR wrist menu. Do not patch Gorilla Tag with it. QuestPatcher, BepInEx and Utilla are not required.

## 1. Download the right file

Download **Nebula-Demo.apk** from this conversation onto your computer. The source ZIP is for developers and cannot be installed as an app.

- App name: **Nebula Demo**
- Android package: `com.nebula.demo`
- Version: `1.0.0` / version code `1`
- Minimum Android version: Android 8.0 / API 26
- Requested Android permissions: **none**
- APK signing: locally generated development certificate; not a Meta/Google store release
- Hardware status: compiled and signature-verified, but **not installed or tested on an actual Quest**

Optional download-integrity check — the exact APK supplied in this conversation has SHA-256:

```text
a7101c346c08315209037bf509bf07d73f7b5b810199187664a3912570526a45
```

On Windows PowerShell:

```powershell
Get-FileHash .\Nebula-Demo.apk -Algorithm SHA256
```

On macOS:

```sh
shasum -a 256 Nebula-Demo.apk
```

On Linux:

```sh
sha256sum Nebula-Demo.apk
```

The checksum detects changes relative to this file; it is not a security audit or store approval.

## 2. Prepare your Quest

You need your headset, its paired phone with the Meta Horizon app, a computer, and a USB-C **data** cable. A charging-only cable will not work.

Follow Meta's current developer setup instructions. Developer mode requires an eligible verified developer account/team; meet Meta's actual age, account and device requirements rather than entering false information. Managed or restricted devices may not permit it. [1](https://developers.meta.com/vr/documentation/native/android/mobile-device-setup/) [2](https://developers.meta.com/vr/documentation/android-apps/enable-developer-mode/)

In the paired Meta Horizon phone app, select your headset, open **Headset Settings → Developer Mode**, and enable it. Labels can change with app updates. Windows may also need Meta's ADB driver; use the driver linked from Meta's official setup page. [1](https://developers.meta.com/vr/documentation/native/android/mobile-device-setup/)

**Do not disable headset security, root the device, or bypass account restrictions. None of that is needed for this demo.**

## 3. Install Android platform-tools

Download Android SDK Platform-Tools from Google's official page:

https://developer.android.com/tools/releases/platform-tools

Extract the archive. Put `Nebula-Demo.apk` inside the extracted **platform-tools** folder to make the commands below easier.

Open a terminal in that folder:

- **Windows:** open the folder in File Explorer and use **Open in Terminal**, or open PowerShell and change directory to it.
- **macOS/Linux:** open Terminal and run `cd` followed by the folder path.

The examples below use `./adb` on macOS/Linux and `.\adb.exe` on Windows, so you do not have to edit your PATH.

## 4. Connect and authorize

1. Connect the powered-on Quest to the computer with the USB data cable.
2. Put on the headset and accept **Allow USB debugging**. Only select **Always allow** if you trust and control this computer. USB file-transfer permission is a different prompt. Meta documents USB authorization as part of app deployment. [3](https://developers.meta.com/vr/essentials/quick-start/)
3. Check the connection.

**Windows PowerShell:**

```powershell
.\adb.exe devices
```

**macOS/Linux:**

```sh
./adb devices
```

You should see a device identifier followed by `device`. Do not post that identifier publicly.

- `unauthorized`: put on the headset and accept USB debugging.
- No device listed: check the data cable, USB port, developer mode and, on Windows, driver.
- More than one device: disconnect other Android devices or use `adb -s YOUR_DEVICE_SERIAL` before the rest of the command. Use the real identifier shown on your computer, not the example text.

## 5. Install the APK

**Windows PowerShell:**

```powershell
.\adb.exe install -r .\Nebula-Demo.apk
```

**macOS/Linux:**

```sh
./adb install -r ./Nebula-Demo.apk
```

Wait for `Success`. Do not disconnect while installation is in progress. Meta documents `adb install` for deploying your own APK. [3](https://developers.meta.com/vr/essentials/quick-start/)

`-r` requests reinstall/update while retaining app data when Android permits it. An update must have a compatible signing key; it cannot override a signature mismatch.

## 6. Open and use Nebula

On your headset, open **Library → Unknown Sources → Nebula Demo**. The exact location of Unknown Sources can vary with Horizon OS. Meta documents that location for sideloaded apps. [2](https://developers.meta.com/vr/documentation/android-apps/enable-developer-mode/)

The app is intended to open in a **flat window**, not an immersive Gorilla Tag scene. Use the headset's system pointer and normal click interaction; no custom controller tracking is implemented.

- **Movement:** five switches affect only the sandbox avatar.
- **Fly:** enable it, then hold **Rise** to increase simulated altitude.
- **Direction buttons:** hold them to move in the preview.
- **Settings → Edit simulation values:** change values and select **Save values on this device**.
- **Drop Menu:** demonstrates a changed panel placement; it does not place a tracked object in your room.
- **Reload Menu:** rereads saved values.
- **Close Menu:** hides the menu; **Open Nebula** brings it back.
- **Disconnect:** resets the simulation. There is no real network connection.

With a keyboard: WASD/arrows move, Space rises when Fly is on, and M hides/shows the menu. Actual pointer hold behavior and launch compatibility must still be confirmed on your headset.

## 7. Troubleshooting

| Problem | What to do |
|---|---|
| `adb` is not recognized | Run the executable from inside platform-tools using the exact `./adb` or `.\adb.exe` form above. |
| `unauthorized` | Unlock/wake the headset and approve USB debugging. |
| `INSTALL_FAILED_UPDATE_INCOMPATIBLE` | An app with the same package name has a different signature. Uninstall it only if you are happy to lose that app's saved data, then install this APK. Do not try to defeat Android signature checks. |
| App not visible | Confirm `Success`, then check Unknown Sources rather than only the main store-app list. |
| App opens blank or closes | Restart the headset and apply normal official OS updates. An available compatible Android System WebView is required. If it still fails, stop and report the headset model, OS version and error. Do not download random WebView APKs or disable platform protection. |
| Movement doesn't work in Gorilla Tag | Expected: this is a separate demo and has no Gorilla Tag integration. |
| You expected a wrist menu | This APK is the separate 2D demo selected in the conversation, not the unfinished Unity mod source kit. |

Compilation, APK signature/alignment checks and desktop browser UI tests passed. **No Android emulator or physical headset test was performed.** Browser tests do not prove Android WebView or Quest compatibility.

## 8. Remove it and revoke access

Uninstall through the headset's app controls, or run:

**Windows:**

```powershell
.\adb.exe uninstall com.nebula.demo
```

**macOS/Linux:**

```sh
./adb uninstall com.nebula.demo
```

Uninstalling normally removes this app's local settings. It does not remove Gorilla Tag or its files. Disconnect the USB cable. If you no longer need development access, disable Developer Mode using Meta's controls and revoke prior USB debugging authorizations where your device provides that option.

---

# Legal, privacy and distribution notices

## A. Scope and independence

Nebula Demo is an experimental, standalone demonstration. It is not made by, sponsored by, approved by, or affiliated with Another Axiom, Gorilla Tag, Meta, or Google. Product names and trademarks belong to their respective owners and are used here to explain compatibility and distinguish products. This is not a finding that a trademark is registered in any particular jurisdiction.

No Gorilla Tag APK, code, game assets, credentials or authentication tokens are included. The supplied APK is the independently built demo, not a repackaged game. Do not market it as an official Gorilla Tag app, an approved mod, or a working multiplayer cheat.

## B. Permitted setup versus platform rules

Use only devices and accounts you own or are authorized to administer. Follow applicable law and the current developer, account, device and store terms that apply to you. The existence of developer mode does not authorize every possible use or distribution of software. This guide does not authorize piracy, bypassing access controls, evading bans, impersonating publishers, or violating someone else's rights.

No representation is made that Meta or another platform has reviewed this APK. No guarantee is made about store acceptance, account outcomes or compatibility. This app has no Gorilla Tag connection; that is not a blanket promise about the consequences of unrelated modifications or activity on your account.

## C. Privacy notice for this build

- **No account or sign-in:** the demo does not ask for your name, email address, game account, password or tokens.
- **No developer-operated backend:** no analytics, ads, telemetry or server endpoints are implemented.
- **No requested Android permissions:** in particular, the app does not request INTERNET, microphone, camera, location or storage permissions.
- **Local settings:** four simulation values are saved in the app's WebView local storage so they can persist between launches. They are not deliberately transmitted by the app.
- **Local interaction state:** toggle states and avatar simulation state are maintained in memory. They are not an account profile.
- **Deletion:** clear the app's storage or uninstall it through device controls to remove its local settings.
- **Platform processing:** Android, Horizon OS, WebView and any sideloading tools have their own behavior and privacy terms. This notice covers the supplied app code, not all processing performed by your device or those tools.

If this software is later changed to collect information, connect to a server, or use analytics, this notice must be reviewed and updated before that version is distributed. This is a technical disclosure for the supplied build, not a claim that every legal privacy obligation in every region has been satisfied.

## D. Experimental software and liability

The demo is supplied for evaluation without a promise of reliability, fitness for a particular purpose, support or continued updates. It may fail to install, crash, lose its settings, or behave differently on your device. Keep important data backed up and stop using it if it causes problems or discomfort.

To the extent permitted by applicable law, no voluntary warranty is offered for this experimental build. **Nothing in these notices is intended to exclude or limit statutory rights or liability that cannot lawfully be excluded or limited**, including applicable liability for fraud or death/personal injury caused by negligence. A disclaimer is not an automatic legal shield; enforceability depends on the facts and applicable law.

## E. Licence and redistribution status

These notices are **not a completed software licence agreement** and do not establish who owns every right in AI-assisted output. No legal determination of authorship, exclusivity, non-infringement or commercial clearance has been made. You have the supplied source for inspection and rebuilding, but these notices do not themselves resolve all ownership or redistribution questions.

Before publishing, selling or distributing a modified build:

1. Identify the actual publisher and any applicable rights holders.
2. Choose an appropriate explicit licence for source and binaries that you are entitled to license, and include its complete text.
3. Audit any added libraries, artwork, fonts, music, code and assets; preserve required attribution/licence notices and meet their conditions.
4. Do not assume access to Android/Meta tools grants rights to third-party games, brands or content. Follow the applicable tool/platform terms.
5. Use your own protected signing key for ongoing releases. Do not reuse or expose signing secrets, and disclose material functionality changes accurately.
6. Review store rules, consumer obligations, privacy requirements and age/account eligibility for your intended audience and distribution route.

The APK uses Android's platform APIs and installed WebView. Android SDK/build tools, Chromium test binaries and the signing private key are **not bundled** with the source archive. This does not replace a full dependency and licence audit before commercial release.

## F. Safety

Use the headset in a clear, safe area. Stop if you experience discomfort. This demo does not provide guardian/boundary protection, supervise children, or override the headset's own safety systems. Keep those systems enabled and follow the manufacturer's guidance.

## G. Not legal advice

This is general installation guidance and draft product-notice wording, not legal advice or an assessment that your intended distribution is lawful. For a public or commercial release, have an appropriately qualified adviser review the licence, rights position, privacy disclosures and terms for your jurisdiction. Do not add a made-up company identity, legal address or support contact; provide genuine publisher details when required.

---

## Official setup references

1. Meta — Device Setup: https://developers.meta.com/vr/documentation/native/android/mobile-device-setup/
2. Meta — Test your app on your device: https://developers.meta.com/vr/documentation/android-apps/enable-developer-mode/
3. Meta — Quick start guide: https://developers.meta.com/vr/essentials/quick-start/
4. Google — SDK Platform-Tools download: https://developer.android.com/tools/releases/platform-tools

Links and user-interface labels may change. Use official documentation if the headset's current screens differ from this guide.
