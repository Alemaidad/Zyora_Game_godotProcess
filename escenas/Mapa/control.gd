class_name Controlset
extends Control
@onready var rich_text_label: RichTextLabel = $PanelContainer/Panel/RichTextLabel

# Lista de frases posibles
var frases := [
	"!Ehhh tuuu, si tu.",
	"Esto se pondrá interesante...",
	"¿Quien Eres?",
	"¿Ah donde te diriges?",
	"No deberías estar por aquí",
	"..."
]

func _ready():
	randomize()  
	mostrar_frase_aleatoria()

func mostrar_frase_aleatoria():
	var frase = frases[randi_range(0, frases.size() - 1)]
	rich_text_label.text = frase
