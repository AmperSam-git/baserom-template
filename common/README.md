# Common Tools and Patches

This `common` folder is where you will place any or all ASM patches, blocks, sprites, etc. and the tools needed to apply them so everything you need for your Base ROM is in one convenient place. Empty folders required by the tools have been pre-made and will be encountered when you add the tools into this folder in later steps.


## Download A Basic Toolkit

For applying custom code and patches to your Base ROM there is a basic set of tools one usually needs:

    > AddKMusic: a tool for inserting custom music into your ROM
    > Asar: an assembler for applying patches to your BaseROM
    > Floating IPS (Flips): creates and applies BPS patches
    > Gopher Popcorn Stew (GPS): a custom block insertion tool
    > Lunar Magic: the essential level editor for SMW hacking
    > PIXI: a sprite insertion tool
    > UberASM: a tool for inserting level, overworld, game mode, status bar, sprite and global ASM without using a patch

Download links have been provided to download all of those tools. (At the time of writing, the tools' versions were: AddKMusic # 1.0.8, asar # 1.71, GPS # 1.4.1, PIXI # 1.32, and UberASM Tool 1.4, Lunar Magic # 3.30, Floating IPS # 1.31)


## Setting Up Tools

These tools all come with additional documentation, files and so forth that aren't needed for general hacking, you are free to copy everything from these tools into the `common` folder but the following instructions only specify what is necessary.


### 1. Asar

When downloading Asar, copy only `asar.exe` to the `common` folder. The folder `asar` is pre-made in this folder for you to store any global, Asar-required patches.

**List File**

    list_asar.txt
    - a file where you can list the patches for use with Asar from the `asar` folder
     for use with `apply_patches.bat`

### 2. GPS

From the downloaded ZIP of GPS, copy only the following into the `common` folder (replacing & merging if prompted):
 
    - blocks
    - routines
    - gps.exe
    - asar.dll
    - defines.asm
    - main.asm

**List File**

    list_gps.txt
    - the custom block list for GPS where you list blocks by Map16 tile number and 
    references to the block ASM as usual, e.g. '0200 custom_block.asm' etc.


### 3. PIXI

From the downloaded ZIP file of PIXI, copy only the following into the `common` folder (replacing & merging if prompted):

    - asm
    - cluster
    - extended
    - generators
    - routines
    - shooters
    - sprites
    - asar.dll
    - Newtonsoft.Json.dll
    - pixi.exe
    - CFG Editor.exe

CFG Editor is a tool included with PIXI for tweaking configuration files of custom sprites.

**List File**

    list_pixi.txt
    - the custom sprite list file for PIXI and can be filled in in the same fashion as
     the regular one, e.g. '00 custom_sprite.cfg/.json' etc.


### 4. UberASM

From the downloaded UberASM ZIP file, copy only the following into the `common` folder (replacing & merging if prompted):

    - asm
    - gamemode
    - level
    - library
    - other
    - overworld
    - asar.dll
    - UberASMTool.exe
    - UberASMTool.pub

**List File**

    list_uberasm.txt
    - a copy of the UberASM list file, where you can specific various patches to be
     applied to your ROM. 
    - IMPORTANT: rename '[YOUR ROM]' in this list file to what you named your base 
    ROM file.

### 5. AddKMusic

AddKMusic is self-contained, extract the whole ZIP file for this tool to it's own folder here in `common`.

### 6. Lunar Magic

The restore, backup and exports scripts need Lunar Magic to work, placing a copy of `Lunar Magic.exe` in this folder will set that up.

### 7. Floating IPS

Include a copy of `flips.exe` here.


## Adding Custom Assets

Instructions for adding custom assets for use with these individually also apply to this bundled folder structure, i.e. copying blocks, sprites, patches, extra folders, etc. remains as easy as copying things into their respective folders in the `common` folder and updating the appropriate list files.