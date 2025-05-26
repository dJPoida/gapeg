/**
    Gapeg Condition Class
    author: Peter Eldred
    version: 0.1
    created: 2008-02-29
    copyright: Peter Eldred

    This code holds the specifics of a condition
*/
class gapegCondition {
	var __gapegEngine: gapegEngine;
	var __conditionHandler: gapegConditionHandler;
	var __conditionID: Number;
	
	var __mustHaveFoundItems: Array;
	var __countOfMustHaveFoundItems: Number;

	var __switchOns: Array;
	var __countOfSwitchOns: Number;

	var __switchOffs: Array;
	var __countOfSwitchOffs: Number;
	
	//Constructor
	public function gapegCondition (p_gapegEngine: gapegEngine, p_conditionHandler:gapegConditionHandler, p_conditionID: Number) {
		this.__gapegEngine = p_gapegEngine;
		this.__conditionHandler = p_conditionHandler;
		this.__conditionID = p_conditionID;
		
		this.__mustHaveFoundItems = new Array();
		this.__countOfMustHaveFoundItems = 0;

		this.__switchOns = new Array();
		this.__countOfSwitchOns = 0;

		this.__switchOffs = new Array();
		this.__countOfSwitchOffs = 0;
	}
	
	public function get conditionHandler ():gapegConditionHandler {
		return this.__conditionHandler;
	}
	
	public function get conditionID (): Number {
		return this.__conditionID;
	}
	
	public function isSatisfied (): Boolean {
		var _satisfied: Boolean = true;
		
		//Check the Found Items
		if (this.__countOfMustHaveFoundItems > 0) {
			for (var i:Number = 1; i <= this.__countOfMustHaveFoundItems; i++) { 
				_satisfied = _satisfied  and this.__gapegEngine.foundItem(this.__mustHaveFoundItems[i]);
			}
		}
		
		//Check the True Switches
		if (this.__countOfSwitchOns > 0) {
			for (var i:Number = 1; i <= this.__countOfSwitchOns; i++) { 
				_satisfied = _satisfied and this.__gapegEngine.switchStatus(this.__switchOns[i]);
			}
		}

		//Check the False Switches
		if (this.__countOfSwitchOffs > 0) {
			for (var i:Number = 1; i <= this.__countOfSwitchOffs; i++) { 
				_satisfied = (_satisfied and (not this.__gapegEngine.switchStatus(this.__switchOffs[i])));
			}
		}
		
		return _satisfied;
	}
	
	//A "Must Have Found Item" condition is met if the player has EVER Found the item
	public function mustHaveFoundItem (p_ItemID: Number) {
		this.__countOfMustHaveFoundItems += 1;
		this.__mustHaveFoundItems [this.__countOfMustHaveFoundItems] = p_ItemID;
	}
	
	//A "Switch Toggle" condition is met if the standard boolean value of the Switch Toggle is True
	public function switchOn (p_switchID: Number) {
		this.__countOfSwitchOns += 1;
		this.__switchOns [this.__countOfSwitchOns] = p_switchID;
	}

	//A "Switch Toggle" condition is met if the standard boolean value of the Switch Toggle is True
	public function switchOff (p_switchID: Number) {
		this.__countOfSwitchOffs += 1;
		this.__switchOffs [this.__countOfSwitchOffs] = p_switchID;
	}
	
}
