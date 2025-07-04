# Frequently Asked Questions (FAQ)

## General Questions

### Q: "This sounds too complicated - why 6+ components for Frame Generation?"

**A:** Each component serves a specific technical purpose in the DLSS/FG stack:

- **ScriptHookRDR2 V2 & Lenny's Mod Loader**: Enable mod loading capabilities and ASI plugin execution
- **DLSS-Enabler**: Provides DLSS injection with precise version compatibility requirements
- **OptiScaler**: Essential Frame Generation engine with specialized compatibility layers
- **DLSS-Swapper**: Upgrades native DLSS libraries for better performance
- **Stutter Fix & Visual Mods**: Prevent memory-related crashes and optimize performance

This isn't arbitrary complexity - it's the technical stack required for stable operation. The alternative is waiting indefinitely for official developer support, which may never come.

### Q: "Why not just wait for official developer support?"

**A:** While official support would be ideal, this solution works **today** and provides immediate benefits. The modding community has consistently delivered features that developers never implement. RDR2 has been out for years without official DLSS/FG support, making community solutions the only viable option.

### Q: "What about Pure Dark's version or cracked alternatives?"

**A:** "Pure Dark's version" refers to cracked DLSS implementations. I don't recommend these due to:
- **Legal concerns**: Violates software licenses
- **Security risks**: Unverified code from unknown sources
- **No support**: No documentation or community assistance
- **Stability issues**: Often less stable than legitimate solutions

The open-source solution I provide is legitimate, actively maintained, and has community support.

---

## Technical Questions

### Q: "How do I know it's working? I still only see FSR2 in the game menu."

**A:** DLSS options **won't appear in game menus** by design. This is normal behavior for DLSS injection. Here's the correct verification process:

1. **In-Game Setup**:
   - Enable any upscaling option in RDR2 settings (FSR2, DLAA, etc.)
   - Set Graphics API to DirectX 12 (not Vulkan)

2. **Access DLSS Controls**:
   - Press **`Insert`** key to open DLSS-Enabler overlay
   - Configure DLSS/Frame Generation settings in the overlay interface
   - You'll see DLSS options and Frame Generation toggles here

3. **Verification**:
   - Monitor FPS increase when DLSS is enabled
   - Check GPU usage and frame time improvements
   - Use the overlay to verify active DLSS mode

### Q: "Does this work with Vulkan API?"

**A:** **No, DirectX 12 only.** DLSS-Enabler and OptiScaler require DirectX 12 API. Vulkan is not supported. You must:
- Set Graphics API to DirectX 12 in game settings
- Avoid texture mods that require Vulkan
- Ensure your system supports DX12

### Q: "Is OptiScaler deprecated?"

**A:** **Absolutely NOT deprecated!** This confusion arose because:
- The old repository (`cdozdil/OptiScaler`) moved to a new location (`optiscaler/OptiScaler`)
- Some outdated guides still reference the old repository
- OptiScaler is **essential** for Frame Generation functionality
- Must be manually updated to latest nightly builds for stability

### Q: "What's the difference between trunk and standard DLSS-Enabler releases?"

**A:** Critical differences for RDR2 stability:

**Standard Release Issues**:
- Frequent crashes within seconds when Frame Generation enabled
- Memory access violations on RTX 30-series cards
- Visual ghosting artifacts on textures
- Outdated OptiScaler integration

**Trunk Release Benefits**:
- Significantly improved stability
- Better compatibility with RDR2's engine
- More recent OptiScaler integration
- Active development and bug fixes

---

## Hardware Compatibility

### Q: "Does this work with RTX 50-series cards (5070 Ti, etc.)?"

**A:** **Limited support currently**:

**RTX 50-Series Status**:
- Frame Generation often doesn't work with current method
- **4x Frame Generation** is experimental across all hardware
- Base DLSS upscaling may work, but FG is problematic

**Recommended Hardware**:
- **RTX 30/40-series** have best compatibility
- RTX 3060, 3070, 3080, 4060, 4070, 4080 tested successfully

**RTX 50-Series Performance** (without FG):
- Still excellent performance: RTX 5070 Ti achieves **100+ FPS at 1600p Ultra + DLSS Quality**
- May need to wait for newer DLSS-Enabler versions for FG support

### Q: "What are the minimum system requirements?"

**A:** Based on testing:

**Minimum Requirements**:
- NVIDIA RTX 20-series or newer
- DirectX 12 compatible system
- Windows 10/11 (64-bit)
- 8GB+ VRAM recommended
- 16GB+ system RAM

**Recommended Configuration**:
- RTX 30/40-series GPU
- 12GB+ VRAM
- 32GB+ system RAM
- NVMe SSD for game installation

---

## Installation & Setup

### Q: "The PowerShell version check command doesn't work."

**A:** Common solutions:

