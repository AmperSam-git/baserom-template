# AmperSam's Recommendations & Tips

Here's a few tips and recommendations to help you as you go along your ROM hacking journey: 

## Keep track of everything you use.

This saves not only yourself time, in potentially creating in-game credits or for finding resources over again for future hacks, but also people who wonder what you use in your game (provided you include it in your release). Plus it gives appropriate credit to all resource authors in a simple way, regardless if they were explicit in asking for credit.

> An example CREDITS file is included.


## "What Patches Do I Need??"

People often don't know what global patches are generally recommended for a base ROM, so here's a short list of (some) global patches that I personally use that provide common bug fixes and a couple quality of life additions to your ROM, feel free to use any or all:

- "$13FB Game Crash Fix" by p4plus2 (https://www.smwcentral.net/?p=section&a=details&id=18319)
- "Block Duplication Fix v1.5" by Tattletale and lolcats439 (https://www.smwcentral.net/?p=section&a=details&id=18413)
- "Double Spinjump Antifail" by Alcaro (https://www.smwcentral.net/?p=section&a=details&id=13400)
- "Frame Rule Fix" by Yagami (https://www.smwcentral.net/?p=viewthread&t=96593)
- "Horizontal Pipe Exiting Sound Fix" by RussianMan (https://www.smwcentral.net/?p=section&a=details&id=23858)
- "Line Guide Acts-Like Fix" by imamelia, worldpeace (https://www.smwcentral.net/?p=section&a=details&id=23847)
- "No More Sprite Tile Limits v1.2.1" by edit1754 et al. (https://www.smwcentral.net/?p=section&a=details&id=18741)
- "No Silent Bullet Bill" by Ramp202 (https://www.smwcentral.net/?p=section&a=details&id=19238)
- "Rollover Fix" by Noobish Noobsicle (https://www.smwcentral.net/?p=section&a=details&id=14053)
- "Rope Fix" by Alcaro (https://www.smwcentral.net/?p=section&a=details&id=8784)
- "Thwomp Face Flip Fix" by Alcaro (https://www.smwcentral.net/?p=section&a=details&id=19404)
- "Time Up Fix" by Alcaro (https://www.smwcentral.net/?p=section&a=details&id=15110)
- "Walljump/Note Block Glitch Fix v1.6" by lolcats439 (https://www.smwcentral.net/?p=section&a=details&id=19932)

Download and add these to `common/asar` plus any other global patches you may want to make use of and update `list_asar.txt` appropriately to use it with your Base ROM all at once.


## Enable FastROM in Lunar Magic

In Lunar Magic, you can enable FastROM addressing on your ROM to via 'Options > Enable FastROM Speed & Apply Patch' and 'Use FastROM Addressing for this ROM'. This sets up Lunar Magic to use the "LoROM" map for all data and ASM hacks it uses, which is required for getting the speed benefit out of anything else using FastROM hacks and reduces slow down for onscreen sprites


## Use Restore Feature of Lunar Magic

Lunar Magic has the capacity to restore your ROM in case of errors, by rolling back changes. To make sure it's setup visit `Options > Restore Point Options...` in the Lunar Magic menu.



