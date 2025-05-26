/**
    Gapeg Engine Screen Handler class
    author: Peter Eldred
    version: 0.1
    created: 2008-02-18
    copyright: Peter Eldred

    This code controlls the Screens and Directions of the Gapeg Engine
*/
class gapegScreenHandler {
	var __gapegEngine: gapegEngine;
	
	var __screenMC: MovieClip;
	var __currentScreenID: Number;
	
	var __screens: Array;
	var __screenCount: Number = 100;
	
	var __viewingItemCloseUp: Boolean;
	var __viewingItemCloseUpID: Number;
	
	//Constructor
	public function gapegScreenHandler (p_gapegEngine:gapegEngine, p_screenMC: MovieClip) {
		this.__gapegEngine = p_gapegEngine;
		this.__screenMC = p_screenMC;
		this.__screens = new Array();
		this.__viewingItemCloseUp = false;
		this.__viewingItemCloseUpID = 0;

		this.createScreens();
		
		this.setScreen(1); //MENU
	}
	
	public function setScreen (p_screenID) {
		this.__currentScreenID = p_screenID;
			
		this.screenMC.gotoAndStop(this.currentScreen.ID);
		
		this.determineSubFrame();
		this.determineVisStates();
		
		this.updateButtonVisibility();
		this.__gapegEngine.updateDebugInfo();
	}
	
	public function refreshScreen() {
		this.setScreen (this.__currentScreenID);
	}
	
	private function determineSubFrame() {
		var newSubFrame: Number;
		newSubFrame = 1;
		
		if (this.currentScreen.subFrameCount > 1) {
			//Check the Frames in Descending Order. Make sure that the frames are in the order of Least to Most Changes in the Timeline
			for (var i:Number = this.currentScreen.subFrameCount; i > 1; i--) { 
				if (this.currentScreen.subFrame(i).requiredCondition.isSatisfied()) {
					newSubFrame = i;
					break;
				}
			}
		}

		this.setSubFrame (newSubFrame);
	}
	
	private function determineVisStates() {
		var visMC: MovieClip;
		
		if (this.currentScreen.visStateCount > 0) {
			for (var i:Number = 1; i <= this.currentScreen.visStateCount; i++) { 
				visMC = eval(this.__screenMC + ".screenMC." + this.currentScreen.visStateByNo(i).visStateMCName);
				if (visMC <> undefined) {
					visMC._visible = this.__gapegEngine.conditionHandler.getConditionByID(this.currentScreen.visStateByNo(i).gapegConditionID).isSatisfied();
				}
			}
		}
	}
	
	
	private function setSubFrame (p_frameNo: Number) {
		this.screenMC.screenMC.gotoAndStop (p_frameNo);
	}
	
	public function get screenMC ():MovieClip {
		return this.__screenMC;
	}
	
	public function set screenMC (value:MovieClip):Void {
		this.__screenMC = value;

		this.__screenMC.gotoAndStop(this.currentScreen.ID);
		this.__screenMC._visible = true;
	}

	public function get currentScreen (): gapegScreen {
		return this.__screens[this.__currentScreenID];
	}
	
	public function get viewingItemCloseUp (): Boolean {
		return this.__viewingItemCloseUp;
	}
	
	//p_itemID is the ITEM Identifier not the Inventory Slot ID
	public function showInventoryItemCloseUp (p_itemID: Number) {
		//If the user clicks on the view item close up button while 
		//viewing the current item close up - close the close up view.
		if (this.__viewingItemCloseUpID == p_itemID) {
			this.closeInventoryItemCloseUp();
		} else {
			this.hideAllMainNavButtons();
			this.__viewingItemCloseUp = true;
			this.__gapegEngine.parentMC.gotoAndStop("frame_viewInventoryItem");
			this.__gapegEngine.parentMC.largeInventoryView.gotoAndStop(p_itemID);
			this.__viewingItemCloseUpID = p_itemID;
		}
	}

	public function closeInventoryItemCloseUp () {
		this.setMainNavButtonVisibility();
		this.__viewingItemCloseUp = false;
		this.__gapegEngine.parentMC.gotoAndStop("frame_mainGameFrame");
		this.__viewingItemCloseUpID = 0;
	}

	private function setMainNavButtonVisibility () {
		this.__screenMC.btnNav_LEFT._visible = (this.currentScreen.leftID > 0);
		this.__screenMC.btnNav_UP._visible = (this.currentScreen.upID > 0);
		this.__screenMC.btnNav_RIGHT._visible = (this.currentScreen.rightID > 0);
		this.__screenMC.btnNav_DOWN._visible = (this.currentScreen.downID > 0);
	}
	
