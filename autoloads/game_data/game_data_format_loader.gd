extends ResourceFormatLoader
class_name GameDataFormatLoader

func _get_recognized_extensions():
	return [GameDataManager.EXTENSION]

func _recognize_path(path, _type):
	return path.begins_with(GameDataManager.DIRNAME) and \
		path.ends_with(GameDataManager.EXTENSION)

func _load(path, _original_path, _use_sub_threads, _cache_mode):
	var file := FileAccess.open_encrypted_with_pass(
		path, 
		FileAccess.READ, 
		path)
	if file == null: return ERR_UNAUTHORIZED
	var text := file.get_as_text()
	var deserialized = str_to_var(text)
	if deserialized is GameData: return deserialized
	return ERR_FILE_CORRUPT
