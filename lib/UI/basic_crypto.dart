import 'package:flutter/material.dart';

abstract class Criptografia extends StatefulWidget{
  final String explicacao = "";
  final String nome = "";
  final Nivel nivel = Nivel.BASICO;
  String encrypt(String plaintext, {String key});
  String decrypt(String cyphertext, {String key});
}

enum Nivel{
  BASICO,
  MEDIO,
  AVANCADO
}

class Basic extends StatefulWidget {
  @override
  _BasicState createState() => _BasicState("","");
}

class _BasicState extends State<Basic> {
  final TextEditingController _input = new TextEditingController();
  final TextEditingController _key = new TextEditingController();
  final TextEditingController _output = new TextEditingController();
  final String explicacao;
  final String nome;

  _BasicState(this.explicacao, this.nome);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Basic"),
      ),
      body: new Container(
        child: new Column(
          children: <Widget>[

            // Explicação
            new Container(
              child: new RichText(
                text: new TextSpan(
                  text:
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                  style: new TextStyle(color: Colors.black),
                  children: <TextSpan>[
                    new TextSpan(
                        text: ' Aenean iaculis condimentum eros.',
                        style: new TextStyle(fontWeight: FontWeight.bold)),
                    new TextSpan(
                        text:
                            ' Nam faucibus congue tortor, vel venenatis diam maximus et. Vestibulum ante ipsum primis.'),
                  ],
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
              margin: new EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
              child: new TextField(
                controller: _output,
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

// COPIAR CRIPTOGRAFIA SEM CHAVE




// COPIAR CRIPTOGRAFIA COM CHAVE
//class _NOME_DA_CRIPTOGRAFIAState extends State<NOME_DA_CRIPTOGRAFIA> {
//  final TextEditingController _input = new TextEditingController();
//  final TextEditingController _key = new TextEditingController();
//  String _output = "Resultado";
//  final String explicacao;
//  final String nome;
//
//  final NOME_DA_CRIPTOGRAFIA VARIAVEL_DA_CRIPTO = new NOME_DA_CRIPTOGRAFIA();
//
//  _NOME_DA_CRIPTOGRAFIAState(this.explicacao, this.nome);
//
//
//  @override
//  Widget build(BuildContext context) {
//    return new Scaffold(
//      appBar: new AppBar(
//        title: new Text(nome),
//      ),
//      body: new ListView(
//        children: <Widget>[
//          // Explicação
//          new Container(
//            child: new RichText(
//              text: new TextSpan(
//                text: explicacao,
//                style: new TextStyle(color: Colors.black),
//              ),
//              textDirection: TextDirection.ltr,
//              overflow: TextOverflow.clip,
//            ),
//            margin: new EdgeInsets.all(16.0),
//          ),
//
//          // Input
//          new Container(
//            margin: new EdgeInsets.all(16.0),
//            child: new TextField(
//              autocorrect: false,
//              controller: _input,
//              maxLines: 1,
//              decoration: new InputDecoration(
//                labelText: "Input",
//              ),
//            ),
//          ),
//
//          // Key
//          new Container(
//            margin: new EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
//            child: new TextField(
//              autocorrect: false,
//              keyboardType: TextInputType.number, // Pode ser mudado
//              controller: _key,
//              maxLines: 1,
//              decoration: new InputDecoration(
//                labelText: "Chave",
//              ),
//            ),
//          ),
//
//          // Botões
//          new Row(
//            children: <Widget>[
//              new Container(
//                margin: EdgeInsets.only(left: 16.0),
//                child: new FlatButton(
//                  color: Colors.grey.shade300,
//                  onPressed: () {
//                    setState(() {
//                      _output =
//                          VARIAVEL_DA_CRIPTO.encrypt(_input.text, key: _key.text);
//                    });
//                  },
//                  child: new Center(child: new Text("Encrypt")),
//                ),
//              ),
//              new Container(
//                margin: EdgeInsets.only(left: 16.0),
//                child: new FlatButton(
//                  color: Colors.grey.shade300,
//                  onPressed: () {
//                    setState(() {
//                      _output =
//                          VARIAVEL_DA_CRIPTO.decrypt(_input.text, key: _key.text);
//                    });
//                  },
//                  child: new Center(child: new Text("Decrypt")),
//                ),
//              ),
//            ],
//          ),
//
//          // Output
//          new Container(
//            margin: new EdgeInsets.only(
//                left: 16.0, right: 16.0, top: 16.0, bottom: 32.0),
//            child: new Text(
//              _output,
//              style: new TextStyle(
//                fontSize: 20.0,
//              ),
//            ),
//          )
//        ],
//      ),
//    );
//  }
//}