	private function hideAllMainNavButtons () {
		this.__screenMC.btnNav_LEFT._visible = false;
		this.__screenMC.btnNav_UP._visible = false;
		this.__screenMC.btnNav_RIGHT._visible = false;
		this.__screenMC.btnNav_DOWN._visible = false;
	}
	
	private function updateButtonVisibility () {
		this.setMainNavButtonVisibility();
	}
	
	private function createScreen (P_ID, P_ScreenLabel, P_LeftID, P_UpID, P_RightID, P_DownID): gapegScreen {
		this.__screens[P_ID] = new gapegScreen(this.__gapegEngine, P_ID);
		
		this.__screens[P_ID].leftID = P_LeftID;
		this.__screens[P_ID].upID = P_UpID;
		this.__screens[P_ID].rightID = P_RightID;
		this.__screens[P_ID].downID = P_DownID;
		this.__screens[P_ID].screenLabel = P_ScreenLabel;
		
		return this.__screens[P_ID];
	}
	
	public function createScreens () {
		var newScreen: gapegScreen;
		
		//After the creation of each screen, create additional elements within the newScreen variable.

		newScreen = createScreen (1, "Menu Background", 0, 0, 0, 0);

		newScreen = createScreen (2, "East Basic", 3, 0, 9, 0);
		newScreen.addNav ("navBtn_zoomIntoEastTVCloseup", 10);
		newScreen.addNav ("navBtn_zoomIntoEastBottomLeftTV", 11);
		newScreen.addNav ("navBtn_zoomIntoEastBottomRightTV", 12);
		newScreen.addVisState (gapegConst.C_VISSTATE_TV_ON_BARS_BLURRED, "vis_tv_on_bars_blurred", gapegConst.C_CONDITION_TV_ON_BARS_BLURRED);
		newScreen.addVisState (gapegConst.C_VISSTATE_TV_ON_NOBARS_BLURRED, "vis_tv_on_nobars_blurred", gapegConst.C_CONDITION_TV_ON_NOBARS_BLURRED);
		newScreen.addVisState (gapegConst.C_VISSTATE_TV_ON_NOBARS_FOCUSED, "vis_tv_on_nobars_focused", gapegConst.C_CONDITION_TV_ON_NOBARS_FOCUSED);
		newScreen.addVisState (gapegConst.C_VISSTATE_TOOTHBRUSH_GONE, "vis_toothbrush_gone", gapegConst.C_CONDITION_PICKED_UP_TOOTHBRUSH);
		
		newScreen = createScreen (3, "North-East Basic", 4, 0, 2, 0);
		newScreen.addNav ("navBtn_zoomIntoEastClock", 13);
		newScreen.addNav ("navBtn_zoomIntoNorthBathroomDoor", 29);
		newScreen.addVisState (gapegConst.C_VISSTATE_TV_ON_BARS_BLURRED, "vis_tv_on_bars_blurred", gapegConst.C_CONDITION_TV_ON_BARS_BLURRED);
		newScreen.addVisState (gapegConst.C_VISSTATE_TV_ON_NOBARS_BLURRED, "vis_tv_on_nobars_blurred", gapegConst.C_CONDITION_TV_ON_NOBARS_BLURRED);
		newScreen.addVisState (gapegConst.C_VISSTATE_TV_ON_NOBARS_FOCUSED, "vis_tv_on_nobars_focused", gapegConst.C_CONDITION_TV_ON_NOBARS_FOCUSED);
		newScreen.addVisState (gapegConst.C_VISSTATE_REMOTECONTROL_GONE, "vis_remotecontrol_gone", gapegConst.C_CONDITION_PICKED_UP_REMOTECONTROL);
		newScreen.addVisState (gapegConst.C_VISSTATE_TOOTHBRUSH_GONE, "vis_toothbrush_gone", gapegConst.C_CONDITION_PICKED_UP_TOOTHBRUSH);

		newScreen = createScreen (4, "North Basic", 5, 0, 3, 0);
		newScreen.addNav ("navBtn_zoomIntoNorthSideTable", 15);
		newScreen.addNav ("navBtn_zoomIntoNorthPhoto", 14);
		newScreen.addVisState (gapegConst.C_VISSTATE_REMOTECONTROL_GONE, "vis_remotecontrol_gone", gapegConst.C_CONDITION_PICKED_UP_REMOTECONTROL);
		newScreen.addVisState (gapegConst.C_VISSTATE_OLDKEY_GONE, "vis_oldkey_gone", gapegConst.C_CONDITION_PICKED_UP_OLDKEY);
		newScreen.addVisState (gapegConst.C_VISSTATE_CHESSKING_MISSING, "vis_chessking_missing", gapegConst.C_CONDITION_PICKED_UP_CHESSKING);

		newScreen = createScreen (5, "North-West Basic", 6, 0, 4, 0);
		newScreen.addNav ("navBtn_zoomIntoNorthWestKeyTable", 16);
		newScreen.addNav ("navBtn_zoomIntoNorthWestGrate", 18);
		newScreen.addNav ("navBtn_zoomIntoNorthFalseDoor", 20);
		newScreen.addNav ("navBtn_zoomIntoNorthWestWindow", 30);
		newScreen.addVisState (gapegConst.C_VISSTATE_REMOVED_GRATE, "vis_removed_grate", gapegConst.C_CONDITION_REMOVED_GRATE);
		newScreen.addVisState (gapegConst.C_VISSTATE_BLINDS_OPEN, "vis_blinds_open", gapegConst.C_CONDITION_BLINDS_OPEN);
		newScreen.addVisState (gapegConst.C_VISSTATE_GEMBLUE_MISSING, "vis_gemblue_missing", gapegConst.C_CONDITION_GEMBLUE_MISSING);

		newScreen = createScreen (6, "West Basic", 7, 0, 5, 0);
		newScreen.addNav ("navBtn_zoomIntoWestPhoto", 17);
		newScreen.addNav ("navBtn_zoomIntoNorthWestWindow", 30);
		newScreen.addNav ("navBtn_zoomIntoSouthWestWindow", 31);
		newScreen.addVisState (gapegConst.C_VISSTATE_BLINDS_OPEN, "vis_blinds_open", gapegConst.C_CONDITION_BLINDS_OPEN);
		newScreen.addVisState (gapegConst.C_VISSTATE_GEMBLUE_MISSING, "vis_gemblue_missing", gapegConst.C_CONDITION_GEMBLUE_MISSING);

		newScreen = createScreen (7, "South-West Basic", 8, 0, 6, 0);
		newScreen.addNav ("navBtn_zoomIntoBookshelf", 21);
		newScreen.addNav ("navBtn_zoomIntoRubbishBin", 22);
		newScreen.addNav ("navBtn_zoomIntoSouthWestWindow", 31);
		newScreen.addVisState (gapegConst.C_VISSTATE_USBKEY_PLUGGED_IN, "vis_usbkey_plugged_in", gapegConst.C_CONDITION_USBKEY_NOT_PLUGGED_IN);
		newScreen.addVisState (gapegConst.C_VISSTATE_COMPUTERPOWERBUTTON_ON, "vis_computerpowerbutton_on", gapegConst.C_CONDITION_COMPUTER_ON);
		newScreen.addVisState (gapegConst.C_VISSTATE_BUDDAH_MISSING, "vis_buddah_missing", gapegConst.C_CONDITION_PICKED_UP_BUDDAH);
		newScreen.addVisState (gapegConst.C_VISSTATE_BLINDS_OPEN, "vis_blinds_open", gapegConst.C_CONDITION_BLINDS_OPEN);

		newScreen = createScreen (8, "South Basic", 9, 0, 7, 0);
		newScreen.addNav ("navBtn_zoomIntoComputer", 23);
		newScreen.addNav ("navBtn_zoomIntoPaperOnDesk", 25);
		newScreen.addNav ("navBtn_zoomIntoCeramicWallOrnament", 26);
		newScreen.addVisState (gapegConst.C_VISSTATE_COMPUTERSCREEN_ON, "vis_computerscreen_on", gapegConst.C_CONDITION_COMPUTER_ON);
		newScreen.addVisState (gapegConst.C_VISSTATE_FLASHINGCURSOR_ON, "vis_flashingcursor_on", gapegConst.C_CONDITION_COMPUTER_CURSOR_FLASHING);
		newScreen.addVisState (gapegConst.C_VISSTATE_USBKEY_PLUGGED_IN, "vis_usbkey_plugged_in", gapegConst.C_CONDITION_USBKEY_NOT_PLUGGED_IN);
		newScreen.addVisState (gapegConst.C_VISSTATE_COMPUTERPOWERBUTTON_ON, "vis_computerpowerbutton_on", gapegConst.C_CONDITION_COMPUTER_ON);
		newScreen.addVisState (gapegConst.C_VISSTATE_CHESSPUZZLE_VISIBLE, "vis_chesspuzzle_visible", gapegConst.C_CONDITION_COMPUTER_CHESSPUZZLE_VISIBLE);
		newScreen.addVisState (gapegConst.C_VISSTATE_BUDDAH_MISSING, "vis_buddah_missing", gapegConst.C_CONDITION_PICKED_UP_BUDDAH);
		newScreen.addVisState (gapegConst.C_VISSTATE_PEN_MISSING, "vis_pen_missing", gapegConst.C_CONDITION_PICKED_UP_PEN);

		newScreen = createScreen (9, "South-East Basic", 2, 0, 8, 0);
		newScreen.addNav ("navBtn_zoomIntoClosetDoor", 27);
		newScreen.addNav ("navBtn_zoomIntoPotPlant", 28);
		newScreen.addVisState (gapegConst.C_VISSTATE_TV_ON_BARS_BLURRED, "vis_tv_on_bars_blurred", gapegConst.C_CONDITION_TV_ON_BARS_BLURRED);
		newScreen.addVisState (gapegConst.C_VISSTATE_TV_ON_NOBARS_BLURRED, "vis_tv_on_nobars_blurred", gapegConst.C_CONDITION_TV_ON_NOBARS_BLURRED);
		newScreen.addVisState (gapegConst.C_VISSTATE_TV_ON_NOBARS_FOCUSED, "vis_tv_on_nobars_focused", gapegConst.C_CONDITION_TV_ON_NOBARS_FOCUSED);

		newScreen = createScreen (10, "East TV Screen Close Up", 0, 0, 0, 2);
		newScreen.addVisState (gapegConst.C_VISSTATE_TV_ON_BARS_BLURRED, "vis_tv_on_bars_blurred", gapegConst.C_CONDITION_TV_ON_BARS_BLURRED);
		newScreen.addVisState (gapegConst.C_VISSTATE_TV_ON_NOBARS_BLURRED, "vis_tv_on_nobars_blurred", gapegConst.C_CONDITION_TV_ON_NOBARS_BLURRED);
		newScreen.addVisState (gapegConst.C_VISSTATE_TV_ON_NOBARS_FOCUSED, "vis_tv_on_nobars_focused", gapegConst.C_CONDITION_TV_ON_NOBARS_FOCUSED);

		newScreen = createScreen (11, "East TV Screen Bottom Left", 0, 0, 0, 2);
		newScreen.addVisState (gapegConst.C_VISSTATE_TV_ON, "vis_tv_on", gapegConst.C_CONDITION_TV_ON);
		newScreen.addVisState (gapegConst.C_VISSTATE_TOOTHBRUSH_GONE, "vis_toothbrush_gone", gapegConst.C_CONDITION_PICKED_UP_TOOTHBRUSH);

		newScreen = createScreen (12, "East TV Screen Bottom Right", 0, 0, 0, 2);
		newScreen.addVisState (gapegConst.C_VISSTATE_TV_ON, "vis_tv_on", gapegConst.C_CONDITION_TV_ON);
		
		newScreen = createScreen (13, "East Clock Close Up", 0, 0, 0, 3);

		newScreen = createScreen (14, "North Photo Close Up", 0, 0, 0, 4);

		newScreen = createScreen (15, "North Side Table Close Up", 0, 14, 0, 4);
		newScreen.addVisState (gapegConst.C_VISSTATE_REMOTECONTROL_GONE, "vis_remotecontrol_gone", gapegConst.C_CONDITION_PICKED_UP_REMOTECONTROL);
		newScreen.addVisState (gapegConst.C_VISSTATE_OLDKEY_GONE, "vis_oldkey_gone", gapegConst.C_CONDITION_PICKED_UP_OLDKEY);
		newScreen.addVisState (gapegConst.C_VISSTATE_CHESSKING_MISSING, "vis_chessking_missing", gapegConst.C_CONDITION_PICKED_UP_CHESSKING);
		
		newScreen = createScreen (16, "North West Key Table Close Up", 0, 0, 20, 5);

		newScreen = createScreen (17, "West Photo Close Up", 31, 0, 30, 6);
		newScreen.addVisState (gapegConst.C_VISSTATE_BLINDS_OPEN, "vis_blinds_open", gapegConst.C_CONDITION_BLINDS_OPEN);

		newScreen = createScreen (18, "North West Grate Close Up", 0, 0, 0, 5);
		newScreen.addSubFrame (2, gapegConst.C_CONDITION_REMOVED_GRATE);
		newScreen.addVisState (gapegConst.C_VISSTATE_USBKEYSHEATHED_GONE, "vis_usbkeysheathed_gone", gapegConst.C_CONDITION_PICKED_UP_USBKEYSHEATHED);
		newScreen.addVisState (gapegConst.C_VISSTATE_CAMERA_UNFOCUSED, "vis_camera_unfocused", gapegConst.C_CONDITION_CAMERA_UNFOCUSED);
		newScreen.addVisState (gapegConst.C_VISSTATE_CAMERA_FOCUSED, "vis_camera_focused", gapegConst.C_CONDITION_CAMERA_FOCUSED);

		newScreen = createScreen (20, "North False Door Close Up", 16, 0, 0, 5);

		newScreen = createScreen (21, "Book Shelf Close Up", 0, 0, 0, 7);
		newScreen.addVisState (gapegConst.C_VISSTATE_BUDDAH_MISSING, "vis_buddah_missing", gapegConst.C_CONDITION_PICKED_UP_BUDDAH);

		newScreen = createScreen (22, "Rubbish Bin Close Up", 0, 0, 0, 7);

		newScreen = createScreen (23, "Computer Close Up", 0, 0, 0, 8);
		newScreen.addNav ("navBtn_zoomIntoComputerScreen", 24);
		newScreen.addVisState (gapegConst.C_VISSTATE_COMPUTERSCREEN_ON, "vis_computerscreen_on", gapegConst.C_CONDITION_COMPUTER_ON);
		newScreen.addVisState (gapegConst.C_VISSTATE_FLASHINGCURSOR_ON, "vis_flashingcursor_on", gapegConst.C_CONDITION_COMPUTER_CURSOR_FLASHING);
		newScreen.addVisState (gapegConst.C_VISSTATE_USBKEY_PLUGGED_IN, "vis_usbkey_plugged_in", gapegConst.C_CONDITION_USBKEY_NOT_PLUGGED_IN);
		newScreen.addVisState (gapegConst.C_VISSTATE_COMPUTERPOWERBUTTON_ON, "vis_computerpowerbutton_on", gapegConst.C_CONDITION_COMPUTER_ON);
		newScreen.addVisState (gapegConst.C_VISSTATE_CHESSPUZZLE_VISIBLE, "vis_chesspuzzle_visible", gapegConst.C_CONDITION_COMPUTER_CHESSPUZZLE_VISIBLE);
		newScreen.addVisState (gapegConst.C_VISSTATE_PEN_MISSING, "vis_pen_missing", gapegConst.C_CONDITION_PICKED_UP_PEN);

		newScreen = createScreen (24, "Computer Screen Close Up", 0, 0, 0, 23);
		newScreen.addVisState (gapegConst.C_VISSTATE_COMPUTERSCREEN_ON, "vis_computerscreen_on", gapegConst.C_CONDITION_COMPUTER_ON);
		newScreen.addVisState (gapegConst.C_VISSTATE_FLASHINGCURSOR_ON, "vis_flashingcursor_on", gapegConst.C_CONDITION_COMPUTER_CURSOR_FLASHING);
		newScreen.addVisState (gapegConst.C_VISSTATE_CHESSPUZZLE_VISIBLE, "vis_chesspuzzle_visible", gapegConst.C_CONDITION_COMPUTER_CHESSPUZZLE_VISIBLE);

		newScreen = createScreen (25, "Paper on Desk Close Up", 0, 0, 0, 8);
		newScreen.addVisState (gapegConst.C_VISSTATE_PEN_MISSING, "vis_pen_missing", gapegConst.C_CONDITION_PICKED_UP_PEN);

		newScreen = createScreen (26, "Ceramic Wall Ornament Close Up", 0, 0, 0, 8);

		newScreen = createScreen (27, "South Closet Door Closet Up", 0, 0, 0, 9);
		
		newScreen = createScreen (28, "South West Pot Plant Closet Up", 0, 0, 0, 9);

		newScreen = createScreen (29, "North Bathroom Door Close Up", 0, 0, 0, 3);

		newScreen = createScreen (30, "North West Window Close Up", 17, 0, 0, 6);
		newScreen.addVisState (gapegConst.C_VISSTATE_BLINDS_OPEN, "vis_blinds_open", gapegConst.C_CONDITION_BLINDS_OPEN);
		newScreen.addVisState (gapegConst.C_VISSTATE_GEMBLUE_MISSING, "vis_gemblue_missing", gapegConst.C_CONDITION_GEMBLUE_MISSING);

		newScreen = createScreen (31, "Sout West Window Close Up", 0, 0, 17, 6);
		newScreen.addVisState (gapegConst.C_VISSTATE_BLINDS_OPEN, "vis_blinds_open", gapegConst.C_CONDITION_BLINDS_OPEN);
		
		
		
	}
}
