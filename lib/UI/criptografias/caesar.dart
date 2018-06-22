import 'package:flutter/material.dart';
import '../basic_crypto.dart';

class CaesarShift extends Criptografia {
  final String explicacao = "Caesar EXPLICAÇÃO";
  final String nome = "Caesar's Shift";
  @override
  String encrypt(String plaintext) {
    return "";
  }

  @override
  String decrypt(String cyphertext) {
    return "";
  }

  @override
  State<StatefulWidget> createState() => _CaesarShiftState(explicacao);
}
class _CaesarShiftState extends State<CaesarShift>{
  final TextEditingController _plaintext = new TextEditingController();
  final TextEditingController _cyphertext = new TextEditingController();
  final String explicacao;

  _CaesarShiftState(this.explicacao);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Caesar's Shift"),
      ),
      body: new Container(
        child: new Column(
          children: <Widget>[
            new Container(
//              child: new Text(
//                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean iaculis condimentum eros. Nam faucibus congue tortor, vel venenatis diam maximus et. Vestibulum ante ipsum primis.",
//                textAlign: TextAlign.justify,
//                style: new TextStyle(color: Colors.red),
//              ),
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

            // plaintext
            new Container(
              margin: new EdgeInsets.all(16.0),
              child: new TextField(
                autocorrect: false,
                controller: _plaintext,
                maxLines: 1,
                decoration: new InputDecoration(
                  labelText: "Input",
                ),
              ),
            ),

            new Row(
              children: <Widget>[
                new BotaoEncrypt(_plaintext),
                new BotaoDecrypt(),
              ],
            ),

            new Container(
              margin: new EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
              child: new TextField(
                controller: _cyphertext,
                decoration: new InputDecoration(
                  labelText: "Output",
                ),
              ),
            ),
          ],
        ),
      ),
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
