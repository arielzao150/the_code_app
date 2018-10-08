import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../basic_crypto.dart';
import 'dart:math';
import 'dart:io';

class Kamasutra extends Criptografia {
  final String explicacao =
  """Essa criptografia gera uma lista com 26 letras do alfabeto sem repetições e depois a divide em e 2 linhas com 13 letras em cada uma. Feito isso, ela procura cada letra do texto digitado e a substitui pela letra que possui a mesma posição que ela na outra linha""";
  final String nome = "Kamasutra";
  final Nivel nivel = Nivel.BASICO;

  @override
  State<StatefulWidget> createState() =>
      _KamasutraState(explicacao, nome);

  @override
  String decrypt(String cyphertext, {String key}) {
    String text = cyphertext.toUpperCase();
    //String key  = keyKS;
    String enc = KSutra(text, key);
    //String dec = KSutra(enc, key);

    return enc;
  }

  @override
  String encrypt(String plaintext, {String key}) {
    String text = plaintext.toUpperCase();
    //String key = keyKS;
    String enc = KSutra(text, key);

    return enc;
  }
}

String RandomAlphaNoDuplicate(int len) {
  var r = new Random();
  String key = "";
  for (int i = 0; i < len;) {
    var c = "A".codeUnits.first + r.nextInt(26);
    if (!key.contains(String.fromCharCode(c))) {
      key += String.fromCharCode(c);
      i++;
    }
  }
  return key;
}

String KSutra(String text, String key) {
  double keyLen = key.length / 2;

  List keyRow = new List(key.length);
  int count = 0;
  int x = 0;
  int z = 0;
  for (x = 0; x < 2; x++) {
    if (x == 0) {
      z = 0;
    } else {
      z = keyLen.toInt();
    }

    for (int y = 0; y < keyLen; y++) {
      keyRow[y + z] = key[count];
      count++;
    }


  }

  String sb = "";

  count = 0;
  int j = 0;
  for (int z = 0; z < text.length; z++) {
    for (int x = 0; x < 2; x++) {
      if (x == 0) {
        j = 0;
      } else {
        j = keyLen.toInt();
      }

      for (int y = 0; y < keyLen; y++) {
        if (x == 0) {
          if (text[z] == keyRow[j + y]) {
            sb += keyRow[j + keyLen.toInt() + y];
          }
        } else if (x == 1) {
          if (text[z] == keyRow[j + y]) {
            sb += keyRow[j - keyLen.toInt() + y];
          }
        }
      }
    }
    if (text[z] == ' ') sb += text[z];
  }

  return sb;
}

class _KamasutraState extends State<Kamasutra> {
  final TextEditingController _input = new TextEditingController();
  String keyKS = RandomAlphaNoDuplicate(26);
  String _output = "Resultado";
  final String explicacao;
  final String nome;
  final Kamasutra CRIPTO = new Kamasutra();

  _KamasutraState(this.explicacao, this.nome);

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
            child: new RichText(
              text: new TextSpan(
                text: keyKS,
                style: new TextStyle(color: Colors.black),
              ),
              textDirection: TextDirection.ltr,
              overflow: TextOverflow.clip,
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
                      _output = CRIPTO.encrypt(_input.text, key: keyKS);
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
                      _output = CRIPTO.decrypt(_input.text, key: keyKS);
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
