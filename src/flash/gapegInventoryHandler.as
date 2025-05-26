/**
    Gapeg Inventory Handler class
    author: Peter Eldred
    version: 0.1
    created: 2008-02-28
    copyright: Peter Eldred

    This code controlls the brunt of the Inventory Logic
	
*/
class gapegInventoryHandler {
	var C_INVENTORYITEMSLOTS: Number = 14;

	var __gapegEngine: gapegEngine;
	
	var __inventoryMC: MovieClip;
	
	var __inventoryItems: Array;
	
	var __selectedInventoryID: Number;
	
	//Constructor
	public function gapegInventoryHandler (p_gapegEngine:gapegEngine, p_inventoryMC: MovieClip) {
		this.__gapegEngine = p_gapegEngine;
		this.__inventoryMC = p_inventoryMC;
		this.__selectedInventoryID = 0;
		this.__inventoryItems = new Array();
		
		this.initInventoryItems();
	}
	
	private function initInventoryItems () {
		for (var i:Number = 0; i <= this.C_INVENTORYITEMSLOTS; i++) { 
			this.__inventoryItems[i] = new gapegInventoryItem (this, i);
		}
	}
	
	public function get inventoryMC ():MovieClip {
		return this.__inventoryMC;
	}
	
	public function set inventoryMC (value:MovieClip):Void {
		this.__inventoryMC = value;
	}	
	
	public function inventorySlot (value: Number): gapegInventoryItem {
		return this.__inventoryItems[value];
	}
	
	private function findFreeInventorySlot(): Number {
		var returnInventoryID: Number = 0;
		
		for (var i:Number = 1; i <= this.C_INVENTORYITEMSLOTS; i++) { 
			if (this.__inventoryItems[i].isEmpty) {
				returnInventoryID = i;
				//Break out!
				break;
			}
		}
		
		return returnInventoryID;
	}
	
	public function pickupItem (p_itemID: Number): Number {
		//Get a Free Inventory Slot
		var emptyInventorySlot: Number = this.findFreeInventorySlot();
		
		//If we managed to find an Inventory Slot then assign the Item to it
		if (emptyInventorySlot > 0) {
			this.__inventoryItems[emptyInventorySlot].containsItemID = p_itemID;
			this.__gapegEngine.addFoundItem(p_itemID);
		}
		
		return emptyInventorySlot;
	}
	
	public function removeItemByItemID (p_ItemID: Number) {
		for (var i:Number = 1; i <= this.C_INVENTORYITEMSLOTS; i++) { 
			if (this.__inventoryItems[i].containsItemID == p_ItemID) {
				//If the current item is Selected then we need to de-select it and change the cursor back to the plain ol mouse
				if (this.__selectedInventoryID == this.__inventoryItems[i].inventoryID) {
					this.deSelectItem();
				}
				
				this.__inventoryItems[i].empty();

				break;
			}
		}
	}
	
	//The evoleItem function is the same as removing an item from an inventory slot and pickin up a new item into the same slot.
	//It's used mainly to interact and with items that have already been picked up.
	//For exmaple, one item may be selected, the user could do something to it that requires us to replace that item with another
	//similar but different item. Like the lid being taken off a pen. Both the Pen with Lid and Pen without lid need to be different 
	//Items but one or the other will be derived by the user either putting ON the lid or Taking OFF the lid. 
	public function evolveItem (p_oldItemID: Number, p_replaceWithItemID: Number): Number {
		var resultingInventoryID: Number
		
		for (var i:Number = 1; i <= this.C_INVENTORYITEMSLOTS; i++) { 
			if (this.__inventoryItems[i].containsItemID == p_oldItemID) {
				resultingInventoryID = i;
				//Break out!
				break;
			}
		}
		
		if (resultingInventoryID > 0) {
			//Remove the Old Item.
			this.removeItemByItemID(p_oldItemID);
			
			//Add the New Item
			this.__inventoryItems[resultingInventoryID].containsItemID = p_replaceWithItemID;
			this.__gapegEngine.addFoundItem(p_replaceWithItemID);
		}
		
		
		return resultingInventoryID;
	}
	
	public function selectItemByInventorySlot (p_InventoryID: Number) {
		if (inventorySlot (p_InventoryID).isNotEmpty) {
			//If the Item is already selected... Put it away.
			if (this.__selectedInventoryID == p_InventoryID) {
				//De-Select the Item
				this.deSelectItem();
				
			} else {
				//Select the Item
				this.__selectedInventoryID = p_InventoryID;
			
				this.unSelectAllInventorySlots();
				this.indicateSelectedSlot(p_InventoryID);
				this.__gapegEngine.mouseHandler.setCursor (this.__gapegEngine.mouseHandler.C_MC_INVENTORYITEM, inventorySlot (p_InventoryID).containsItemID);
			}
		}
	}
	
	public function deSelectItem () {
		this.__selectedInventoryID = 0;
		this.unSelectAllInventorySlots();
		this.__gapegEngine.mouseHandler.setCursor (this.__gapegEngine.mouseHandler.C_MC_STANDARDHAND);
	}
	
	//Remove the indication that any item is selected
	private function unSelectAllInventorySlots () {
		for (var i:Number = 1; i <= this.C_INVENTORYITEMSLOTS; i++) { 
			this.__inventoryItems[i].showAsNotSelected();
		}
	}
	
	//Indicate that a particular item is selected
	private function indicateSelectedSlot (p_InventoryID) {
		this.__inventoryItems[p_InventoryID].showAsSelected();
	}
}