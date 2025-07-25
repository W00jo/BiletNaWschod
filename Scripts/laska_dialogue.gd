extends RichTextLabel

@onready var ticket_button = $"../../OptionBox/VBoxContainer/AskTicket"
@onready var document_button = $"../../OptionBox/VBoxContainer/AskDocument"

var personality = "polite"

var typing_speed := 0.02 # seconds per character
var is_typing := false
var displayed_bbcode := ""

var player_greeting = "Dzień dobry."

var dialogue = {
	
	"polite": {
		"greetings": ["Dzień dobry!"],
		"ticket_yes": ["Proszę bardzo."],
		"id_yes": ["Oczywiście."],
		"player_ask_ticket": ["Bilecik poproszę."],
		"player_ask_id": ["Proszę się wylegitymować."],
		"player_investigate": ["Hmm... Coś mi się tu nie zgadza..."],
		"student_defense": ["Wszystko podbite tak jak trzeba!"]
	}
}


func greet():
	displayed_bbcode = ""
	var npc_text = dialogue[personality]["greetings"].pick_random()
	var new_lines = [
		{"align": "right", "text": player_greeting},
		{"align": "left", "text": npc_text}
	]
	var blocks = build_bbcode_blocks(new_lines)
	await show_text_typewriter(blocks, displayed_bbcode)
	displayed_bbcode += build_bbcode_from_blocks(blocks)


func _on_ask_ticket_pressed() -> void:
	if is_typing:
		return
	ticket_button.disabled = true
	var ticket_yes_or_no = "ticket_yes"
	var npc_text = dialogue[personality][ticket_yes_or_no].pick_random()
	var player_text = dialogue[personality]["player_ask_ticket"].pick_random()
	var new_lines = [
		{"align": "right", "text": player_text},
		{"align": "left", "text": npc_text}
	]
	var blocks = build_bbcode_blocks(new_lines)
	await show_text_typewriter(blocks, displayed_bbcode)
	displayed_bbcode += build_bbcode_from_blocks(blocks)
	


func _on_ask_document_pressed() -> void:
	if is_typing:
		return
	document_button.disabled = true
	var id_yes_or_no = "id_yes"
	var npc_text = dialogue[personality][id_yes_or_no].pick_random()
	var player_text = dialogue[personality]["player_ask_id"].pick_random()
	var new_lines = [
		{"align": "right", "text": player_text},
		{"align": "left", "text": npc_text}
	]
	var blocks = build_bbcode_blocks(new_lines)
	await show_text_typewriter(blocks, displayed_bbcode)
	displayed_bbcode += build_bbcode_from_blocks(blocks)
	

func on_investigate(doc_type, is_valid):
	if is_typing:
		return
	var player_text = dialogue[personality]["player_investigate"].pick_random()
	var npc_text = dialogue[personality]["student_defense"].pick_random()
	
	var new_lines = [
		{"align": "right", "text": player_text},
		{"align": "left", "text": npc_text}
	]
	var blocks = build_bbcode_blocks(new_lines)
	await show_text_typewriter(blocks, displayed_bbcode)
	displayed_bbcode += build_bbcode_from_blocks(blocks)
	
	
func show_text_typewriter(bbcode_blocks: Array, prefix: String = "") -> void:
	is_typing = true
	text = prefix
	var result := prefix
	for block in bbcode_blocks:
		result += block["prefix"]
		for i in block["text"].length():
			text = result + block["text"].left(i + 1) + block["suffix"]
			await get_tree().create_timer(typing_speed).timeout
		result += block["text"] + block["suffix"]
	text = result # Ensure full text at the end
	is_typing = false
	
# Helper to build BBCode blocks for typewriter effect
func build_bbcode_blocks(dialogue_lines: Array) -> Array:
	var blocks := []
	for line in dialogue_lines:
		var prefix = "[%s]" % line.align
		var suffix = "[/%s]\n" % line.align
		
		# Add steel blue color for player (right-aligned) text
		if line.align == "right":
			prefix = "[%s][color=steelblue]" % line.align
			suffix = "[/color][/%s]\n" % line.align
		
		blocks.append({"prefix": prefix, "text": line.text, "suffix": suffix})
	return blocks

func build_bbcode_from_blocks(blocks: Array) -> String:
	var bbcode := ""
	for block in blocks:
		bbcode += block["prefix"] + block["text"] + block["suffix"]
	return bbcode
	
	
	
	
	
	
	
	
	
	
	
	
