## Sound played by `SoundPlayer` autoload.
## All the exported variables will be assigned to its `AudioStreamPlayer`.
extends Resource
class_name Sound

@export var stream : AudioStream
@export var volume_db : float
@export var bus := &"Master"
@export var max_polyphony := 1
@export var mix_target := AudioStreamPlayer.MIX_TARGET_CENTER
@export var pitch_scale := 1.0
