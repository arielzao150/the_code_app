import 'package:flutter/material.dart';
import '../basic_crypto.dart';

class Transposition extends Criptografia {
  final String explicacao = """Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras commodo massa ut ex porta euismod. Etiam venenatis cursus lorem ut eleifend. Fusce nec tempus erat. Integer eget dolor mauris. Donec sed varius ligula, eu scelerisque enim. Etiam ut lacus sed felis cursus dictum. Suspendisse ut tempor elit. Integer tincidunt turpis eget neque lacinia bibendum. Praesent eget nunc at neque lacinia lobortis. Donec eleifend mattis quam, quis tempor nisi finibus nec. Fusce maximus efficitur ligula sit amet dignissim. Ut ultrices accumsan vehicula."
  
  Vestibulum metus augue, cursus ac ligula sed, gravida bibendum eros. Vestibulum at pharetra nisl, ut bibendum leo. Nulla vel consectetur dolor. Proin mattis velit eu viverra venenatis. Quisque porttitor, metus at cursus mollis, sem nisl cursus nunc, non hendrerit ligula ipsum eget elit. Donec vel consequat diam. In facilisis auctor lacus, sed dictum nulla dapibus vel. Vestibulum condimentum sapien non ante egestas aliquet. Duis arcu dolor, hendrerit sit amet lacus quis, dignissim tincidunt odio. Suspendisse facilisis lectus vitae justo euismod, in vulputate dui aliquam. Ut cursus euismod metus, non faucibus nibh convallis quis. Praesent gravida nulla non vehicula posuere. In facilisis orci ac arcu finibus, in rutrum dui dictum. In non elit augue. Nam id ullamcorper justo.""";
  final String nome = "Transposition";
  @override
  String encrypt(String plaintext, {String key}) {
    return "";
  }

  @override
  String decrypt(String cyphertext, {String key}) {
    return "";
  }

  @override
  State<StatefulWidget> createState() => _TranspositionState(explicacao, nome);
}
class _TranspositionState extends State<Transposition>{
  final TextEditingController _input = new TextEditingController();
  final TextEditingController _key = new TextEditingController();
  final TextEditingController _output = new TextEditingController();
  final String explicacao;
  final String nome;

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
              child: new TextField(
                autocorrect: false,
                controller: _input,
                maxLines: 1,
                decoration: new InputDecoration(
                  labelText: "Input",
                ),
              ),
            ),

            // Key
            new Container(
              margin: new EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
              child: new TextField(
                autocorrect: false,
                keyboardType: TextInputType.number,
                controller: _key,
                maxLines: 1,
                decoration: new InputDecoration(
                  labelText: "Key",
                ),
              ),
            ),

            // Botões
            new Row(
              children: <Widget>[
                new BotaoEncrypt(_input),
                new BotaoDecrypt(_input),
              ],
            ),

            // Output
            new Container(
              margin: new EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0, bottom: 32.0),
              child: new TextField(
                controller: _output,
                decoration: new InputDecoration(
                  labelText: "Output",
                ),
              ),
            ),
          ],
        ),
      //),
    );
  }
}

class BotaoEncrypt extends StatelessWidget {
  final TextEditingController _plaintext;

  BotaoEncrypt(this._plaintext);

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.only(left: 16.0),
      child: new FlatButton(
        color: Colors.grey.shade300,
        onPressed: () => debugPrint("encrypt"),
        child: new Center(child: new Text("Encrypt")),
      ),
    );
  }
}

class BotaoDecrypt extends StatelessWidget {
  final TextEditingController _ciphertext;

  BotaoDecrypt(this._ciphertext);

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.only(left: 16.0),
      child: new FlatButton(
        color: Colors.grey.shade300,
        onPressed: () => debugPrint("decrypt"),
        child: new Center(child: new Text("Decrypt")),
      ),
    );
  }
}
