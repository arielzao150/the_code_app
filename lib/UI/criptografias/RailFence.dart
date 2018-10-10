import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../basic_crypto.dart';

class RailFence extends Criptografia {
  final String explicacao = """Na cifra RailFence o plaintext é escrito para baixo e na diagonal em sucessivas "linhas", e então para cima assim que chegar na última linha. Chegando novamente na primeira linha, a mensagem volta a ser escrita para baixo, e assim por diante até que toda a mensagem seja escrita, e então a mensagem é lida normalmente. Por exemplo a frase: 'UMA FRASE DE EXEMPLO' ficaria:

U . . . F . . . E . . .   . . . M . . .
. M .   . R . S .   . E . E . E . P . O
. . A . . . A . . . D . . . X . . . L .

O ciphertext seria:

UFE MM RS EEEPOAADXL""";
  final String nome = "RailFence";
  final Nivel nivel = Nivel.MEDIO;

  @override
  State<StatefulWidget> createState() => _RailFenceState(explicacao, nome);

  @override
  String decrypt(String cyphertext, {String key}) {
    List caracteres = new List(cyphertext.length);
    int linha = 0;
    int count = 0;
    String plaintext = "";
    for (int i = 0; i < cyphertext.length; i++) {
      if (linha == 0) {
        if (count * 4 >= cyphertext.length) {
          linha++;
          count = 0;
        } else {
          caracteres[count * 4] = cyphertext[i];
          count++;
        }
      }
      if (linha == 1) {
        if (count * 2 >= cyphertext.length) {
          linha++;
          count = 0;
        } else {
          caracteres[(count * 2) + linha] = cyphertext[i];
          count++;
        }
      }
      if (linha == 2) {
        if ((count * 4) + 2 >= cyphertext.length) {
          break;
        } else {
          caracteres[(count * 4) + 2] = cyphertext[i];
          count++;
        }
      }
    }
    for (int i = 0; i < caracteres.length; i++) {
      plaintext += caracteres[i];
    }
    return plaintext;
  }

  @override
  String encrypt(String plaintext, {String key}) {
    List caracteres = new List();
    String cyphertext = "";
    for (int i = 0; i < plaintext.length; i++) {
      caracteres.add(plaintext[i]);
    }
    for (int i = 0; i < 3; i++) {
      for (int j = i; j < caracteres.length; j += i % 2 != 1 ? 4 : 2) {
        cyphertext += caracteres[j];
      }
    }
    return cyphertext;
  }
}

class _RailFenceState extends State<RailFence> {
  final TextEditingController _input = new TextEditingController();
  String _output = "Resultado";
  final String explicacao;
  final String nome;
  final RailFence CRIPTO = new RailFence();

  _RailFenceState(this.explicacao, this.nome);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(nome),
      ),
      body: new ListView(
        children: <Widget>[
          // Explicação
          new Container(
            child: new RichText(
              text: new TextSpan(
                text: explicacao,
                style: new TextStyle(color: Colors.black),
              ),
              textDirection: TextDirection.ltr,
              overflow: TextOverflow.clip,
            ),
            margin: new EdgeInsets.all(16.0),
          ),

          // Input
          new Container(
            margin: new EdgeInsets.all(16.0),
            child: new TextFormField(
              autocorrect: false,
              controller: _input,
              maxLines: 1,
              decoration: new InputDecoration(
                labelText: "Input",
              ),
              validator: (input) {
                if (input.isEmpty) return "Input não pode ser vazio";
              },
              autovalidate: true,
            ),
          ),

          // Botões
          new Row(
            children: <Widget>[
              new Container(
                margin: EdgeInsets.only(left: 16.0),
                child: new FlatButton(
                  color: Colors.grey.shade300,
                  onPressed: () {
                    setState(() {
                      _output = CRIPTO.encrypt(_input.text);
                    });
                  },
                  child: new Center(child: new Text("Encrypt")),
                ),
              ),
              new Container(
                margin: EdgeInsets.only(left: 16.0),
                child: new FlatButton(
                  color: Colors.grey.shade300,
                  onPressed: () {
                    setState(() {
                      _output = CRIPTO.decrypt(_input.text);
                    });
                  },
                  child: new Center(child: new Text("Decrypt")),
                ),
              ),
            ],
          ),

          // Output
          new Container(
            margin: new EdgeInsets.only(
                left: 16.0, right: 16.0, top: 16.0, bottom: 32.0),
            child: new Text(
              _output,
              style: new TextStyle(
                fontSize: 20.0,
              ),
            ),
          ),
          new Container(
            margin: new EdgeInsets.only(
                left: 16.0, right: 16.0, top: 16.0, bottom: 32.0),
            child: new BotaoCopiar(_output),
          ),
        ],
      ),
    );
  }
}

class BotaoCopiar extends StatelessWidget {
  final String texto;

  BotaoCopiar(this.texto);

  @override
  Widget build(BuildContext context) {
    return new FlatButton(
      child: new Text("Copiar resultado"),
      onPressed: () {
        Clipboard.setData(new ClipboardData(text: texto));
        Scaffold.of(context)
            .showSnackBar(new SnackBar(content: new Text("Resultado copiado")));
      },
      color: Colors.grey.shade300,
    );
  }
}
