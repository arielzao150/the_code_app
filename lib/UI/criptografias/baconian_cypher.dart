import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../baconian_cypher.dart';

class BaconianCypher extends Criptografia {
  final String explicacao = "Cifra Baconiana: utiliza para cada caracter de uma frase um conjunto com quatro caracteres para realizar a criptografia";
  final String nome = "Cifra Baconiana";
  final Nivel nivel = Nivel.AVANCADO;

  @override
  State<StatefulWidget> createState() => _BaconianCypher(explicacao, nome);

  private Dictionary<char, string> codes = new Dictionary<char, string>{
  {'a', "AAAAA" }, {'b', "AAAAB" }, {'c', "AAABA" }, {'d', "AAABB" }, {'e', "AABAA" },
  {'f', "AABAB" }, {'g', "AABBA" }, {'h', "AABBB" }, {'i', "ABAAA" }, {'j', "ABAAB" },
  {'k', "ABABA" }, {'l', "ABABB" }, {'m', "ABBAA" }, {'n', "ABBAB" }, {'o', "ABBBA" },
  {'p', "ABBBB" }, {'q', "BAAAA" }, {'r', "BAAAB" }, {'s', "BAABA" }, {'t', "BAABB" },
  {'u', "BABAA" }, {'v', "BABAB" }, {'w', "BABBA" }, {'x', "BABBB" }, {'y', "BBAAA" },
  {'z', "BBAAB" }, {' ', "BBBAA" },
  };

  @override
  String decrypt(String cyphertext, {String key}) {
    //vai aqui...
    StringBuilder sb = new StringBuilder();
    for(var c in message) {
      if ('a' <= c && c <= 'z') sb.Append('A');
      else if ('A' <= c && c <= 'Z') sb.Append('B');
    }
    string et = sb.ToString();
    sb.Length = 0;
    for (int i = 0; i < et.Length; i += 5) {
      string quintet = et.Substring(i, 5);
      char key = codes.Where(a => a.Value == quintet).First().Key;
      sb.Append(key);
    }
    cyphertext = sb.ToString();
    return "Decrypt Cypher = " + cyphertext;
  }

  @override
  String encrypt(String plaintext, {String key}) {
    string pt = plainText.ToLower();
    StringBuilder sb = new StringBuilder();
    for (var c in pt) {
      if ('a' <= c && c <= 'z') sb.Append(codes[c]);
      else sb.Append(codes[' ']);
    }
    string et = sb.ToString();
    string mg = message.ToLower();
    sb.Length = 0;
    int count = 0;
    foreach (char c in mg) {
      if ('a' <= c && c <= 'z') {
        if (et[count] == 'A') sb.Append(c);
        // Equivalente em maiusculo
        else sb.Append((char)(c - 32));
        count++;
        if (count == et.Length) break;
      }
      else sb.Append(c);
    }

    plaintext = sb.ToString();
    return "Encrypt Plain = " + plaintext;
  }
}

class BacnonianCypher extends State<BacnonianCypher> {
  final TextEditingController _input = new TextEditingController();
  String _output = "Resultado";
  final String explicacao;
  final String nome;
  final BacnonianCypher baconian = new BacnonianCypher();

  BacnonianCypher(this.explicacao, this.nome);

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
                      _output = base64.encrypt(_input.text);
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
                      _output = base64.decrypt(_input.text);
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
              left: 16.0, right: 16.0, top: 16.0,),
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
        Scaffold
            .of(context)
            .showSnackBar(new SnackBar(content: new Text("Resultado copiado")));
      },
      color: Colors.grey.shade300,
    );
  }
}
