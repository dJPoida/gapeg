/**
    Gapeg Condition Handler Class
    author: Peter Eldred
    version: 0.1
    created: 2008-02-29
    copyright: Peter Eldred

    This code defines and controlls the conditions of the game for the engine
*/
class gapegConditionHandler {
	var __gapegEngine: gapegEngine;
	
	var __conditions: Array;
	var __conditionCount: Number;
	
	//Constructor
	public function gapegConditionHandler (p_gapegEngine:gapegEngine) {
		this.__gapegEngine = p_gapegEngine;
		
		this.__conditions = new Array();
		this.__conditionCount = 0;
		
		this.initConditions();
	}
	
	public function get conditionCount ():Number {
		return this.__conditionCount;
	}
	
	private function addCondition (p_conditionID: Number) {
		this.__conditionCount += 1;
		this.__conditions [this.__conditionCount] = new gapegCondition (this.__gapegEngine, this, p_conditionID);
		
		return this.__conditions [this.__conditionCount];
	}
	
	public function getConditionByID(p_conditionID): gapegCondition {
		var returnCondition: gapegCondition;
		
		for (var i:Number = 0; i <= this.__conditionCount; i++) { 
			if (this.__conditions[i].conditionID == p_conditionID) {
				returnCondition = this.__conditions[i];
				break;
			}
		}
		
		return returnCondition;
	}
	
