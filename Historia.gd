extends Node
var chatgpt_request = HTTPRequest.new()

func _ready():
    chatgpt_request.connect("request_completed", self, "_on_request_completed")
    chatgpt_request.set_headers({"Authorization": "Bearer <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>"})
    chatgpt_request.set_url("https://api.openai.com/v1/engines/davinci-codex/completions")
    chatgpt_request.set_asynchronous(true)

func send_message(message: String):
    var data = {
        "prompt": message,
        "max_tokens": 60,
        "temperature": 0.5,
        "n": 1,
        "stop": "\n"
    }
    chatgpt_request.request(HTTPClient.METHOD_POST, JSON.print(data))

func _on_request_completed(result, response_code, headers, body):
    if response_code == 200:
        var json_response = JSON.parse(body)
        var response_text = json_response["choices"][0]["text"]
        # processar a resposta do ChatGPT, exibir para o usuário, etc.
    else:
        # tratar erros de solicitação, exibir uma mensagem de erro, etc.

export var perguntas : PoolStringArray
export var historia : String




