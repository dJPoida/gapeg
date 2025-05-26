/**
    Gapeg Engine class
    author: Peter Eldred
    version: 0.1
    created: 2008-02-18
    copyright: Peter Eldred

    This code controlls the brunt of the Gapeg Engine
*/
class gapegEngine {
	//Set this flag to true to enable debug mode
	var C_DEBUG: Boolean = false;
	
	var __screenHandler: gapegScreenHandler;
	var __mouseHandler: gapegMouseHandler;
	var __inventoryHandler: gapegInventoryHandler;
	var __conditionHandler: gapegConditionHandler;
	var __soundHandler: gapegSoundHandler;
	
	var __foundItems: Array;
	var __countOfFoundItems: Number;
	
	var __switches: Array;
	var __countOfSwitches: Number;
	
	var __parentMC: MovieClip;
	var __debugMC: MovieClip;
	
	//Constructor
	public function gapegEngine (p_parentMC:MovieClip) {
		this.__parentMC = p_parentMC;
		
		this.__foundItems = new Array ();
		this.__countOfFoundItems = 0;
		
		this.__switches = new Array ();
		this.__countOfSwitches = 0;
		
		this.initConditionHandler();
		this.initSwitches();
	}

	public function initMouseHandler() {
		this.__mouseHandler = new gapegMouseHandler(this, this.__parentMC);
	}
	
	public function initScreenHandler(p_screenMC: MovieClip) {
		this.__screenHandler = new gapegScreenHandler(this, p_screenMC);
	}
	
	public function initInventoryHandler(p_inventoryMC: MovieClip) {
		this.__inventoryHandler = new gapegInventoryHandler(this, p_inventoryMC);
	}
	
	public function initConditionHandler() {
		this.__conditionHandler = new gapegConditionHandler (this);
	}
	
	public function initSoundHandler() {
		this.__soundHandler = new gapegSoundHandler (this);
	}
	
	public function toggleSwitch (p_switchID: Number) {
		var targetSwitch: gapegSwitch;
		
		targetSwitch = this.getSwitchByID(p_switchID);
		
		if (targetSwitch <> undefined) {
			targetSwitch.toggle();
			this.screenHandler.refreshScreen();
		}
	}

	public function setSwitch (p_switchID: Number, p_isActive: Boolean) {
		var targetSwitch: gapegSwitch;
		
		targetSwitch = this.getSwitchByID(p_switchID);
		
		if (targetSwitch <> undefined) {
			targetSwitch.isActive = p_isActive;
			this.screenHandler.refreshScreen();
		}
	}

	private function addSwitch (p_switchID: Number, p_defaultState: Boolean): gapegSwitch {
		this.__countOfSwitches += 1;
		return this.__switches[this.__countOfSwitches] = new gapegSwitch (this, p_switchID, p_defaultState);
	}
	
	public function switchStatus (p_switchID: Number): Boolean {
		var targetSwitch: gapegSwitch;
		
		targetSwitch = this.getSwitchByID(p_switchID);
		
		return targetSwitch.isActive;
	}
	
	public function conditionSatisfied (p_conditionID: Number): Boolean {
		var condSat: Boolean = false;
		
		condSat = this.__conditionHandler.getConditionByID(p_conditionID).isSatisfied();
		
		return condSat;
	}
	
	public function menuPlay() {
		this.parentMC.gotoAndPlay("frame_startGame");
	}

	public function menuLoad() {
		trace ("Load Not Completed Yet");
	}

	public function initNewGame () {
		this.screenHandler.setScreen(2);
		this.mouseHandler.setCursor (this.mouseHandler.C_MC_STANDARDHAND);
	}
	
	public function gameControl_left() {
		if (this.screenHandler.currentScreen.leftID <> 0) {
			this.screenHandler.setScreen(this.screenHandler.currentScreen.leftID);
		}
	}

	public function gameControl_right() {
		if (this.screenHandler.currentScreen.rightID <> 0) {
			this.screenHandler.setScreen(this.screenHandler.currentScreen.rightID);
		}
	}

	public function gameControl_up() {
		if (this.screenHandler.currentScreen.upID <> 0) {
			this.screenHandler.setScreen(this.screenHandler.currentScreen.upID);
		}
	}

	public function gameControl_down() {
		if (this.screenHandler.currentScreen.downID <> 0) {
			this.screenHandler.setScreen(this.screenHandler.currentScreen.downID);
		}
	}
	
	public function gameControl_navBtnClick(p_sender: MovieClip) {
		var targetNavBtn: gapegNavBtn = this.screenHandler.currentScreen.findNavBtnByName(p_sender._name);

		//Check and see if the Nav Btn can be actioned
		if (targetNavBtn != undefined) {
			//if (targetNavBtn.enabled)
				this.screenHandler.setScreen(targetNavBtn.targetScreenID);
		}
	}
	
