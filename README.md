# SMW Base ROM Template

### "What is a base ROM?"

A base ROM is just a term for a specific collection of patches and custom assets that would get applied to Super Mario World repeated to serve as the "base" for making a ROM hack or series of hacks. For example, the ROMHack Races community has a base ROM for all creators wishing to make a race level, and it is tailored to their requirements so there is consistency across all levels. 

That said, this resource is simply an organization aide and doesn't teach you how to use custom resources with the various tools within, nor any level design, it exists to help you get yourself better organized when creating a base ROM for your Super Mario World hacks.

Also, make note of where you extracted this template, e.g. `C:\Users\YourName\Documents\MyBaseRom`, it will be needed later. 


## Getting Started

### Provide Super Mario World

First, make a copy of your ROM of Super Mario World (SMW) into the main folder of this Base ROM template and rename it however you like, e.g. `MyBaseRom.smc`. (If your copy of Super Mario World has an extension of `.sfc` rename it to `.smc` this prevents minor headaches elsewhere).


### Initialize Your ROM in Lunar Magic

> The following presumes you have Lunar Magic, if not a Download link is provided in `common`.

In Lunar Magic make any small change and save your ROM, this will allow Lunar Magic to setup its restore function which will create the 'sysLMRestore' folder and restore files.

Next, it is useful to extract all Graphics and ExGraphics from your ROM using `File > Graphics > Extract GFX from ROM` and `File > Graphics > Extract ExGFX from ROM` this will populate the 'Graphics' and 'ExGraphics' folders in your main Base ROM folder with SMW graphics files.

It is also common to Expand your ROM to at least 2MB via `File > Expand ROM > Expand ROM to 2MB` to give yourself ample headroom to make changes and add things to your ROM.


## The `common` Folder

This template comes with a `common` folder that collates all commonly used tools and resources you need to apply patches and code to your ROM in one place.

> See The README in that folder for further instructions, before proceeding further.


## Insertion Scripts

To make life easier, this template comes with several scripts to automate the process of applying custom assets to your ROM:
    
    apply_patches.bat
    - runs Asar to apply global patches to your ROM. Note: you must specify
    each patch you intended to use on your base ROM in this script on new
    lines by renaming [Patch] in the script.

    insert_blocks.bat
    -  runs GPS to apply custom blocks to your ROM.
    
    insert_sprites.bat
    - runs PIXI to insert custom sprites to your ROM.

    insert_music.bat
    - runs AddKMusic to insert custom music to your ROM.
    
    insert_uberasm.bat
    - runs UberASM to insert its patches to your ROM.

IMPORTANT: in ALL of these scripts change '[BaseRom File Name]' to what you named your ROM file, e.g. "MyBaseROM" 

If all is setup correctly you can run these scripts on-demand to quickly apply new assets to your ROM or perform a quick backup.

## Backups Scripts

Once you are all set up and have been working on your ROM is it convenient to be able to back up various aspects of your game, as such there's a few backup scripts you are free to use:

    export_levels.bat
    - exports all modified levels from your ROM using Lunar Magic to a timestamped
     'Levels' directory.

    export_map16.bat
    - exports all of Map16 (the entire tile map for custom tiles) from your ROM using Lunar Magic

    export_palettes.bat
    - exports the shared palette from your ROM using Lunar Magic and a timestamps it.
    
    perform_backup.bat
    - performs a time-stamped based backup that will create a snapshot of
     your ROM and restore file in the 'Backup' folder. Requires Flips and the
     Lunar Magic restore system to be set up.

## Clean Up & Finish

You're all set! You can delete this README and the one in `common` plus all Download links if you desire. Now get Hacking!