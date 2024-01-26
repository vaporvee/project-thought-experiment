## This is a GDscript Node wich gets automatically added as Autoload while installing the addon.
## 
## It can run in the background to comunicate with Discord.
## You don't need to use it. If you remove it make sure to run [code]DiscordSDK.run_callbacks()[/code] in a [code]_process[/code] function.
##
## @tutorial: https://github.com/vaporvee/discord-sdk-godot/wiki
extends Node

func _ready() -> void:
	DiscordSDK.app_id = 1200457562877857912
	DiscordSDK.details = "A one week project by vaporvee"
	DiscordSDK.state = "Having fun solving gravity puzzles"
	
	DiscordSDK.large_image = "icon"
	DiscordSDK.large_image_text = "Now on itch.io"
	
	DiscordSDK.refresh()

func  _process(_delta) -> void:
	DiscordSDK.run_callbacks()
