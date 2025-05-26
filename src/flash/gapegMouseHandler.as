/**
    Gapeg Mouse Handler class
    author: Peter Eldred
    version: 0.1
    created: 2008-02-27
    copyright: Peter Eldred

    This code controlls the brunt of the Mouse Handling Functions
*/
class gapegMouseHandler {
	public var C_MC_STANDARDPOINTER = 1;
	public var C_MC_STANDARDHAND = 2;
	public var C_MC_INVENTORYITEM = 3;

	var __parentMC: MovieClip;
	var __gapegEngine: gapegEngine;
	
	var __mouseMC: MovieClip;
	var __mouseListerner: Object;
	
	var __currentCursorID: Number;
	var __currentItemCursorID: Number;
	
	//Constructor
	public function gapegMouseHandler (p_gapegEngine: gapegEngine, p_parentMC:MovieClip) {
		this.__gapegEngine = p_gapegEngine;
		this.__parentMC = p_parentMC;
		this.__currentCursorID = this.C_MC_STANDARDPOINTER;
		this.__currentItemCursorID = 0;

		this.__mouseMC = this.__parentMC.attachMovie("mouseCursors", "mouseCursor", this.__parentMC.getNextHighestDepth());
		
		Mouse.hide();
		
		var ref = this;
		this.__mouseListerner = new Object();
		this.__mouseListerner.onMouseMove = function() {
			ref.__mouseMC._x = _xmouse;
			ref.__mouseMC._y = _ymouse;

			//This is important. Sometimes the mouse cursor forgets that it's supposed to be hidden.
			Mouse.hide();
			
			updateAfterEvent();
		};
		Mouse.addListener(this.__mouseListerner);
		
		this.setCursor (this.C_MC_STANDARDPOINTER);
		//Init the Cursor Position
		this.__mouseMC._x = _xmouse;
		this.__mouseMC._y = _ymouse;
	}

	public function setCursor (p_newCursorID: Number, p_itemID: Number) {
		this.__currentCursorID = p_newCursorID;
		this.__mouseMC.gotoAndStop(p_newCursorID);
		
		//If the cursor is an Inventory Item then move the MC to the right Frame
		if (p_newCursorID == this.C_MC_INVENTORYITEM) {
			this.__mouseMC.mcInventoryItem.gotoAndStop(p_itemID);
			this.__currentItemCursorID = p_itemID;
		} else {
			this.__currentItemCursorID = 0;
		}
	}	
	
	public function get selectedInventoryItem():Number {
		return this.__currentItemCursorID;
	}
	
	public function get nothingSelected(): Boolean {
		return (this.__currentItemCursorID == 0);
	}
	
}