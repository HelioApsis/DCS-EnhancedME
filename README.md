# DCS-EnhancedME

Lua scripts and modifications adding a "selection box" and ability to save a selection of groups as a Static Template to the Mission Editor in DCS World by Eagle Dynamics.

Currently compatible\* with **DCS OpenBeta version 2.8.2.35759.**

## Caveats

-   If this bricks your Mission Editor or DCS install, I take no responsibility for it. You install and use this mod at your own risk.
-   There is no visible selection box (yet).
-   Selection for statics is slow, especially for a large number (> 20). I would not recommend it.
-   In general, I wouldn't recommend trying to select a large amount of groups in a large mission. It tends to be very slow. Even if DCS seems "frozen," the ME is processing the selections in the background.

## Usage

### Selection Box

**While holding `Left Shift`,** click and drag over the groups/statics you would like to select.

Wait for your selection to appear in white/yellow as usual. Voila.

### Save Selection As Static Template

Using the `Left Shift + Click` method or your new selection box (see above), select the Groups you would like to save as a static template.

Click the **Edit** menu and choose **Save Static Template** as usual. Fill in your desired template name, file name, and description as usual. When ready, click the green **Create (Selection)** button.

## Installation

1. Backup your current `MissionEditor\modules` folder at in your main DCS OpenBeta install location.
2. [Download this repository](https://github.com/HelioApsis/DCS-EnhancedME/archive/refs/heads/master.zip) as a ZIP file (green "<> Code" button)
3. Unzip and merge the `MissionEditor` folder into your DCS OpenBeta install location. It should ask you to overwrite several files.
4. Start DCS and enjoy a few editor enhancements.