1. **Adjust path for your installation**:
   ```powershell
   # Steam (default)
   (Get-ItemProperty "C:\Program Files (x86)\Steam\steamapps\common\Red Dead Redemption 2\dlss-enabler-upscaler.dll").VersionInfo.ProductVersion
   
   # Epic Games Store
   (Get-ItemProperty "C:\Program Files\Epic Games\RedDeadRedemption2\dlss-enabler-upscaler.dll").VersionInfo.ProductVersion
   
   # Rockstar Games Launcher
   (Get-ItemProperty "C:\Program Files\Rockstar Games\Red Dead Redemption 2\dlss-enabler-upscaler.dll").VersionInfo.ProductVersion
   ```

2. **Use the helper script**:
   ```powershell
   .\scripts\rdr2-helper.ps1 -FindLocation
   ```

3. **Manual verification**: Right-click DLL → Properties → Details tab

**Expected OptiScaler Version Output**:
```
0.7.7-pre12 (20250630_211128)
```

> **Note**: This is the latest OptiScaler nightly build as of July 2025. The version includes the build date (20250630) indicating June 30, 2025 compilation.

### Q: "What if I get crashes despite following the guide?"

**A:** Systematic troubleshooting:

1. **Verify Prerequisites**:
   - DirectX 12 API enabled
   - All overlays disabled (Steam, Discord, NVIDIA)
   - Steam Input disabled
   - Antivirus exclusions added

2. **Component Verification**:
   - DLSS-Enabler trunk release installed
   - OptiScaler updated to latest nightly
   - Proper installation method (winmm.dll)

3. **Isolation Testing**:
   - Disable Frame Generation, test DLSS only
   - Start with lowest DLSS preset
   - Remove other mods temporarily

4. **Hardware Monitoring**:
   - Check VRAM usage
   - Monitor temperatures
   - Verify sufficient system RAM

---

## Performance & Optimization

### Q: "What performance gains can I expect?"

**A:** Typical results based on testing:

**4K Gaming (RTX 3060)**:
- **Without DLSS**: 30-40 FPS (High settings)
- **With DLSS Quality**: 45-55 FPS
- **With DLSS + Frame Generation**: 60+ FPS

**1440p Ultrawide (5120x1440)**:
- **DLSS Performance + FG**: Stable 60 FPS
- **Significant** input lag reduction vs. native rendering

**Variables affecting performance**:
- GPU model and VRAM
- In-game settings
- System configuration
- Background applications

### Q: "Should I use other visual mods with this setup?"

**A:** Recommendations:

**Compatible Mods**:
- ✅ Stutter Fix (recommended)
- ✅ Best TAA and Visual Effects
- ✅ Performance-focused mods

**Avoid These Mods**:
- ❌ Upscaled texture packs (require Vulkan)
- ❌ Heavy ENB/ReShade configurations
- ❌ Mods that modify graphics API

**Best Practices**:
- Install DLSS/FG setup first
- Add visual mods one at a time
- Test stability after each addition

---

## Troubleshooting

### Q: "Game won't start after installing DLSS-Enabler."

**A:** Common causes and solutions:

1. **Steam Input Conflict**:
   - Disable Steam Input for RDR2
   - Right-click game → Properties → Controller → Disable Steam Input

2. **Antivirus Interference**:
   - Add game directory to exclusions
   - Temporarily disable real-time protection for testing

3. **Wrong Installation Method**:
   - Use winmm.dll instead of version.dll
   - Verify files are in correct game directory

4. **Missing Dependencies**:
   - Install Visual C++ Redistributables
   - Update DirectX runtime

### Q: "I see the DLSS overlay but Frame Generation option is missing."

**A:** Verification steps:

1. **OptiScaler Update Required**:
   - Download latest nightly build from [OptiScaler Releases](https://github.com/optiscaler/OptiScaler/releases/tag/nightly)
   - Current version: [v0.7.7-pre12_20250630](https://github.com/optiscaler/OptiScaler/releases/download/nightly/OptiScaler_v0.7.7-pre12_20250630.7z)
   - Replace dlss-enabler-upscaler.dll
   - Verify version with PowerShell command: should show `0.7.7-pre12 (20250630_211128)`

2. **Hardware Compatibility**:
   - Confirm RTX 30/40-series GPU
   - Check DirectX 12 support

3. **Configuration Issues**:
   - Reset DLSS-Enabler settings
   - Verify game is running in DX12 mode

---

## Community & Support

### Q: "Where can I get help if something isn't working?"

**A:** Support resources:

1. **GitHub Repository**: 
   - Check existing issues
   - Create detailed bug reports
   - Review troubleshooting logs

2. **Community Forums**:
   - Reddit r/RDR2 community
   - Nexus Mods discussion pages
   - DLSS-Enabler GitHub discussions

3. **When Reporting Issues**:
   - Include system specifications
   - Provide error logs/crash dumps
   - List installed mods
   - Describe exact steps taken

### Q: "Can I contribute to improving this guide?"

**A:** Absolutely! Contributions welcome:

- **Bug Reports**: Detailed crash analysis
- **Hardware Testing**: Results from different GPU models
- **Documentation**: Improvements to clarity
- **Scripts**: Automation enhancements
- **Performance Data**: Benchmarking results

Your feedback helps improve the guide for the entire community!

---

*Last Updated: July 2025 | [Return to Main Guide](README.md)*
