# Music Player Plus

Unified Music Player mod for Victoria 3 to allow for maximum compatibilty between music mods.

### Adding more music mods

There are 2 ways to get a new mod added to this for compatibility.

1. Do it yourself and make a pull request, there is a guide on how to do this below (preferred)

2. Create a new issue that has a link to the mod you want to be added and it will be added eventually, although it may take much longer than just making a PR.

### Guide to adding a new mod

Adding a new mod isn't too difficult but there are a few steps that you'll have to go through.

1. Make sure that all the tracks from the mod you want to add are localized (you can run `make_music_tracks.py` to do this automatically). If they are not localize they will show up in the music player as unlocalized text, here is an example:
```
track997 = {
	name = "track997_name"
	music = "file:/music/dementive_egypt_music/ancient_hymn.mp3"
	pause_factor = 50
	mood = yes
	can_be_interrupted = yes
}

In the yml localization file

track997_name:0 "Track Name"
```

2. Make a new Music Player Category in `music/music_player_categories` (Note that the alphebetical order categories appear in this folder will be the order they are show in the game). You can do this manually or by running `make_music_categories.py`. You will also have to localize the category name.

3. Make a unique GFX image for the new music category. There is a specific process I used to make the images and you should also follow it, it should go something like this:

	1. Find a suitable picture in the base game gfx folder to use for the category. You will have to crop out a 800x450 part of this to use for your image.
	2. Once you have a good cropped image to use, open `music_frame.dds` and copy it on top of your image so it overlays it.
	3. Finally you'll need to put text on the image saying what the category is. To match the existing style you'll need to use the `ParadoxVictorian` font that can be found in the vanilla game files. Then simply draw a text box between the edges of the frame in the center of the image and write your category name with font size 89, kind of like this:
	![GFX guide screenshot](/assets/gfx_guide.png)

4. The last thing you will need to do after making gfx is add the new category into the `gui/jomini/music_player/music_player_view.dds`. Go to line 336 of this file and add a new `music_category_button` into the widget found there. It should look something like this:
```
music_category_button = {
	shaderfile = "gfx/FX/GUI_button_saturate.shader"
	effectname = "SoftSaturate"
	visible = "[ObjectsEqual('Full Soundtracks', MusicPlayer.GetCategoryName( MusicPlayerCategory.Self ))]"

	blockoverride "button_texture" {
		texture = "gfx/music_player/full_soundtracks.dds"
	}
}
```

With all that done the tracks from the new mod should be in the music player with a new category. No actual music files need to be added as they come from the other mod.