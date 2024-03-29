package;

import lime.app.Application;
import flixel.FlxG;
import openfl.geom.Rectangle;
import flixel.FlxSprite;
import lime.ui.FileDialog;
import openfl.display.PNGEncoderOptions;
import openfl.utils.ByteArray;
import openfl.display.BitmapData;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.text.FlxText;
import flixel.FlxState;
import flixel.util.FlxColor;
import openfl.events.Event;
import openfl.events.IOErrorEvent;
import openfl.net.FileReference;
import sys.io.File;
import sys.FileSystem;

class PlayState extends FlxState
{
	var frames:FlxAtlasFrames;
	var daRealBitmapData:BitmapData;
	var iHateThis:FlxSprite;
	var whatFramesEvenExist:Int;
	var currentFrame:Int = 0;
	var rectHeight:Float = 0;
	var rectWidth:Float = 0;
	var rectY:Float = 0;
	var rectX:Float = 0;
	var curFrameText:FlxText;
	var doneExportingFrames:Bool = false;
	var exportText:FlxText;

	var kadunkyDunk:FlxSprite;

	override public function create()
	{
		super.create();
		exportText = new FlxText('Press "E" to export the next frame!', 32);
		exportText.screenCenter();
		add(exportText);
		frames = Paths.getSparrowAtlas('sheet');
		kadunkyDunk.frames = frames;
		for(dinkyDoo in Paths.txt('anims').split('\n'))
		{
			kadunkyDunk.animation.addByPrefix(dinkyDoo.split('--')[0], dinkyDoo.split('--')[1], Std.parseInt(dinkyDoo.split('--')[2]), false);
		}
		//for(klickey in kadunkyDunk.frames)
	//	{
	//	}
		iHateThis = new FlxSprite().loadGraphic(Paths.image('sheet'));
		daRealBitmapData = iHateThis.graphic.bitmap;
		whatFramesEvenExist = frames.frames.length;
		curFrameText = new FlxText('0 / ' + Std.string(whatFramesEvenExist), 27);
		curFrameText.screenCenter();
		curFrameText.y += -35;
		add(curFrameText);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		if(FlxG.keys.justPressed.E && !doneExportingFrames)
		{
			rectHeight = frames.frames[currentFrame].frame.height;
			rectWidth = frames.frames[currentFrame].frame.width;
			rectY = frames.frames[currentFrame].frame.y;
			rectX = frames.frames[currentFrame].frame.x;
			var fuckingHell:Rectangle = new Rectangle(rectX, rectY, rectWidth, rectHeight);
			saveImage(daRealBitmapData, fuckingHell);
			currentFrame += 1;
			curFrameText.text = Std.string(currentFrame) + ' / ' + Std.string(whatFramesEvenExist);
			if(currentFrame == whatFramesEvenExist)
			{
				doneExportingFrames = true;
				exportText.text = 'Done exporting frames!';
				curFrameText.visible = false;
			}
		}
	}

	public static function saveImage(bitmapData:BitmapData, frameRect:Rectangle)
	{
		//didnt write this part just usin it cuz ye
		//shoutouts to miltoncandelero on github for writing shit im too stupid to write myself!
		var b:ByteArray = new ByteArray();
		b = bitmapData.encode(frameRect, new PNGEncoderOptions(false), b);
		new FileDialog().save(b, 'png', Sys.getCwd() + "/assets/exportedframes/", 'frame.png');
	}
}
