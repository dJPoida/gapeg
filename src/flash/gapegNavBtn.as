/**
    Gapeg Nav Button class
    author: Peter Eldred
    version: 0.1
    created: 2008-02-28
    copyright: Peter Eldred

    This code defines the Nav button Type
*/
class gapegNavBtn {
	var __buttonName: String;
	var __targetScreenID: Number;
	
	public function gapegNavBtn (p_buttonName, p_targetScreenID) {
		this.__buttonName = p_buttonName;
		this.__targetScreenID = p_targetScreenID;
	}

	public function get buttonName ():String {
		return this.__buttonName;
	}
	
	public function set buttonName (value:String):Void {
		this.__buttonName = value;
	}	
	
	public function get targetScreenID ():Number {
		return this.__targetScreenID;
	}
	
	public function set targetScreenID (value:Number):Void {
		this.__targetScreenID = value;
	}	
}