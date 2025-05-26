/**
    Gapeg Sound Handler
    author: Peter Eldred
    version: 0.1
    created: 2008-03-25
    copyright: Peter Eldred

    This code holds runs the Sounds used in the Gapeg Engine
*/
class gapegSoundHandler {
	var __gapegEngine: gapegEngine;
	var __soundFXMC: MovieClip;
	
	var __soundFXClips: Array;
	
	//Constructor
	public function gapegSoundHandler (p_gapegEngine: gapegEngine) {
		this.__gapegEngine = p_gapegEngine;
		
		this.__soundFXMC = this.__gapegEngine.parentMC.createEmptyMovieClip("soundFXMC", this.__gapegEngine.parentMC.getNextHighestDepth());
		
		this.__soundFXClips = new Array();
		
		this.initSoundFXClips();
	}
	
	public function createSound (soundID: Number, soundLinkageID: String): Sound {
		this.__soundFXClips[soundID] = new Sound(this.__soundFXMC);
		this.__soundFXClips[soundID].attachSound(soundLinkageID);
		
		return this.__soundFXClips[soundID];
	}
	
	public function initSoundFXClips() {
		this.createSound (gapegConst.C_SOUND_ACHIEVEMENT, "Sound_Acheivement");
		this.createSound (gapegConst.C_SOUND_CLICK_ON, "Sound_ClickOn");
		this.createSound (gapegConst.C_SOUND_CLICK_OFF, "Sound_ClickOff");
		this.createSound (gapegConst.C_SOUND_LOCKED, "Sound_Locked");
		this.createSound (gapegConst.C_SOUND_PCBEEP, "Sound_PCBeep");
		this.createSound (gapegConst.C_SOUND_CHESSGAME, "Sound_ChessGame");
		this.createSound (gapegConst.C_SOUND_PLUGIN, "Sound_PlugIn");
		this.createSound (gapegConst.C_SOUND_NUDGEGRATE, "Sound_NudgeGrate");
		this.createSound (gapegConst.C_SOUND_RELEASEGRATE, "Sound_ReleaseGrate");
		this.createSound (gapegConst.C_SOUND_BLINDSSLIDE, "Sound_BlindsSlide");
	}
	
	public function playSound(soundID: Number) {
		this.__soundFXClips[soundID].start();
	}
}
