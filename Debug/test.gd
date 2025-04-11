extends Node

# Path to the llama-cli executable (modify this if necessary)
var llama_cli_path = "C:/Program Files (x86)/llama/llama-run.exe"  # No quotes here
var model_path = "C:/Program Files (x86)/llama/llama-3.2.gguf"  # No quotes here

@onready var label: TextEdit = $TextEdit

# Function to call llama-cli and retrieve the output
func call_llama_cli(prompt: String) -> String:
	# Build the command line with the model and prompt
	var command : PackedStringArray = [llama_cli_path, model_path, prompt]
	
	# Prepare the output and error variables
	var output : Array = []
	var err : Array = []
	
	# Run the command and capture the output
	var result = OS.execute(command[0], command.slice(1), output, true, false)
	for element in output:
		print("PPPPPPPPP", element)
	# Check for errors
	if result != OK:
		return "Error running llama-cli: " + output[-1]
	
	# Join the output array into a single string for readability
	return output[0]

# Example of calling the function when a button is pressed
func _on_button_pressed():
	var prompt = label.text
	if label:
		label.text = "Loading..."
	var result = call_llama_cli(prompt)
	if label:
		label.text = result
	print("Llama-cli response: ", result)
