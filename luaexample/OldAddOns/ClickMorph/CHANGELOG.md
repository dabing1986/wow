# ClickMorph

## [1.6.4](https://github.com/ketho-wow/ClickMorph/tree/1.6.4) (2020-08-01)
[Full Changelog](https://github.com/ketho-wow/ClickMorph/commits/1.6.4) [Previous Releases](https://github.com/ketho-wow/ClickMorph/releases)

- Revert mount scale changes  
- Slightly delay setting scale when mounting/dismounting  
- Reapply scale after (dis)mounting  
- Ignore LibStub tests folder  
- Refactoring  
- Don't morph from items when looting (ElvUI)  
- Fixed alt-clicking items  
    No longer unintentionally morphs while looting  
- Updated for 1.13.5  
    Support AtlasLoot favourites  
    Properly undress before morphing item sets  
    Less verbose chat output  
- Fixed mount error message  
- Removed LucidMorph support  
- Added silent mode option  
- Now remembers hair, face, skin and features when remorphing  
    Fixed scale slider  
- Allow morphing T3 belts again  
- Fixed resetting scale to 1 when using the GUI  
- Added option for remorphing on inject/relog  
- Retail: Restored Off Hand dropdown in Appearances tab to use original values (#3)  
- Retail: Fixed  dualwield morphing from Appearances tab (#3)  
- Fixed "attempt to call method 'OnInject'" Lua error  
- Push clickmorph 1.5.0  
- please package  
- Update StdUi path  
- Update loadondemand data for 1.13.3 / 8.3.0  
- Reinit StdUi submodule  
- Use https for submodules  
- Use access token for checkout  
- Check out submodules  
- Revert back to 1.4.6  
- ok lets try 1.4.8  
- Try packaging again with a new tag (#2)  
- Tagging as 1.4.6 for iMorph app  
- Update for 1.13.3 / 8.3.0  
- Setup github actions bigwigs packager  
- Support Titan's Grip dual wielding (#1)  
- Disable imorph override flag  
- Don't show atlasloot msg when imorph isn't loaded  
- Update mount item ids  
- Remorph after getting polymorphed  
- GetClickMorph sanity check  
- Initialize when /reloading  
- Implement morphing on login, inject, zoning  
    Implement smart morphing  
- ItemVisuals 8.3.0 (32712)  
- Only load imorph on classic  
- Change back to 1.4.5 to not break imorph loader  
- Persist morph on zoning  
- iMorphLua frame  
- Implement itemset command  
- Reset items  
- Rename Npc case sensitive  
- Implemented char customization and npc commands  
- Implement more commands and use savedvars  
- Added .help and .morph imorph commands  
- Update License  
- Setup db  
- Allow overriding iMorph script  
- Update reference  
- Change to mount dropdown instead of autocomplete  
- Reset mount editbox  
- Increase mount slider width  
    Remove "Summon" from mount name  
- Added mount search dropdown  
- Update wording  
- GUI: added NPC search dropdown  
    Updated StdUi to fix error  
- Added version file for imorph loader  
- Why did I even embed stdui as auctionfaster  
- Added very basic GUI, open with /cm or /clickmorph  
- Added support for rIngameModelViewer  
- Support AtlasLoot individual set items  
- moved imorph globals into frame  
- Forgot to sort the whole list  
- Added /npc command and clickmorphing from target unitframe  
- Restrict alternating clickmorphing weapons to dual wielding classes only  
- Now alternates morphing weapons between main/off hand  
- Update README.md  
- Update README.md  
- Fixed morphing ranged weapons  
    Fixed resetting everything else when morphing item sets  
    Only shows the Alt+Shift click message once on opening AtlasLoot  
- Fixed PLAYER\_ENTERING\_WORLD hook  
- Added support for AtlasLoot Classic  
- Update README.md  
- Update README.md  
- Fixed gear not resetting when morphing to an inspect target's gear  
    Fixed error when trying to morph an empty equipment slot  
- Update README.md  
- Update README.md  
- Update README.md  
- Merge branch 'master' of github.com:Ketho/ClickMorph  
- Update README.md  
- Migrate to bigwigs packager  
- Update for Classic  
    Added unlock button for the Mount Journal  
- Fixed morph enchant  
- Rewrite for jMorph  
- Change license to MIT  
- Update README.md  
- Update README.md  
- Remove curse packager compat  
- Update README.md  
- Added Item ID to appearances tab tooltip  
- Added support for MogIt and inspect morphing  
    Unlocking the Appearances tab should now work instantly after the first run.  
    Fixed a couple of bugs  
- Update README.md  
- Update README.md  
- Renamed to ClickMorph  
    Added .pkgmeta  
- Added Appearances search functionality  
    Support morphing from Taku's Morph Catalog  
- Unlocked enchants/illusions  
- Added FileData  
- Forgot Crossbows and Warglaives indices  
- Unlocked weapon categories  
- Improved unlocking Appearances performance  
    Visual IDs are now shown in the tooltip  
    Fixed some weapons showing as question marks  
    Removed playing sounds  
- Added Unlock button; Fixed bugs  
- Moved into folder  
- Added mounts and unlocked appearances tab  