	//---------------------------------
	// Here's where the Bulk of the Work is Done
	//---------------------------------
	private function initConditions() {
		var newCondition: gapegCondition;
		
		//1 - C_CONDITION_PICKED_UP_VENUS_STATUE
		newCondition = addCondition(gapegConst.C_CONDITION_PICKED_UP_VENUS_STATUE);
		newCondition.mustHaveFoundItem (gapegConst.C_ITEM_VENUS_STATUE);

		//2 - C_CONDITION_PICKED_UP_TOOTHBRUSH
		newCondition = addCondition(gapegConst.C_CONDITION_PICKED_UP_TOOTHBRUSH);
		newCondition.mustHaveFoundItem (gapegConst.C_ITEM_TOOTHBRUSH);
		
		//3 - C_CONDITION_TV_ON
		newCondition = addCondition(gapegConst.C_CONDITION_TV_ON);
		newCondition.switchOn (gapegConst.C_SWITCH_TV_POWER_BUTTON);
		
		//4 - C_CONDITION_HAS_SEEN_TV_IMAGE
		newCondition = addCondition(gapegConst.C_CONDITION_HAS_SEEN_TV_IMAGE);
		newCondition.switchOn (gapegConst.C_SWITCH_HAS_SEEN_TV_IMAGE);
		
		//5 - C_CONDITION_PICKED_UP_REMOTECONTROL
		newCondition = addCondition(gapegConst.C_CONDITION_PICKED_UP_REMOTECONTROL);
		newCondition.mustHaveFoundItem (gapegConst.C_ITEM_REMOTECONTROL);

		//6 - C_CONDITION_PICKED_UP_OLDKEY
		newCondition = addCondition(gapegConst.C_CONDITION_PICKED_UP_OLDKEY);
		newCondition.mustHaveFoundItem (gapegConst.C_ITEM_OLDKEY);

		//7 - C_CONDITION_REMOVED_GRATE
		newCondition = addCondition(gapegConst.C_CONDITION_REMOVED_GRATE);
		newCondition.switchOn (gapegConst.C_SWITCH_REMOVED_GRATE);
		
		//8 - C_CONDITION_PICKED_UP_USBKEYSHEATHED
		newCondition = addCondition(gapegConst.C_CONDITION_PICKED_UP_USBKEYSHEATHED);
		newCondition.mustHaveFoundItem (gapegConst.C_ITEM_USBKEYSHEATHED);
		
		//9 - C_CONDITION_USBKEY_OPENED
		newCondition = addCondition(gapegConst.C_CONDITION_USBKEY_OPENED);
		newCondition.mustHaveFoundItem (gapegConst.C_ITEM_USBKEY);
		
		//10 - C_CONDITION_USBKEY_PLUGGED_IN
		newCondition = addCondition(gapegConst.C_CONDITION_USBKEY_PLUGGED_IN);
		newCondition.switchOn (gapegConst.C_SWITCH_USBKEY_PLUGGED_IN);

		//11 - C_CONDITION_COMPUTER_ON
		newCondition = addCondition(gapegConst.C_CONDITION_COMPUTER_ON);
		newCondition.switchOn (gapegConst.C_SWITCH_COMPUTER_ON);
		
		//12 - C_CONDITION_COMPUTER_CURSOR_FLASHING
		newCondition = addCondition(gapegConst.C_CONDITION_COMPUTER_CURSOR_FLASHING);
		newCondition.switchOn (gapegConst.C_SWITCH_COMPUTER_ON);
		newCondition.switchOff (gapegConst.C_SWITCH_USBKEY_PLUGGED_IN);
		
		//13 - C_CONDITION_USBKEY_NOT_PLUGGED_IN
		newCondition = addCondition(gapegConst.C_CONDITION_USBKEY_NOT_PLUGGED_IN);
		newCondition.switchOff (gapegConst.C_SWITCH_USBKEY_PLUGGED_IN);

		//14 - C_CONDITION_COMPUTER_CHESSPUZZLE_VISIBLE
		newCondition = addCondition(gapegConst.C_CONDITION_COMPUTER_CHESSPUZZLE_VISIBLE);
		newCondition.switchOn (gapegConst.C_SWITCH_COMPUTER_ON);
		newCondition.switchOn (gapegConst.C_SWITCH_USBKEY_PLUGGED_IN);

		//15 - C_CONDITION_TV_ON_BARS_BLURRED
		newCondition = addCondition(gapegConst.C_CONDITION_TV_ON_BARS_BLURRED);
		newCondition.switchOn (gapegConst.C_SWITCH_TV_POWER_BUTTON);
		newCondition.switchOff (gapegConst.C_SWITCH_REMOVED_GRATE);
		newCondition.switchOff (gapegConst.C_SWITCH_CAMERA_INFOCUS);
		
		//16 - C_CONDITION_TV_ON_NOBARS_BLURRED
		newCondition = addCondition(gapegConst.C_CONDITION_TV_ON_NOBARS_BLURRED);
		newCondition.switchOn (gapegConst.C_SWITCH_TV_POWER_BUTTON);
		newCondition.switchOn (gapegConst.C_SWITCH_REMOVED_GRATE);
		newCondition.switchOff (gapegConst.C_SWITCH_CAMERA_INFOCUS);
		
		//17 - C_CONDITION_TV_ON_NOBARS_FOCUSED
		newCondition = addCondition(gapegConst.C_CONDITION_TV_ON_NOBARS_FOCUSED);
		newCondition.switchOn (gapegConst.C_SWITCH_TV_POWER_BUTTON);
		newCondition.switchOn (gapegConst.C_SWITCH_REMOVED_GRATE);
		newCondition.switchOn (gapegConst.C_SWITCH_CAMERA_INFOCUS);

		//18 - C_CONDITION_CAMERA_UNFOCUSED
		newCondition = addCondition(gapegConst.C_CONDITION_CAMERA_UNFOCUSED);
		newCondition.switchOff (gapegConst.C_SWITCH_CAMERA_INFOCUS);

		//19 - C_CONDITION_CAMERA_FOCUSED
		newCondition = addCondition(gapegConst.C_CONDITION_CAMERA_FOCUSED);
		newCondition.switchOn (gapegConst.C_SWITCH_CAMERA_INFOCUS);
		
		//20 - C_CONDITION_PICKED_UP_BUDDAH
		newCondition = addCondition(gapegConst.C_CONDITION_PICKED_UP_BUDDAH);
		newCondition.mustHaveFoundItem (gapegConst.C_ITEM_BUDDAH);

		//21 - C_CONDITION_PICKED_UP_PEN
		newCondition = addCondition(gapegConst.C_CONDITION_PICKED_UP_PEN);
		newCondition.mustHaveFoundItem (gapegConst.C_ITEM_PEN);
		
		//22 - C_CONDITION_BLINDS_OPEN
		newCondition = addCondition(gapegConst.C_CONDITION_BLINDS_OPEN);
		newCondition.switchOn (gapegConst.C_SWITCH_BLINDS_OPEN);
		
		//23 - C_CONDITION_PICKED_UP_GEMBLUE
		newCondition = addCondition(gapegConst.C_CONDITION_PICKED_UP_GEMBLUE);
		newCondition.mustHaveFoundItem (gapegConst.C_ITEM_GEMBLUE);
		
		//24 - C_CONDITION_GEMBLUE_MISSING
		newCondition = addCondition(gapegConst.C_CONDITION_GEMBLUE_MISSING);
		newCondition.mustHaveFoundItem (gapegConst.C_ITEM_GEMBLUE);
		newCondition.switchOn (gapegConst.C_SWITCH_BLINDS_OPEN);

		//25 - C_CONDITION_PICKED_UP_CHESSKING
		newCondition = addCondition(gapegConst.C_CONDITION_PICKED_UP_CHESSKING);
		newCondition.mustHaveFoundItem (gapegConst.C_ITEM_CHESSKING);
		
	}
	
}
