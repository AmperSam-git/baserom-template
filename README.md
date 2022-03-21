# AmperSam's SMW Baserom Template

## "What is a Baserom?"

A "baserom" in hacking jargon is just a term for a specific collection of patches and custom assets that would get applied to Super Mario World repeated to serve as the "base" for making a ROM hack. For example, the ROMHack Races community has a baserom for all creators wishing to make a race level, and it is tailored to their requirements so there is consistency across all levels. 

That said, this resource is simply an organization aide and doesn't teach you how to use custom resources with the various tools within, nor any level design, it exists to help you get yourself better organized when creating a baserom for your Super Mario World hacks or as a blank canvas for starting a new ROM hack project.


## Getting Started

### Provide Super Mario World

First, make a copy of your ROM of Super Mario World (SMW) into the main folder of this baserom template and rename it however you like, e.g. `MyBaseRom.smc`. (If your copy of Super Mario World has an extension of `.sfc` rename it to `.smc` this prevents minor headaches elsewhere).

### Initialize Your ROM in Lunar Magic

In Lunar Magic make any small change and save your ROM, this will allow Lunar Magic to setup its restore function which will create the 'sysLMRestore' folder and restore files.

Next, it is useful to extract all Graphics and ExGraphics from your ROM using `File > Graphics > Extract GFX from ROM` and `File > Graphics > Extract ExGFX from ROM` this will populate the 'Graphics' and 'ExGraphics' folders in your main baserom folder with SMW graphics files.

It is also common to Expand your ROM to at least 2MB via `File > Expand ROM > Expand ROM to 2MB` to give yourself enough headroom to make changes and add things to your hack.

## The common Folder

This baserom comes with [a folder](/common) that helps you organize all commonly used tools, resources you need, patches to apply to your ROM, etc. in one place to keep the main directory of your project neat and tidy and streamline your workflow.

See The [README](/common/README.md) in that folder for further instructions, before proceeding further.

## Helpful Scripts

To make life easier for you as a hacker, this baserom comes some helpful scripts to automate the process of applying additional custom assets to your ROM as well as for backing things up and creating a patch for distribution.

- `@baserom_filename.bat` Simply a way to specify what you have called your ROM file for all the scripts.
- `@build_baserom.bat` Does a lot of the work for you when it comes to inserting custom assets into your ROM by present a list the options corresponding to each of the tools. Additionally will create a BPS patch for distribution.
- `@backup_baserom.bat` Some basic backup options that leverages some Lunar Magic features to export all modified levels, edited map16 and/or shared palettes from your ROM, as well as a basic way to create a time-stamped backup of your ROM file, and create a BPS patch on demand.
- `@restore_from_backup.bat` Options to create a fresh ROM, restore global assets from a time-stamped based backup and imports previously-exported levels, map16 and palettes into it. Requires Lunar Magic and the backup scripts to be run first.

See the [Wiki page](https://github.com/AmperSam-git/baserom-template/wiki/Using-the-Build-Scripts) for more information about these scripts.

## Clean Up & Finish

You're all set! You can delete this README and the one in `common` plus all Download links and the TIPS file if you want. Now get Hacking!