/**
    Gapeg Screen class
    author: Peter Eldred
    version: 0.1
    created: 2008-02-26
    copyright: Peter Eldred

    This code controlls the parameters around an individual screen
*/
class gapegScreen {
	var __gapegEngine: gapegEngine;
	
	var __ID: Number;
	var __leftID: Number;
	var __upID: Number;
	var __rightID: Number;
	var __downID: Number;
	var __screenLabel: String;
	
	var __navBtns: Array;
	var __navBtnCount: Number;
	
	var __subFrames: Array;
	var __subFrameCount: Number;
	
	var __visStates: Array;
	var __visStateCount: Number;
	
	//Constructor
	public function gapegScreen (p_gapegEngine, p_newID) {
		this.__gapegEngine = p_gapegEngine;
		
		this.__ID = p_newID;
		this.__leftID = 0;
		this.__upID = 0;
		this.__rightID = 0;
		this.__downID = 0;
		this.__screenLabel = "Not Assigned Yet";
		
		this.__navBtns = new Array ();
		this.__navBtnCount = 0;
		
		this.__subFrames = new Array ();
		this.__subFrameCount = 1;
		
		this.__visStates = new Array ();
		this.__visStateCount = 0;
	}

	public function addNav (p_buttonName, p_targetScreen) {
		this.__navBtnCount += 1;
		this.__navBtns [this.__navBtnCount] = new gapegNavBtn(p_buttonName, p_targetScreen);
	}
	
	public function findNavBtnByName (p_navBtnName: String): gapegNavBtn {
		var resultNavBtn: gapegNavBtn;
		
		for (var i:Number = 0; i <= this.__navBtnCount; i++) { 
			if (this.__navBtns[i].buttonName == p_navBtnName) {
				resultNavBtn = this.__navBtns[i];
			}
		} 
		return resultNavBtn;
	}
	
	//By default, sub frame 1 is never added because it's not really required. It's the default frame 1.
	public function addSubFrame (p_frameNo: Number, p_requiredConditionID: Number) {
		this.__subFrameCount += 1;
		this.__subFrames [this.__subFrameCount] = new gapegSubFrame(this.__gapegEngine, p_frameNo, p_requiredConditionID);
	}
	
	public function subFrame (p_subFrameNo: Number): gapegSubFrame {
		var _subFrame: gapegSubFrame;
		
		for (var i:Number = 1; i <= this.__subFrameCount; i++) { 
			if (this.__subFrames[i].frameNo == p_subFrameNo) {
				_subFrame = this.__subFrames[i];
				break;
			}
		}

		return _subFrame;
	}
	
	public function get subFrameCount (): Number {
		return this.__subFrameCount;
	}
	
	
	public function addVisState (p_visStateID: Number, p_visStateMCName: String, p_requiredConditionID: Number) {
		this.__visStateCount += 1;
		this.__visStates [this.__visStateCount] = new gapegVisState(this.__gapegEngine, p_visStateMCName, p_visStateID, p_requiredConditionID);
	}

	public function visStateByNo (p_visStateNo: Number): gapegVisState {
		return this.__visStates[p_visStateNo];
	}

	public function visStateByID (p_visStateID: Number): gapegVisState {
		var _visState: gapegVisState;
		
		for (var i:Number = 1; i <= this.__visStateCount; i++) { 
			if (this.__visStates[i].visStateID == p_visStateID) {
				_visState = this.__visStates[i];
				break;
			}
		}

		return _visState;
	}
	
	public function get visStateCount (): Number {
		return this.__visStateCount;
	}
	
	public function get ID ():Number {
		return this.__ID;
	}
	
	public function get screenLabel ():String {
		return this.__screenLabel;
	}
	
	public function set screenLabel (value:String):Void {
		this.__screenLabel = value;
	}

	public function get leftID ():Number {
		return this.__leftID;
	}
	
	public function set leftID (value:Number):Void {
		this.__leftID = value;
	}
	
	public function get upID ():Number {
		return this.__upID;
	}
	
	public function set upID (value:Number):Void {
		this.__upID = value;
	}

	public function get rightID ():Number {
		return this.__rightID;
	}
	
	public function set rightID (value:Number):Void {
		this.__rightID = value;
	}

	public function get downID ():Number {
		return this.__downID;
	}
	
	public function set downID (value:Number):Void {
		this.__downID = value;
	}
}