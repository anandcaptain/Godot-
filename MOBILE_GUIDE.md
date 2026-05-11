# Mobile Build Guide - Subway Surfers Godot 4.6

## 📱 Mobile Features

### Touch Controls
- **Swipe Left/Right** - Switch lanes
- **Tap Top Half** - Jump
- **Tap Bottom Half** - Slide
- **Responsive** - Automatically detects orientation changes

### Supported Platforms
- ✅ Android (API 21+)
- ✅ iOS (12.0+)
- ✅ Web (HTML5/WebGL)
- ✅ Desktop (Windows, macOS, Linux)

## 🚀 Building for Android

### Prerequisites
1. **Android SDK** - Download from [Android Studio](https://developer.android.com/studio)
2. **OpenJDK 17** - Required for Gradle
3. **Godot 4.6+** with Android export templates

### Steps

1. **Install Export Template**
   - In Godot: `Editor → Export` 
   - Click "Manage Export Templates"
   - Download Android templates for v4.6

2. **Configure Android Export**
   - `Project → Export → New Export Configuration`
   - Select "Android"
   - Fill in:
     - **Package Name**: `com.yourdomain.subwaysurfers`
     - **Application Name**: Subway Surfers
     - **Versions**: Min API 21, Target API 33+

3. **Generate Keystore** (for app store submission)
   - Check "Generate Keystore"
   - Set password and keystore details
   - Save securely!

4. **Export APK**
   - Select "Debug APK" for testing
   - Select "Release APK" for Play Store
   - Click "Export"

5. **Test on Device**
   ```bash
   adb install -r SubwaySurfers.apk
   ```

### Play Store Submission
1. Create [Google Play Console](https://play.google.com/console) account
2. Create new app
3. Fill in app details and screenshots
4. Upload signed APK/AAB
5. Submit for review (24-48 hours)

## 🍎 Building for iOS

### Prerequisites
1. **macOS** with Xcode
2. **Apple Developer Account** ($99/year)
3. **Godot iOS export templates**

### Steps

1. **Install iOS Templates**
   - In Godot: `Editor → Export`
   - Download iOS templates for v4.6

2. **Configure iOS Export**
   - `Project → Export → New Export Configuration`
   - Select "iOS"
   - Fill in:
     - **Bundle ID**: `com.yourdomain.subwaysurfers`
     - **Team ID**: From Apple Developer
     - **Version**: 1.0.0

3. **Export Project**
   - Click "Export" to generate Xcode project
   - Opens Xcode automatically

4. **Build in Xcode**
   - Select your device or simulator
   - Click "Play" to build and run
   - Test thoroughly on device

5. **App Store Submission**
   - Create [App Store Connect](https://appstoreconnect.apple.com) listing
   - Upload build via Xcode
   - Complete app information
   - Submit for review (1-3 days)

## 🌐 Building for Web

### Steps

1. **Install HTML5 Templates**
   - In Godot: `Editor → Export`
   - Download HTML5 templates for v4.6

2. **Configure HTML5 Export**
   - `Project → Export → New Export Configuration`
   - Select "Web"
   - Settings:
     - **Export Type**: Generic
     - **Threads**: Enable (if supported)

3. **Export**
   - Click "Export" → select output folder
   - Generates `.html`, `.js`, `.wasm` files

4. **Host Online**
   - Upload files to web server (GitHub Pages, Itch.io, etc.)
   - Ensure CORS is configured if using WASM

## 📊 Performance Optimization

### Mobile Settings
```godot
# In project.godot
[rendering]
textures/vram_compression/import_etc2_astc=true
global_illumination/sdfgi/enabled=false
rendering/vulkan/rendering/dynamic_resolution/enabled=true
```

### Runtime Optimization
- Disable SDFGI globally (done ✅)
- Enable texture compression (done ✅)
- Use dynamic resolution on low-end devices
- Limit obstacle count to 30 at once
- Optimize coin spawning

## 🔧 Troubleshooting

### Android Issues

**"Gradle build failed"**
- Update OpenJDK to version 17
- Clear Gradle cache: `rm -rf ~/.gradle`
- Regenerate keystore

**"Touch input not working"**
- Check `is_touch_device` detection
- Test in `Project → Export → Debug`
- Verify input map in project.godot

**"App crashes on startup"**
- Check Logcat: `adb logcat | grep godot`
- Verify all assets are included
- Check permissions in AndroidManifest.xml

### iOS Issues

**"Code signing failed"**
- Verify Team ID is correct
- Check provisioning profiles in Xcode
- Update signing certificate

**"App hangs on startup"**
- Check console output in Xcode
- Verify all scenes load correctly
- Test on physical device (simulators can differ)

### Web Issues

**"WASM file not loading"**
- Check server CORS headers
- Verify file permissions
- Test locally: `python -m http.server`

**"Touch not responsive"**
- Check `InputEventScreenTouch` handling
- Verify viewport dimensions
- Test in different browsers

## 📈 Distribution Options

| Platform | Cost | Audience | Process |
|----------|------|----------|----------|
| **Google Play** | $25 one-time | Android users | 24-48h review |
| **App Store** | $99/year | iOS users | 1-3 days review |
| **Itch.io** | Free | Indie gamers | Instant |
| **Web** | Free | Browser users | Instant |
| **Steam** | $100 per game | PC gamers | 2-3 days |

## 🎮 Testing on Devices

### Quick Test Setup
```bash
# Android
adb devices                    # List connected devices
adb install -r app.apk         # Install APK
adb logcat                     # View logs

# iOS
xcodebuild -scheme Subway -configuration Release  # Build
```

### Checklist Before Release
- [ ] Test on 3+ different devices/OS versions
- [ ] Test portrait and landscape modes
- [ ] Verify touch responsiveness
- [ ] Check battery usage (profile in Xcode/Android Studio)
- [ ] Verify audio output
- [ ] Test network permissions (if needed)
- [ ] Confirm save data persists
- [ ] Test app store screenshots look good

## 📝 App Store Screenshots Tips

1. **Gameplay Shots** - Show core mechanics
2. **Score Screen** - Highlight high score feature
3. **Start Screen** - Clear branding
4. **Obstacles** - Show variety and challenge
5. **Mobile Optimized** - No black bars!

Use tools like **Firebase Test Lab** (Android) or **TestFlight** (iOS) for beta testing before official launch.

---

**Next Steps:**
1. Choose platform (Android recommended for starting)
2. Download SDKs and templates
3. Test on device
4. Submit to store!

Good luck! 🚀
