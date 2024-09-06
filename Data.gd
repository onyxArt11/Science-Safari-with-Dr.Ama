extends Node

var json_path = "res://Models/Science_girl/Gameplay.json"
var qjson_path = "res://Models/Science_girl/Questions_Gameplay.json"
var questions
var assesment
# Called when the node enters the scene tree for the first time.
func _ready():
	questions = read_json(json_path)
	assesment = read_json(qjson_path)


# Called every frame. 'delta' is the elapsed time since the previous frame.


func read_json(file_path):
	var file = FileAccess.open(file_path, FileAccess.READ)
	var json_as_text = file.get_as_text()
	file.close()
	var json = JSON.new()
	var questionss = json.parse(json_as_text)
	questionss = json.get_data()
	return questionss

func current_dialouge(gameplay:String):
	var data
	for i in questions:
		if i["Gameplay"] == gameplay:
			data = i
	return [data["Intro"],data["Task"]]
	
func current_assesment(gameplay:String):
	var data
	for i in assesment:
		if i["Gameplay"] == gameplay:
			data = i
	return data