	//This function picks up an item and places it in the inventory
	public function pickupItem (p_itemID: Number) {
		var newInventoryID: Number;
		
		newInventoryID = this.__inventoryHandler.pickupItem (p_itemID);
		this.__screenHandler.refreshScreen();
		
		if (newInventoryID > 0) {
			this.viewInventoryItem (newInventoryID);
		}
	}
	
	//This function evolves an inventory item into another inventory item
	public function evolveItem (p_oldItemID: Number, p_replaceWithItemID: Number) {
		var newInventoryID: Number;
		
		newInventoryID = this.__inventoryHandler.evolveItem (p_oldItemID, p_replaceWithItemID);
		this.__screenHandler.refreshScreen();
		
		if (newInventoryID > 0) {
			this.viewInventoryItem (newInventoryID);
		}
	}
	
	
	//This function removes a found item from the Inventory
	public function removeItem (p_itemID: Number) {
		this.__inventoryHandler.removeItemByItemID (p_itemID);
	}
	
	public function selectInventoryItem (p_inventoryID: Number) {
		this.__inventoryHandler.selectItemByInventorySlot (p_inventoryID);
	}
	
	public function viewInventoryItem (p_inventoryID: Number) {
		this.screenHandler.showInventoryItemCloseUp(this.__inventoryHandler.inventorySlot(p_inventoryID).containsItemID);
	}
	
	public function exitCloseUpItemView() {
		if (this.screenHandler.viewingItemCloseUp) {
			this.screenHandler.closeInventoryItemCloseUp();
		}
	}
	
	public function get debugMC ():MovieClip {
		return this.__debugMC;
	}
	
	public function set debugMC (value:MovieClip):Void {
		this.__debugMC = value;
		
		this.__debugMC._visible = this.C_DEBUG;
	}
	
	public function updateDebugInfo () {
		this.__debugMC.debug_screenID = screenHandler.currentScreen.ID;
		this.__debugMC.debug_screenName = screenHandler.currentScreen.screenLabel;
	}

	public function get screenHandler(): gapegScreenHandler {
		return this.__screenHandler;
	}

	public function get soundHandler(): gapegSoundHandler {
		return this.__soundHandler;
	}
	
	public function get mouseHandler(): gapegMouseHandler {
		return this.__mouseHandler;
	}

	public function get conditionHandler(): gapegConditionHandler {
		return this.__conditionHandler;
	}
	
	public function get parentMC ():MovieClip {
		return this.__parentMC;
	}

	public function get screenMC ():MovieClip {
		return this.__screenHandler.screenMC;
	}
	
	public function set screenMC (value:MovieClip):Void {
		this.__screenHandler.screenMC = value;
	}
	
	public function addFoundItem (p_itemID: Number) {
		this.__countOfFoundItems += 1;
		this.__foundItems [this.__countOfFoundItems] = p_itemID;
		
		this.playSound(gapegConst.C_SOUND_ACHIEVEMENT);
	}
	
	public function foundItem (p_itemID: Number): Boolean {
		var itemHasBeenFound: Boolean = false;

		for (var i:Number = 0; i <= this.__countOfFoundItems; i++) { 
			if (this.__foundItems[i] == p_itemID) {
				itemHasBeenFound = true;
				break;
			}
		}		
		
		return itemHasBeenFound;
	}
	
	public function getSwitchByID (p_switchID: Number): gapegSwitch {
		var foundSwitch: gapegSwitch;
		
		for (var i:Number = 1; i <= this.__countOfSwitches; i++) { 
			if (this.__switches[i].switchID == p_switchID) {
				foundSwitch = this.__switches[i];
				break;
			}
		}		
		
		return foundSwitch;
	}
	
	public function playSound(soundID: Number) {
		this.__soundHandler.playSound(soundID);
	}
	
	

	//SWITCH INITIALIZERS
	//-------------------
	public function initSwitches () {
		//TV Button
		this.addSwitch (gapegConst.C_SWITCH_TV_POWER_BUTTON, false);

		//TV Button
		this.addSwitch (gapegConst.C_SWITCH_HAS_SEEN_TV_IMAGE, false);

		//Grate Removed
		this.addSwitch (gapegConst.C_SWITCH_REMOVED_GRATE, false);

		//Computer On
		this.addSwitch (gapegConst.C_SWITCH_COMPUTER_ON, false);

		//USB Key Plugged In
		this.addSwitch (gapegConst.C_SWITCH_USBKEY_PLUGGED_IN, false);
		
		//Camera in Focus
		this.addSwitch (gapegConst.C_SWITCH_CAMERA_INFOCUS, false);
		
		//Blinds Open
		this.addSwitch (gapegConst.C_SWITCH_BLINDS_OPEN, false);
		
	}
	
	
}