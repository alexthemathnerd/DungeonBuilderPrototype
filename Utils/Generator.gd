class_name Generator
extends RefCounted
static var id_counter: int = 0
static func generate_id() -> String:
	id_counter += 1
	return Time.get_date_string_from_unix_time(0) + "-" + str(id_counter)
