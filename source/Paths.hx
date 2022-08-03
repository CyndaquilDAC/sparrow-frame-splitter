package;

import flixel.FlxG;
import flixel.graphics.frames.FlxAtlasFrames;
import openfl.utils.AssetType;
import openfl.utils.Assets as OpenFlAssets;

class Paths
{
	static function getPath(file:String, type:AssetType)
	{
        return 'assets/$file';
	}

	inline static public function file(file:String, type:AssetType = TEXT)
	{
		return getPath(file, type);
	}

	inline static public function txt(key:String)
	{
		return getPath('$key.txt', TEXT);
	}

	inline static public function image(key:String)
	{
		return getPath('images/$key.png', IMAGE);
	}

	inline static public function getSparrowAtlas(key:String)
	{
		return FlxAtlasFrames.fromSparrow(image(key), file('images/$key.xml'));
	}
}