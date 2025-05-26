/**
    Gapeg Inventory Item class
    author: Peter Eldred
    version: 0.1
    created: 2008-02-28
    copyright: Peter Eldred

    This code the parameters around an inventory Item
*/
class gapegInventoryItem {
	var __gapegInventoryHandler: gapegInventoryHandler;
	
	var __inventoryID: Number;
	var __inventoryMC: MovieClip;
	var __containsItemID: Number;
	
	//Constructor
	public function gapegInventoryItem (p_gapegInventoryHandler: gapegInventoryHandler, p_newID: Number) {
		this.__gapegInventoryHandler = p_gapegInventoryHandler;
		this.__inventoryID = p_newID;
		
		this.__inventoryMC = eval(this.__gapegInventoryHandler.inventoryMC + ".inv" + this.__inventoryID);

		//Give the InventoryMC Some Idea of what Number it is.
		this.__inventoryMC.invID = this.__inventoryID;
		
		this.containsItemID = 0;
	}
	
	public function get inventoryID ():Number {
		return this.__inventoryID;
	}

	public function get isEmpty ():Boolean {
		return (this.__containsItemID == 0);
	}

	public function get isNotEmpty ():Boolean {
		return (this.__containsItemID > 0);
	}
	
	public function get containsItemID ():Number {
		return this.__containsItemID;
	}

	public function set containsItemID (value:Number):Void {
		this.__containsItemID = value;

		//Scroll to Appropriate Frame
		this.__inventoryMC.gotoAndStop(this.__containsItemID + 1);
		
		//Hide the Buttons for using the control
		this.__inventoryMC.btn_selectItem._visible = this.isNotEmpty;
		this.__inventoryMC.btn_viewItem._visible = this.isNotEmpty;
	}
	
	public function showAsNotSelected () {
		this.__inventoryMC.itemBackground.gotoAndStop(1);
	}
	
	public function showAsSelected () {
		this.__inventoryMC.itemBackground.gotoAndStop(2);
	}
	
	public function empty() {
		this.containsItemID = 0;
	}
	
}