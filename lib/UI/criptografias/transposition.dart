import 'package:flutter/material.dart';
import '../basic_crypto.dart';

class Transposition extends Criptografia {
  final String explicacao =
      """Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras commodo massa ut ex porta euismod. Etiam venenatis cursus lorem ut eleifend. Fusce nec tempus erat. Integer eget dolor mauris. Donec sed varius ligula, eu scelerisque enim. Etiam ut lacus sed felis cursus dictum. Suspendisse ut tempor elit. Integer tincidunt turpis eget neque lacinia bibendum. Praesent eget nunc at neque lacinia lobortis. Donec eleifend mattis quam, quis tempor nisi finibus nec. Fusce maximus efficitur ligula sit amet dignissim. Ut ultrices accumsan vehicula.
  
Vestibulum metus augue, cursus ac ligula sed, gravida bibendum eros. Vestibulum at pharetra nisl, ut bibendum leo. Nulla vel consectetur dolor. Proin mattis velit eu viverra venenatis. Quisque porttitor, metus at cursus mollis, sem nisl cursus nunc, non hendrerit ligula ipsum eget elit. Donec vel consequat diam. In facilisis auctor lacus, sed dictum nulla dapibus vel. Vestibulum condimentum sapien non ante egestas aliquet. Duis arcu dolor, hendrerit sit amet lacus quis, dignissim tincidunt odio. Suspendisse facilisis lectus vitae justo euismod, in vulputate dui aliquam. Ut cursus euismod metus, non faucibus nibh convallis quis. Praesent gravida nulla non vehicula posuere. In facilisis orci ac arcu finibus, in rutrum dui dictum. In non elit augue. Nam id ullamcorper justo.""";
  final String nome = "Transposition";
  final Nivel nivel = Nivel.BASICO;

  @override
  String encrypt(String plaintext, {String key}) {
    return "ENCRYPT Plain = " + plaintext + " Key = " + key;
  }

  @override
  String decrypt(String cyphertext, {String key}) {
    return "DECRYPT Plain = " + cyphertext+ " Key = " + key;
  }

  @override
  State<StatefulWidget> createState() => _TranspositionState(explicacao, nome);
}

class _TranspositionState extends State<Transposition> {
  final TextEditingController _input = new TextEditingController();
  final TextEditingController _key = new TextEditingController();
  String _output = "Resultado";
  final String explicacao;
  final String nome;
  final Transposition transposition = new Transposition();

  _TranspositionState(this.explicacao, this.nome);

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

          // Key
          new Container(
            margin: new EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
            child: new TextFormField(
              autocorrect: false,
              controller: _key,
              keyboardType: TextInputType.number,
              maxLines: 1,
              decoration: new InputDecoration(
                labelText: "Chave",
              ),
              validator: (input) {
                if (input.isEmpty) return "Chave não pode ser vazia";
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
                      _output =
                          transposition.encrypt(_input.text, key: _key.text);
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
                      _output =
                          transposition.decrypt(_input.text, key: _key.text);
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
          )
        ],
      ),
    );
  }
}
