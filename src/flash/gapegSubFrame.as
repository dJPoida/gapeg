/**
    Gapeg Sub Frame class
    author: Peter Eldred
    version: 0.1
    created: 2008-02-26
    copyright: Peter Eldred

    The sub frames are quite simple, but necessary. They exist within each Gapeg Screen and are 
	selected based on the satisfaciton of Conditions.
*/
class gapegSubFrame {
	var __gapegEngine: gapegEngine;
	var __frameNo: Number;
	var __requiredConditionID: Number;
	
	//Constructor
	public function gapegSubFrame (p_gapegEngine: gapegEngine, p_frameNo: Number, p_requiredConditionID: Number) {
		this.__gapegEngine = p_gapegEngine;
		this.__frameNo = p_frameNo;
		this.__requiredConditionID = p_requiredConditionID;
	}
	
	public function get frameNo ():Number {
		return this.__frameNo;
	}	

	public function get requiredConditionID ():Number {
		return this.__requiredConditionID;
	}	
	
	public function get requiredCondition ():gapegCondition {
		var _requiredCondition: gapegCondition;
		
		_requiredCondition = this.__gapegEngine.conditionHandler.getConditionByID(this.__requiredConditionID);
		
		return _requiredCondition;
	}	
	
}