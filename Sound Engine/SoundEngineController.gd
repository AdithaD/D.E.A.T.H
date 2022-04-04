extends Node

#music goes here:

var combat_music = load("res://Assets/Sounds/Music/DEATH.wav")
var menu_music = load("res://Assets/Sounds/Music/DEATHmainmenu.wav")
var cinematic_music = load("res://Assets/Sounds/Music/DEATHcinematic.wav")

#sfx goes here:
var death_sfx = load("")
var fire_weapon_rifle = load("")
var fire_weapon_machinegun = load("")
var fire_weapon_sniper = load("")
var medic_heal = load("")
var evacuate_sfx = load("")
var enemy_hurt_sfx = load("")
var explosion_sfx = load("res://Assets/Sounds/SFX/Weapon Sounds/explosion.wav")
var footsteps = load("res://Assets/Sounds/SFX/Player/running sfx.wav")
var civilian_screams = load ("res://Assets/Sounds/SFX/Civilians/civilianscreams.wav")
var button_sfx = load ("res://Assets/Sounds/SFX/UI/buttonpresssfx.wav")
var player_hurt_sfx = load ("res://Assets/Sounds/SFX/Player/playerhurt.wav")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func play_death_sfx():
	$SfxEnemy.stream = death_sfx
	$SfxEnemy.play()

func play_fire_weapon_rifle():
	$SfxEnemy.stream = fire_weapon_rifle
	$SfxEnemy.play()

func play_combat_music():
	$GameMusic.stream = combat_music
	$GameMusic.play()
	
func play_menu_music():
	$GameMusic.stream = menu_music
	$GameMusic.play()

func play_cinematic_music():
	$GameMusic.stream = cinematic_music
	$GameMusic.play()
	
func play_explosion_sfx():
	$SfxEnemyWeapon.stream = explosion_sfx
	$SfxEnemyWeapon.play()

func play_footsteps_sfx():
	$SfxPlayer.stream = footsteps
	$SfxPlayer.play()
	
func play_civilian_scream():
	$SfxCivilian.stream = civilian_screams
	$SfxCivilian.play()
	
func play_button_sound():
	$SfxUI.stream = button_sfx
	$SfxUI.play()
	
func play_playerhurt_sfx():
	$SfxPlayer.stream = player_hurt_sfx
	$SfxPlayer.play()
