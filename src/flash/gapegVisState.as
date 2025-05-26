/**
    Gapeg Visual State
    author: Peter Eldred
    version: 0.1
    created: 2008-03-17
    copyright: Peter Eldred

    This code holds basically maintains a Visual State within a screen.
	
	Each screen has multiple frames - each frame holds a visual state object that can change
	depending on the conditions of the game. There can only be two frames to each Vis State.
	A True and a False frame, so use a combination of Vis States and Conditions to achieve the correct result.
*/
class gapegVisState {
	var __gapegEngine: gapegEngine;
	var __visStateID: Number;
	var __gapegConditionID: Number;
	var __visStateMCName: String;
	
	//Constructor
	public function gapegVisState (p_gapegEngine: gapegEngine, p_visStateMCName: String, p_visStateID:Number, p_conditionID: Number) {
		this.__gapegEngine = p_gapegEngine;
		this.__visStateMCName = p_visStateMCName;
		this.__visStateID = p_visStateID;
		this.__gapegConditionID = p_conditionID;		
	}
	
	public function get gapegConditionID(): Number {
		return this.__gapegConditionID;
	}
	
	public function set gapegConditionID (value:Number): Void {
		this.__gapegConditionID = value;
	}
	
	public function get visStateID(): Number {
		return this.__visStateID;
	}	
	
	public function get visStateMCName(): String {
		return this.__visStateMCName;
	}
}
