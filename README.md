# RDR2 DLSS FG Modding Guide

## Prerequisites
- Ensure you are using [Graphic API DirectX 12](https://steamcommunity.com/app/1174180/discussions/0/3762229949248826089/). DLSS-Enabler and OptiScaler require DX12.
- Do not use any upscaled textures mods as they often require Vulkan. DX12 has issues handling large textures, leading to crashes.

## Description
This repository provides a comprehensive guide for enhancing Red Dead Redemption 2 with NVIDIA's Deep Learning Super Sampling (DLSS) and Frame Generation (FG) technology. It includes detailed installation instructions, recommended mods, and troubleshooting tips to optimize your gaming experience.

## Table of Contents
- [RDR2 DLSS FG Modding Guide](#rdr2-dlss-fg-modding-guide)
  - [Prerequisites](#prerequisites)
  - [Description](#description)
  - [Table of Contents](#table-of-contents)
  - [ScriptHookRDR2 V2](#scripthookrdr2-v2)
    - [Purpose](#purpose)
    - [Installation](#installation)
  - [Lenny's Mod Loader RDR](#lennys-mod-loader-rdr)
    - [Purpose](#purpose-1)
    - [Installation](#installation-1)
  - [DLSS-Enabler](#dlss-enabler)
    - [Purpose](#purpose-2)
    - [Installation](#installation-2)
  - [OptiScaler (Deprecated)](#optiscaler-deprecated)
    - [Purpose](#purpose-3)
    - [Installation (Deprecated)](#installation-deprecated)
  - [Stutter Fix](#stutter-fix)
    - [Purpose](#purpose-4)
    - [How to Identify Which Version to Install for Your PC Config](#how-to-identify-which-version-to-install-for-your-pc-config)
  - [Best TAA and Visual Effects (optional)](#best-taa-and-visual-effects-optional)
  - [Scripts](#scripts)
    - [Example Directory Structure](#example-directory-structure)
    - [Using mods.md](#using-modsmd)
    - [Upcoming Content](#upcoming-content)
    - [Resources](#resources)

## [ScriptHookRDR2 V2](https://www.nexusmods.com/reddeadredemption2/mods/1472)
### Purpose
ScriptHookRDR2 V2 is a utility that enables the execution of custom scripts in Red Dead Redemption 2. It facilitates the loading and execution of .asi plugins, thereby enabling various modifications and enhancements for the game.

### Installation
1. Copy and replace the contents of "mods\2-ModLoader\ScriptHookRDR2 V2-*.zip\ScriptHook V2 2.0" into the game's main directory, where RDR2.exe is located.
2. Copy and replace the contents of "mods\2-ModLoader\Mod Loader-*.zip" into the game's main directory, where RDR2.exe is located.

## [Lenny's Mod Loader RDR](https://www.rdr2mods.com/downloads/rdr2/tools/76-lennys-mod-loader-rdr/)
### Purpose
Lenny's Mod Loader (LML) is a robust tool for managing and installing mods in Red Dead Redemption 2. It simplifies the process of adding and removing mods, ensuring compatibility and ease of use.

### Installation
1. Copy all files from the "ModLoader" directory into your RDR 2 game root directory so that files such as vfs.asi are in the same directory as your RDR2.exe.
2. The Mod Manager directory can be located anywhere and does not need to be inside the game directory.
3. New mods should be placed in the lml directory or use the "Download with Mod Manager" button on the mod website if supported (refer to the installation video for an example).

## [DLSS-Enabler](https://github.com/artur-graniszewski/DLSS-Enabler.git)
### Purpose
DLSS-Enabler is a tool that enables NVIDIA's Deep Learning Super Sampling (DLSS) technology in games that do not natively support it. DLSS utilizes AI to upscale lower-resolution images to higher resolutions, thereby improving performance while maintaining visual quality.

> [!NOTE]
> Ensure you are using [Graphic API DirectX 12](https://steamcommunity.com/app/1174180/discussions/0/3762229949248826089/) as DLSS-Enabler and OptiScaler require DX12. Do not use any upscaled textures mods as they often require Vulkan and DX12 has issues handling large textures, leading to crashes.

### Installation
1. Uninstall the current mod and remove all related artifacts via `uninstall.exe` in the RDR2 game root path.
2. Remove your [RDR2 settings](https://www.pcgamingwiki.com/wiki/Red_Dead_Redemption_2#Configuration_file.28s.29_location).
3. Start the game, go to in-game settings, and perform auto configuration (ensure Rockstar Launcher does not restore cloud settings by disabling cloud sync in the Launcher).
4. Enable DLSS with the preset ultra performance or performance via the in-game settings panel.
5. In the "Advanced" settings, set [Graphic API to DirectX 12](https://steamcommunity.com/app/1174180/discussions/0/3762229949248826089/).
6. Close the game.
7. Install [artur-graniszewski/DLSS-Enabler 3.03.000.0 TRUNK](https://github.com/artur-graniszewski/DLSS-Enabler/releases/tag/3.03.000.0-trunk).
8. Start the game again and check DLSS-Enabler and OptiScaler settings via the overlay `Insert` hotkey.

Alternatively, you can change the Graphics API by editing the `settings.xml` file:
1. Navigate to the configuration file location:
   ```
   C:\Users\<YourUsername>\Documents\Rockstar Games\Red Dead Redemption 2\Settings
   ```
2. Open the `system.xml` file with a text editor like Notepad.
3. Find the line that specifies the graphics API:
   ```xml
   <API>kSettingAPI_Vulkan</API>
   ```
4. Change `Vulkan` to `DX12`:
   ```xml
   <API>kSettingAPI_DX12</API>
   ```
5. Save the file and close the text editor.
6. Launch the game.

For more details, you can refer to this guide: [Change RDR2 Graphics API (Vulkan/DX12) using Notepad](https://www.techrbun.com/change-rdr2-graphics-api-vulkan-dx12-using-notepad/).

## [OptiScaler](https://github.com/cdozdil/OptiScaler.git) (Deprecated)
### Purpose
OptiScaler is a tool designed to enhance the visual quality and performance of games by optimizing the scaling algorithms. It supports FrameGenerator (FG) and provides superior upscaling techniques.

> [!NOTE]
> FrameGenerator (FG) is currently an experimental feature and is available in the pre-release. You can find the pre-release versions in the [tags](https://github.com/cdozdil/OptiScaler/tags).

### Installation (Deprecated)
1. Download the release with FG support from the repository.
2. Extract the release archive and rename "nvngx.dll" to "dlss-enabler-upscaler.dll".
3. Copy and overwrite the entire contents of the release directory into the game root directory.
4. Run "DlssOverrides\EnableSignatureOverride.reg".

## [Stutter Fix](https://www.nexusmods.com/reddeadredemption2/mods/1502)
### Purpose
This mod increases the memory pools related to texture streaming to help mitigate stuttering issues since the Naturalist update by allocating more VRAM for texture streaming.

### How to Identify Which Version to Install for Your PC Config
1. **Start with the Smallest Poolsize (3750)**: This is the safest option and uses the least VRAM.
2. **Increase Gradually**: If stuttering persists, try higher pool sizes (4500, 6000, etc.).
3. **Monitor Performance**: Ensure the pool size does not exceed your available VRAM to avoid errors.

For more detailed information, refer to the mod description.

## [Best TAA and Visual Effects (optional)](https://www.nexusmods.com/reddeadredemption2/mods/2188)

The rest of the preferred mods are available in [mods.md](./mods.md).

## Scripts
This repository includes several PowerShell scripts to assist with mod management and installation:

- `Convert-CSVMarkdown.ps1`: Converts between CSV and Markdown formats for a list of hyperlinks with titles and paragraphs/sections. This script includes a verbose flag for detailed logging and a default file argument for the source file.
- `Create-Subdirs.ps1`: Creates subdirectories in a target directory based on a list of directory names provided in a separate file. This script includes verbose logging and prints each action for parsing, changing values, creating directories, and handling errors.
- `rdr2-helper.ps1`: Checks for the installation of Red Dead Redemption 2 on different PC platforms (Steam, Rockstar Games Launcher, Epic Games Store). If the game is not found in the default paths, it searches for the game directory on the C drive and all available drives. It supports verbose logging and can copy the game directory path to the clipboard.

### Example Directory Structure
The `Create-Subdirs.ps1` script generates a directory structure for all mods based on each check as steps. This helps ensure that each step is completed before moving on to the next part of the mod installation process.

[Create-Subdirs-tree.log](./output/Create-Subdirs-tree.log)

### Using mods.md
The `mods.md` file is designed to help you keep track of the mods you have installed and tested. It includes columns for:

- **Hyperlinks**: Direct links to the mod pages on Nexus Mods.
- **Installed**: Mark the mods you have already installed to avoid losing track.
- **Check**: Manually test if the game is working properly after installing each mod, e.g., through a benchmark in graphical settings.

### Upcoming Content
A gameplay video demonstrating the enhancements and optimizations will be available at a later time.

### Resources
- [Nexus Mods - Red Dead Redemption 2](https://www.nexusmods.com/reddeadredemption2)
- [RDR2 Mods](https://www.rdr2mods.com/downloads/rdr2/)
- [PCGamingWiki - Red Dead Redemption 2](https://www.pcgamingwiki.com/wiki/Red_Dead_Redemption_2)
- [Reddit - RDR2 Recommended Graphical Settings](https://www.reddit.com/r/PCRedDead/comments/yn4jhz/rdr2_overall_recommended_graphical_settings/)
- [YouTube - RDR2 Graphical Settings](https://www.youtube.com/watch?v=Hyzp4zRivis)
- [YouTube - I modded RDR2 into a PERFECT GAME | Synth](https://www.youtube.com/watch?v=WBGLf3T6-hc)