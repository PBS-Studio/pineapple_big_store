@tool
extends DialogicLayoutLayer

## A layer that contains
## - a dialog_text node
## - a name_label node
## - a next_indicator node
## - a type_sound node
##
## as well as custom
## - animations
## - auto-advance progress indicator


enum Alignments {LEFT, CENTER, RIGHT}

enum AnimationsIn {NONE, POP_IN, FADE_UP}
enum AnimationsOut {NONE, POP_OUT, FADE_DOWN}
enum AnimationsNewText {NONE, WIGGLE}

@export_group("Text")
@export_subgroup("Alignment & Size")
@export var text_alignment: Alignments= Alignments.LEFT
@export var text_use_global_size: bool = true
@export var text_size: int = 15

@export_subgroup("Color")
@export var text_use_global_color: bool = true
@export var text_custom_color: Color = Color.WHITE

@export_subgroup('Font')
@export var text_use_global_font: bool = true
@export_file('*.ttf') var normal_font:String = ""
@export_file('*.ttf') var bold_font:String = ""
@export_file('*.ttf') var italic_font:String = ""
@export_file('*.ttf') var bold_italic_font:String = ""

@export_group("Box")
@export_subgroup("Panel")
@export_file("*.tres") var box_panel: String = this_folder.path_join("vn_textbox_default_panel.tres")
@export_subgroup("Color")
@export var box_color_use_global: bool = true
@export var box_color_custom: Color = Color.BLACK
@export_subgroup("Size & Position")
@export var box_size: Vector2 = Vector2(550, 110)
@export var box_margin_bottom: int = 15
@export_subgroup("Animation")
@export var box_animation_in: AnimationsIn = AnimationsIn.FADE_UP
@export var box_animation_out: AnimationsOut = AnimationsOut.FADE_DOWN
@export var box_animation_new_text: AnimationsNewText = AnimationsNewText.NONE

@export_group("Indicators")
@export_subgroup("Next Indicator")
@export var next_indicator_enabled: bool = true
@export var next_indicator_show_on_questions: bool = true
@export var next_indicator_show_on_autoadvance: bool = false
@export_enum('bounce', 'blink', 'none') var next_indicator_animation: int = 0
@export_file("*.png","*.svg","*.tres") var next_indicator_texture: String = ''
@export var next_indicator_size: Vector2 = Vector2(25,25)

@export_subgroup("Autoadvance")
@export var autoadvance_progressbar: bool = true

@export_group('Sounds')
@export_subgroup('Typing Sounds')
@export var typing_sounds_enabled: bool = true
@export var typing_sounds_mode: DialogicNode_TypeSounds.Modes = DialogicNode_TypeSounds.Modes.INTERRUPT
@export_dir var typing_sounds_sounds_folder: String = "res://addons/dialogic/Example Assets/sound-effects/"
@export_file("*.wav", "*.ogg", "*.mp3") var typing_sounds_end_sound: String = ""
@export_range(1, 999, 1) var typing_sounds_every_nths_character: int = 1
@export_range(0.01, 4, 0.01) var typing_sounds_pitch: float = 1.0
@export_range(0.0, 3.0) var typing_sounds_pitch_variance: float = 0.0
@export_range(-80, 24, 0.01) var typing_sounds_volume: float = -10
@export_range(0.0, 10) var typing_sounds_volume_variance: float = 0.0
@export var typing_sounds_ignore_characters: String = " .,!?"


func _apply_export_overrides() -> void:
	if !is_inside_tree():
		await ready

	## FONT SETTINGS
	var dialog_text: DialogicNode_DialogText = %DialogicNode_DialogText
	dialog_text.alignment = text_alignment as DialogicNode_DialogText.Alignment

	if text_use_global_size:
		text_size = get_global_setting(&'font_size', text_size)
	dialog_text.add_theme_font_size_override(&"normal_font_size", text_size)
	dialog_text.add_theme_font_size_override(&"bold_font_size", text_size)
	dialog_text.add_theme_font_size_override(&"italics_font_size", text_size)
	dialog_text.add_theme_font_size_override(&"bold_italics_font_size", text_size)

	if text_use_global_color:
		dialog_text.add_theme_color_override(&"default_color", get_global_setting(&'font_color', text_custom_color) as Color)
	else:
		dialog_text.add_theme_color_override(&"default_color", text_custom_color)

	if text_use_global_font and get_global_setting(&'font', false):
		dialog_text.add_theme_font_override(&"normal_font", load(get_global_setting(&'font', '') as String) as Font)
	elif !normal_font.is_empty():
		dialog_text.add_theme_font_override(&"normal_font", load(normal_font) as Font)
	if !bold_font.is_empty():
		dialog_text.add_theme_font_override(&"bold_font", load(bold_font) as Font)
	if !italic_font.is_empty():
		dialog_text.add_theme_font_override(&"italitc_font", load(italic_font) as Font)
	if !bold_italic_font.is_empty():
		dialog_text.add_theme_font_override(&"bold_italics_font", load(bold_italic_font) as Font)

	## BOX SETTINGS
	var dialog_text_panel: PanelContainer = %DialogTextPanel
	if ResourceLoader.exists(box_panel):
		dialog_text_panel.add_theme_stylebox_override(&'panel', load(box_panel) as StyleBox)

	if box_color_use_global:
		dialog_text_panel.self_modulate = get_global_setting(&'bg_color', box_color_custom)
	else:
		dialog_text_panel.self_modulate = box_color_custom

	var sizer: Control = %Sizer
	sizer.size = box_size
	sizer.position = box_size * Vector2(-0.5, -1)+Vector2(0, -box_margin_bottom)

	## BOX ANIMATIONS
	var animations: AnimationPlayer = %Animations
	animations.set(&'animation_in', box_animation_in)
	animations.set(&'animation_out', box_animation_out)
	animations.set(&'animation_new_text', box_animation_new_text)

	## NEXT INDICATOR SETTINGS
	var next_indicator: DNextIndicator = %NextIndicator
	next_indicator.enabled = next_indicator_enabled

	if next_indicator_enabled:
		next_indicator.animation = next_indicator_animation
		if FileAccess.file_exists(next_indicator_texture):
			next_indicator.texture = load(next_indicator_texture)
		next_indicator.show_on_questions = next_indicator_show_on_questions
		next_indicator.show_on_autoadvance = next_indicator_show_on_autoadvance
		next_indicator.texture_size = next_indicator_size

	#### SOUNDS

	## TYPING SOUNDS
	var type_sounds: DialogicNode_TypeSounds = %DialogicNode_TypeSounds
	type_sounds.enabled = typing_sounds_enabled
	type_sounds.mode = typing_sounds_mode
	if not typing_sounds_sounds_folder.is_empty():
		type_sounds.sounds = DialogicNode_TypeSounds.load_sounds_from_path(typing_sounds_sounds_folder)
	else:
		type_sounds.sounds.clear()
	if not typing_sounds_end_sound.is_empty():
		type_sounds.end_sound = load(typing_sounds_end_sound)
	else:
		type_sounds.end_sound = null

	type_sounds.play_every_character = typing_sounds_every_nths_character
	type_sounds.base_pitch = typing_sounds_pitch
	type_sounds.base_volume = typing_sounds_volume
	type_sounds.pitch_variance = typing_sounds_pitch_variance
	type_sounds.volume_variance = typing_sounds_volume_variance
	type_sounds.ignore_characters = typing_sounds_ignore_characters

