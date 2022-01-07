--[[
 Skillet: A tradeskill window replacement.

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
]]--

local L = LibStub("AceLocale-3.0"):NewLocale("Skillet", "itIT")
if not L then return end

L[" days"] = " giorni"
L["About"] = "Riguardo a"
L["ABOUTDESC"] = "Stampa le informazioni riguardo a Skillet"
--[[Translation missing --]]
L["Add Recipe to Ignored List"] = "Add Recipe to Ignored List"
L["Add to Ignore Materials"] = "Add to Ignore Materials"
--[[Translation missing --]]
L["alts"] = "alts"
L["Appearance"] = "Aspetto"
L["APPEARANCEDESC"] = "Le opzioni che controllano come Skillet viene mostrato"
L["bank"] = "banca"
L["Blizzard"] = "Tempesta"
L["Buy Reagents"] = "Compra Reagenti"
L["buyable"] = "comprabile"
L["Buyout"] = "Buyout"
L["By Difficulty"] = "Per Difficolta'"
L["By Item Level"] = "Per Livello Oggetto"
L["By Level"] = "Per Livello"
L["By Name"] = "Per Nome"
L["By Quality"] = "Per Qualita'"
L["By Skill Level"] = "Per Livello Abilita'"
L["can be created by crafting reagents"] = "can be created by crafting reagents"
--[[Translation missing --]]
L["can be created from reagents in your inventory"] = "can be created from reagents in your inventory"
--[[Translation missing --]]
L["can be created from reagents on all characters"] = "can be created from reagents on all characters"
L["can be created from reagents on other characters"] = "puo' essere creato con i reagenti presenti su tutti i tuoi personaggi"
L["can be created with reagents bought at vendor"] = "can be created with reagents bought at vendor"
--[[Translation missing --]]
L["Changing profession to"] = "Changing profession to"
L["Clear"] = "Pulisci"
--[[Translation missing --]]
L["Click"] = "Click"
L["click here to add a note"] = "premere qui per aggiungere una nota"
L["Click to toggle favorite"] = "Click to toggle favorite"
L["Collapse all groups"] = "Collassa tutti i gruppi"
L["Config"] = "Configura"
L["CONFIGDESC"] = "Apre la finestra di configurazione di Skillet"
L["CONFIRMQUEUECLEARDESC"] = "Use Alt-left-click instead of left-click to clear the queue"
L["CONFIRMQUEUECLEARNAME"] = "Use Alt-click to clear queue"
--[[Translation missing --]]
L["Conflict with the addon TradeSkillMaster"] = "Conflict with the addon TradeSkillMaster"
L["Copy"] = "Copy"
L["Could not find bag space for"] = "Non trovo spazio nell borse per"
L["craftable"] = "crabile"
--[[Translation missing --]]
L["CRAFTBUTTONSDESC"] = "Include Craft buttons in frame"
--[[Translation missing --]]
L["CRAFTBUTTONSNAME"] = "Include Craft buttons"
L["Crafted By"] = "Crato da"
L["Create"] = "Crea"
L["Create All"] = "Crea Tutti"
L["Cut"] = "Cut"
L["DBMarket"] = "DBMarket"
L["Delete"] = "Cancella"
--[[Translation missing --]]
L["DISPLAYITEMLEVELDESC"] = "If the item to be crafted has an item level, that level will be displayed along with the recipe"
--[[Translation missing --]]
L["DISPLAYITEMLEVELNAME"] = "Display item level"
L["DISPLAYREQUIREDLEVELDESC"] = "Se l'oggetto creato richiede un livello minimo per essere usato, questo livello viene mostrato a fianco della ricetta"
L["DISPLAYREQUIREDLEVELNAME"] = "Mostra livello richiesto"
L["DISPLAYSHOPPINGLISTATAUCTIONDESC"] = "Mostra una lista della spesa per gli oggetti richiesti, ma non presenti nelle borse, per creare le ricette accodate"
L["DISPLAYSHOPPINGLISTATAUCTIONNAME"] = "Mostra lista della spesa alla casa d'aste"
L["DISPLAYSHOPPINGLISTATBANKDESC"] = "Mostra una lista della spesa per gli oggetti richiesti, ma non presenti nelle borse, per creare le ricette accodate"
L["DISPLAYSHOPPINGLISTATBANKNAME"] = "Mostra una lista della spesa alla banca"
L["DISPLAYSHOPPINGLISTATGUILDBANKDESC"] = "Mostra una lista della spesa per gli oggetti richiesti, ma non presenti nelle borse, per creare le ricette accodate"
L["DISPLAYSHOPPINGLISTATGUILDBANKNAME"] = "Mostra una lista della spesa alla banca di gilda"
L["DISPLAYSHOPPINGLISTATMERCHANTDESC"] = "Display a shopping list of the items that are needed to craft queued recipes but are not in your bags"
L["DISPLAYSHOPPINGLISTATMERCHANTNAME"] = "Display Shopping List at Merchants"
L["Draenor Engineering"] = "Draenor Engineering"
L["Empty Group"] = "Empty Group"
L["Enabled"] = "Attivato"
L["Enchant"] = "Incantamento"
L["ENHANCHEDRECIPEDISPLAYDESC"] = "Quando abilitato, le ricette avranno uno o piu' '+' per indicarne la difficolta'."
L["ENHANCHEDRECIPEDISPLAYNAME"] = "Mostra la difficolta' delle ricette come testo"
L["Expand all groups"] = "Espandi tutti i gruppi"
L["Features"] = "Caratteristiche"
L["FEATURESDESC"] = "Comportamenti opzionali che possono essere attivati o disattivati"
L["Filter"] = "Filtro"
--[[Translation missing --]]
L["Flat"] = "Flat"
L["Flush All Data"] = "Flush All Data"
--[[Translation missing --]]
L["Flush Player Data"] = "Flush Player Data"
L["Flush Recipe Data"] = "Flush Recipe Data"
L["FLUSHALLDATADESC"] = "Flush all Skillet data"
--[[Translation missing --]]
L["FLUSHPLAYERDATADESC"] = "Flush this character's data"
L["FLUSHRECIPEDATADESC"] = "Flush Skillet recipe data"
L["From Selection"] = "From Selection"
L["Glyph "] = "Glifo"
L["Gold earned"] = "Oro guadagnato"
L["Grouping"] = "Raggruppamento"
L["has cooldown of"] = "has cooldown of"
L["have"] = "hanno"
L["Hide trivial"] = "Nascondi Banali"
L["Hide uncraftable"] = "Nascondi non creabili"
--[[Translation missing --]]
L["HIDEBLIZZARDFRAMEDESC"] = "Hide Blizzard TradeSkill frame when showing Skillet frame"
--[[Translation missing --]]
L["HIDEBLIZZARDFRAMENAME"] = "Hide Blizzard Frame"
--[[Translation missing --]]
L["Ignore"] = "Ignore"
L["IGNORECLEARDESC"] = "Clear all entries from the Ignored Materials list."
L["Ignored List"] = "Ignored List"
L["Ignored Materials Clear"] = "Ignored Materials Clear"
L["Ignored Materials List"] = "Ignored Materials List"
L["IGNORELISTDESC"] = "Open the Ignored Materials list frame."
L["Illusions"] = "Illusions"
--[[Translation missing --]]
L["in your bank"] = "in your bank"
L["in your inventory"] = "in your inventory"
L["Include alts"] = "Includi alt"
L["Include bank"] = "Include bank"
L["Include guild"] = "Include gilda"
--[[Translation missing --]]
L["INCLUDEREAGENTSDESC"] = "Add reagent names to the item text that is searched."
--[[Translation missing --]]
L["INCLUDEREAGENTSNAME"] = "Include Reagents in Search"
L["Inventory"] = "Inventario"
L["INVENTORYDESC"] = "Informazioni dell'Inventario"
--[[Translation missing --]]
L["InvSlot"] = "InvSlot"
L["is now disabled"] = "e' ora disabilitato"
L["is now enabled"] = "e' ora abiltiato"
L["Learned"] = "Learned"
L["Library"] = "Libreria"
L["Link Recipe"] = "Link Recipe"
L["LINKCRAFTABLEREAGENTSDESC"] = "Se puoi creare un reagente necessario alla ricetta, cliccando il reagente ti portera' alla sua ricetta"
L["LINKCRAFTABLEREAGENTSNAME"] = "Rendi reagenti clickabili"
L["Load"] = "Carica"
--[[Translation missing --]]
L["Lock/Unlock"] = "Lock/Unlock"
L["Market"] = "Market"
L["Merge items"] = "Unisce oggetti"
L["Move Down"] = "Muovi verso il basso"
L["Move to Bottom"] = "Muovi al fondo"
L["Move to Top"] = "Muovi all'inizio"
L["Move Up"] = "Muovi verso l'alto"
L["need"] = "necessario"
--[[Translation missing --]]
L["New"] = "New"
L["New Group"] = "New Group"
L["No Data"] = "Nessun Dato"
--[[Translation missing --]]
L["No headers, try again"] = "No headers, try again"
L["No such queue saved"] = "Nessuna lista simile salvata"
L["None"] = "Nessuno"
L["not yet cached"] = "non ancora salvato"
L["Notes"] = "Note"
L["Number of items to queue/create"] = "Numero di oggetti da accodare/creare"
L["Options"] = "Opzioni"
L["Order by item"] = "Ordina per oggetto"
L["Paste"] = "Paste"
L["Pause"] = "Pausa"
L["Plugins"] = "Plugins"
--[[Translation missing --]]
L["Press"] = "Press"
--[[Translation missing --]]
L["Press Okay to continue changing professions"] = "Press Okay to continue changing professions"
--[[Translation missing --]]
L["Press Process to continue"] = "Press Process to continue"
L["Process"] = "Processo"
L["Purchased"] = "Comprato"
L["Queue"] = "Coda"
L["Queue All"] = "Accoda Tutti"
L["Queue is empty"] = "La coda e' vuota"
L["Queue is not empty. Overwrite?"] = "La coda non e' vuota. Sovrascrivere?"
L["Queue with this name already exsists. Overwrite?"] = "Una coda con questo nome esiste gia'. Sovrascrivere?"
L["QUEUECRAFTABLEREAGENTSDESC"] = "Se puoi creare il reagente per la ricetta corrente, e non ne hai a sufficenza, allora il reagente verra' aggiunto alla coda"
L["QUEUECRAFTABLEREAGENTSNAME"] = "Accoda reagenti creabili"
L["QUEUEGLYPHREAGENTSDESC"] = "Se puoi creare il reagente per la ricetta corrente, e non ne hai a sufficenza, allora il reagente verra' aggiunto alla coda. Questa opzione e' separata solo per i Glifi."
L["QUEUEGLYPHREAGENTSNAME"] = "Accoda reagenti per Glifi"
L["QUEUEONLYVIEWDESC"] = "Show Standalone Queue Window only when set, show both Standalone Queue Window and Skillet Window when clear."
L["QUEUEONLYVIEWNAME"] = "Only show Standalone Queue"
L["Queues"] = "Code"
--[[Translation missing --]]
L["reagent id seems corrupt!"] = "reagent id seems corrupt!"
L["Reagents"] = "Reagenti"
L["reagents in inventory"] = "reagenti in inventario"
L["Really delete this queue?"] = "Vuoi cancellare veramente questa coda?"
L["Remove Favorite"] = "Remove Favorite"
--[[Translation missing --]]
L["Remove Recipe from Ignored List"] = "Remove Recipe from Ignored List"
--[[Translation missing --]]
L["Rename"] = "Rename"
L["Rename Group"] = "Rename Group"
L["Rescan"] = "Riscansiona"
L["Reset"] = "Comando di reimpostazione posizione"
L["Reset Recipe Filter"] = "Reset Recipe Filter"
L["RESETDESC"] = "Descrizione del comando di reimpostazione posizione"
L["RESETRECIPEFILTERDESC"] = "Reset Recipe Filter"
L["Retrieve"] = "Recupera"
L["Same faction"] = "Same faction"
L["Save"] = "Salva"
L["Scale"] = "Scala"
L["SCALEDESC"] = "Scala la finestra delle professioni (di base 1.0)"
--[[Translation missing --]]
L["SCALETOOLTIPDESC"] = "Set scale of skill and reagent tooltips to match recipe tooltip (global uiscale)."
--[[Translation missing --]]
L["SCALETOOLTIPNAME"] = "Scale All Tooltips"
L["Scan completed"] = "Scansione Completa"
L["Scanning tradeskill"] = "Scansionamento Professioni"
L["Search"] = "Search"
L["Select All"] = "Select All"
L["Select None"] = "Select None"
L["Select skill difficulty threshold"] = "Seleziona limite della difficolta' per le professioni"
L["Selected Addon"] = "Addon Selezionato"
L["Selection"] = "Selection"
L["Sells for "] = "Vendibile per "
L["Set Favorite"] = "Set Favorite"
--[[Translation missing --]]
L["shift-click to link"] = "shift-click to link"
L["Shopping Clear"] = "Lista della Spesa pulita"
L["Shopping List"] = "Lista della Spesa"
L["SHOPPINGCLEARDESC"] = "Pulisci la Lista della Spesa"
L["SHOPPINGLISTDESC"] = "Mostra la lista della spesa"
L["Show favorite recipes only. Click on a star on the left side of a recipe to set favorite."] = "Show favorite recipes only. Click on a star on the left side of a recipe to set favorite."
L["SHOWBANKALTCOUNTSDESC"] = "Quando vengono calcolati e mostrati i conteggi per gli oggetti, includere quelli presenti in banca e su altri personaggi"
L["SHOWBANKALTCOUNTSNAME"] = "Includi banca e alt"
L["SHOWCRAFTCOUNTSDESC"] = "Mostra il numero di volte che puoi creare una ricetta, non il totale di oggetti producibili"
L["SHOWCRAFTCOUNTSNAME"] = "Mostra conteggio creabili"
L["SHOWCRAFTERSTOOLTIPDESC"] = "Mostra l'alt che e' in grado di creare l'oggetto nelle informazioni"
L["SHOWCRAFTERSTOOLTIPNAME"] = "Mostra creatori nelle informazioni"
L["SHOWDETAILEDRECIPETOOLTIPDESC"] = "Mostra un'informazione quando si passa sopra una ricetta"
L["SHOWDETAILEDRECIPETOOLTIPNAME"] = "Mostra informazioni per le ricette"
L["SHOWFULLTOOLTIPDESC"] = "Mostra tutte le informazioni su un oggetto che puo' essere creato. Se si disattiva questa opzione si vedranno solo informazioni compresse (tenere premuto Ctrl per mostrare le informazioni complete)"
L["SHOWFULLTOOLTIPNAME"] = "Usa informazioni di base"
L["SHOWITEMNOTESTOOLTIPDESC"] = "Aggiungi note pesonalizzate alle informazioni di un oggetto"
L["SHOWITEMNOTESTOOLTIPNAME"] = "Aggiungi note personalizzate alle informazioni"
L["SHOWITEMTOOLTIPDESC"] = "Mostra informazioni oggetto, invece che le informazioni ricetta."
L["SHOWITEMTOOLTIPNAME"] = "Mostra informazioni oggetto quando possibile"
L["SHOWMAXUPGRADEDESC"] = "When set, show upgradable recipes as \"(current/maximum)\". When not set, show as \"(current)\""
L["SHOWMAXUPGRADENAME"] = "Show upgradable recipes as (current/max)"
L["SHOWRECIPESOURCEFORLEARNEDDESC"] = "Show Recipe Source for Learned Recipes"
L["SHOWRECIPESOURCEFORLEARNEDNAME"] = "Show Recipe Source for Learned Recipes "
L["Skillet Trade Skills"] = "Skillet Abilità di Commercio"
L["Skipping"] = "Saltare"
L["Sold amount"] = "Ammontare di vendita"
L["SORTASC"] = "Elenca la lista ricette dal piu' alto al piu' basso"
L["SORTDESC"] = "Elenca la lista delle ricette dal piu' basso al piu' alto"
L["Sorting"] = "Riordinango"
L["Source:"] = "Sorgente:"
L["STANDBYDESC"] = "Scambia stato di attesa acceso/spento"
L["STANDBYNAME"] = "attesa"
L["Start"] = "Inizia"
--[[Translation missing --]]
L["SubClass"] = "SubClass"
--[[Translation missing --]]
L["SUPPORTCRAFTINGDESC"] = "Include support for Crafting professions (requires a /reload)"
--[[Translation missing --]]
L["SUPPORTCRAFTINGNAME"] = "Support Crafting"
L["Supported Addons"] = "Addon Supportati"
L["SUPPORTEDADDONSDESC"] = "Addon supportati che possono o sono utilizzati per esaminare l'inventario"
L["This merchant sells reagents you need!"] = "Questo mercante vende i reagenti che ti servono!"
--[[Translation missing --]]
L["TOOLTIPSCALEDESC"] = "Scales the recipe list, detail item and reagent tooltips"
L["Total Cost:"] = "Costo totale:"
L["Total spent"] = "Totale speso"
--[[Translation missing --]]
L["TRADEBUTTONSDESC"] = "Include TradeSkill buttons in frame"
--[[Translation missing --]]
L["TRADEBUTTONSNAME"] = "Include TradeSkill buttons"
L["Trained"] = "Allenato"
L["TRANSPARAENCYDESC"] = "Trasparenza della finestra principale"
L["Transparency"] = "Trasparenza"
L["Unknown"] = "Sconosciuto"
L["Unlearned"] = "Unlearned"
L["USEALTCURRVENDITEMSDESC"] = "Vendor items bought with alternate currencies are considered vendor supplied."
L["USEALTCURRVENDITEMSNAME"] = "Use vendor items bought with alternate currencies"
L["USEBLIZZARDFORFOLLOWERSDESC"] = "Use the Blizzard UI for garrison follower tradeskills"
L["USEBLIZZARDFORFOLLOWERSNAME"] = "Use Blizzard UI for followers"
L["USEGUILDBANKASALTDESC"] = "Use the contents of the guildbank as if it was another alternate."
L["USEGUILDBANKASALTNAME"] = "Use guildbank as another alt"
L["Using Bank for"] = "Using Bank for"
L["Using Reagent Bank for"] = "Using Reagent Bank for"
L["VENDORAUTOBUYDESC"] = "Se hai accodato ricette e parli con un mercante che vende qualdoca che ti serve per quelle ricette, verra' automaticamente acquistato."
L["VENDORAUTOBUYNAME"] = "Compra reagenti in automatico"
L["VENDORBUYBUTTONDESC"] = "Mostra un bottone quando parli ad un mercante che permette di comprare i reagenti necessari per le ricette accodate."
L["VENDORBUYBUTTONNAME"] = "Mostra pulsante dai mercanti"
L["View Crafters"] = "Mostra Creatori"

