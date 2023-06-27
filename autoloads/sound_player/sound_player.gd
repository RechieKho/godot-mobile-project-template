## For playing audio.
## Audio and its data are set up in form of `Sound` resource.
## Any updates to the audio during runtime should change the property of
## `AudioStreamPlayer` accessed from `get_stream_player` method, as
## the data in `Sound` resources are all default values (used during initiation only).
extends Node


var musics := {}

## Play sound.
func play_sound(sound: Sound):
	var player = get_stream_player(sound)
	if player == null: return
	player.play()

func stop_sound(sound: Sound):
	var player = get_stream_player(sound)
	if player == null: return
	player.stop()

## Play music.
## If the music played by given type is the same as requested, do nothing.
## Else, switch the music.
## Best for background music that persist across scenes.
func play_music(type: String, music: Sound):
	if musics.get(type) == music: return
	if musics.get(type) is Sound: 
		stop_sound(musics.get(type))
	play_sound(music)
	musics[type] = music

## Get low-level `AudioStreamPlayer` for fine control over its property.
func get_stream_player(sound: Sound) -> AudioStreamPlayer: 
	if sound == null: return null
	var player_name := "{0}_player".format([hash(sound)])
	var player := get_node_or_null(player_name) as AudioStreamPlayer
	if player == null:
		player = AudioStreamPlayer.new()
		player.name = player_name
		add_child(player)
		player.stream = sound.stream
		player.volume_db = sound.volume_db
		player.bus = sound.bus
		player.max_polyphony = sound.max_polyphony
		player.mix_target = sound.mix_target
		player.pitch_scale = sound.pitch_scale
	return player
