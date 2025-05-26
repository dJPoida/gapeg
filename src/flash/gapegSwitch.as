/**
    Gapeg Switch Class
    author: Peter Eldred
    version: 0.1
    created: 2008-02-29
    copyright: Peter Eldred

    This code holds the specifics of a switch
*/
class gapegSwitch {
	var __gapegEngine: gapegEngine;
	var __switchID: Number;
	var __isActive: Boolean;
	
	//Constructor
	public function gapegSwitch (p_gapegEngine: gapegEngine, p_switchID:Number, p_defaultState: Boolean) {
		this.__gapegEngine = p_gapegEngine;
		this.__switchID = p_switchID;
		this.__isActive = p_defaultState;
		
	}
	
	public function get isActive(): Boolean {
		return this.__isActive;
	}
	
	public function set isActive (value:Boolean): Void {
		this.__isActive = value;
	}
	
	public function get switchID(): Number {
		return this.__switchID;
	}
	
	public function toggle () {
		this.isActive = not this.isActive;
	}
	
}
