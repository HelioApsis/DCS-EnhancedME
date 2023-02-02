# DCS-EnhancedME

Lua script adding a "selection box" to the Mission Editor in DCS World by Eagle Dynamics.

Currently compatible\* with **DCS OpenBeta version 2.8.2.35759.**

## Caveats

-   There is no visible selection box (yet).
-   Selection for statics is slow, especially for a large number (> 20). I would not recommend it.
-   In general, I wouldn't recommend trying to select a large amount of groups in a large mission. It tends to be very slow. Even if DCS seems "frozen," the ME is processing the selections in the background.
-   **This is basically only for selecting a large amount of units to delete them. That's all you can do with multiselection in the Mission Editor and this script doesn't change that.**

## Usage

**While holding `Left Shift`,** click and drag over the groups/statics you would like to select.

Wait for your selection to appear in white/yellow as usual. Voila.

## Installation

1. Backup your current `me_map_window.lua` at `<DCS Install Location>\MissionEditor\modules\me_map_window.lua` by renaming it or copying it to another location.
2. [Download this repository](https://github.com/HelioApsis/DCS-MESelectBox/archive/refs/heads/master.zip) as a ZIP file (green "<> Code" button)
3. Unzip and merge the folder into your DCS OpenBeta install location. It should ask you to overwrite `<DCS Install Location>\MissionEditor\modules\me_map_window.lua` while adding `me_select_box.lua` to the `MissionEditor\modules` folder.
4. Start DCS and enjoy a selection box in the editor.
