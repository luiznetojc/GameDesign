extends Control
var end = false

var respostas = []
var selecionada = {}
onready var texto = $VBoxContainer/Texto
onready var inputJogador = $VBoxContainer/HBoxContainer/inputJogador
onready var label = $VBoxContainer/HBoxContainer/Label
func _ready():
	seleciona_historia()
	inputJogador.grab_focus()
	verifica_fim_respostas()
	
func seleciona_historia():
	randomize()
	var qtd = $Historias.get_child_count()
	
	var indice = randi() % qtd
	var sorteada = $Historias.get_child(indice)
	selecionada.perguntas = sorteada.perguntas
	selecionada.historia = sorteada.historia
	
func verifica_fim_respostas():
	if respostas.size() >= selecionada.perguntas.size():
		contar_historia()
	else:
		proxima_pergunta()
		
func contar_historia():
	texto.text = selecionada.historia % respostas
	inputJogador.queue_free()
	label.text = "Jogue novamente!!"
	end = true
	
func proxima_pergunta():
	texto.text = "Por favor, me diga " + selecionada.perguntas[respostas.size()]
	inputJogador.grab_focus()
	
func _on_inputJogador_text_entered(new_text):
	salvar_resposta(new_text)

func _on_Button_pressed():
	if end:
		get_tree().reload_current_scene()
	else:
		salvar_resposta(inputJogador.text)
func salvar_resposta(texto):
	respostas.append(texto)
	inputJogador.clear()
	verifica_fim_respostas()

