extends Control
class_name text_box

@export var text_edit_box: TextEdit

@export var index_label: Label
@export var index: int = -1

@export var last_box: text_box
const max_depth: int = 5

const starting_promt: String = "This is a bot that writes storys in parts seperated by \"Box #\". Each part tells a part of the story. You will write the last part. Stroy olny. Don't write box # or anything else. just your part of the story. If there is no story, make up a the intro. anything you generate will be kindergarden level and olny 30 words long. This bot is to generate grammer problems in the story content it creates for people with dyslexia to try to fix"

func _ready():
	set_index(index)

# TODO: make this part of project itself/not external file
#var llama_cli_path = "C:/Program Files (x86)/llama/llama-run.exe" # cpu heavy (slow)
var llama_cli_path = "C:/Program Files (x86)/llama_vulkan/llama-run.exe"
var model_path = "C:/Program Files (x86)/llama/llama-3.2.gguf"
var ngl = "--ngl"
const amount_of_layers: int = 200

# Function to call llama-cli and retrieve the output
func call_llama_cli(prompt: String) -> String:
	print(prompt)
	var command: PackedStringArray = [llama_cli_path, model_path, prompt, ngl, amount_of_layers]
	var output: Array = []
	#print(command)
	OS.execute(command[0], command.slice(1), output, true, false)
	return output[0]

func _on_button_pressed():
	if text_edit_box:
		var result: String = "Error"
		
		text_edit_box.text = "Loading..."
		result = call_llama_cli(generate_promt())
		#print(result.left(-5))
		result = result.left(-5).substr(23)
		text_edit_box.text = result
		print("Llama-cli response: ", result)

func set_index(new_index: int):
	index = new_index
	if index_label:
		index_label.text = str(index)

func _on_text_edit_text_changed() -> void:
	pass

func generate_promt(depth: int = 0):
	var current_promt = ""
	if last_box and depth < max_depth:
		current_promt = last_box.generate_promt(depth + 1) + last_box.get_text()
	else:
		current_promt = starting_promt
	#print(depth, current_promt)
	return current_promt

func get_text() -> String:
	if text_edit_box:
		return text_edit_box.text
	return ""
	
