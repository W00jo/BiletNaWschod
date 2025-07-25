extends Control

@onready var page_sound = AudioStreamPlayer.new()

func _ready() -> void:
	# Add and configure the audio player
	add_child(page_sound)
	page_sound.stream = load("res://Assets/SFX/page.wav")
	page_sound.volume_db = -10  # Adjust volume as needed
	
	if get_parent() == get_tree().root.get_node('Game/ToolkitLayer/Toolkit'):
		$CreditsPages.visible = false
		hide_all_journal_pages()
		$JournalPages/Cover.visible = true
	elif get_parent() == get_tree().root.get_node('Game/StartMenu'):
		$JournalPages.visible = false
		hide_all_credits_pages()
		$CreditsPages/Cover.visible = true


func hide_all_journal_pages():
	for page in $JournalPages.get_children():
		page.visible = false

func hide_all_credits_pages():
	for page in $CreditsPages.get_children():
		page.visible = false

##############################################

func _on_button_cover_pressed() -> void:
	hide_all_journal_pages()
	$JournalPages/Pages_1_2.visible = true
	page_sound.play()

func _on_button_page_1_pressed() -> void:
	hide_all_journal_pages()
	$JournalPages/Cover.visible = true
	page_sound.play()

func _on_button_page_2_pressed() -> void:
	hide_all_journal_pages()
	$JournalPages/Pages_3_4.visible = true
	page_sound.play()

func _on_button_page_3_pressed() -> void:
	hide_all_journal_pages()
	$JournalPages/Pages_1_2.visible = true
	page_sound.play()

###############################################

func _on_credits_cover_pressed() -> void:
	hide_all_credits_pages()
	$CreditsPages/Pages_1_2.visible = true
	page_sound.play()

func _on_credits_page_1_pressed() -> void:
	hide_all_credits_pages()
	$CreditsPages/Cover.visible = true
	page_sound.play()

func _on_credits_page_2_pressed() -> void:
	hide_all_credits_pages()
	$CreditsPages/Pages_3_4.visible = true
	page_sound.play()

func _on_credits_page_3_pressed() -> void:
	hide_all_credits_pages()
	$CreditsPages/Pages_1_2.visible = true
	page_sound.play()

###############################################

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("Magnify"):
		queue_free()
