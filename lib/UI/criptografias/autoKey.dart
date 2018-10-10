import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../autoKey.dart';

class Autokey extends Autokey {
  final String explicacao = "Auto Key: utiliza uma frase como chave para realizar a criptografia de uma outra frase."
      "A criptografia ocorre com a movimentação das letras com base na ";
  final String nome = "Auto Key";
  final Nivel nivel = Nivel.AVANCADO;

  @override
  State<StatefulWidget> createState() => _BaconianCypher(explicacao, nome);

  @override
  String decrypt(String cyphertext, {String key}) {
    int len = text.length();

    String current = key;
    String sb ="";

    for(int x=0;x<len;x++){
      int get1 = alpha.indexOf(text.charAt(x));
      int get2 = alpha.indexOf(current.charAt(x));

      int total = (get1 - get2)%26;
      total = (total<0)? total + 26 : total;
      sb += alpha.charAt(total);

      current += alpha.charAt(total);
    }
    cyphertext = sb;
    return "Decrypt Cypher = " + cyphertext;
  }

  @override
  String encrypt(String plaintext, {String key}) {
    int len = text.length();

    String subkey = key + text;
    subkey = subkey.substring(0,subkey.length()-key.length());

    String sb = "";
    for(int x=0;x<len;x++){
      int get1 = alpha.indexOf(text.charAt(x));
      int get2 = alpha.indexOf(subkey.charAt(x));

      int total = (get1 + get2)%26;

      sb += alpha.charAt(total);
    }

    plaintext = sb;
    return "Encrypt Plain = " + plaintext;
  }
}

class Autokey extends State<Autokey> {
  final TextEditingController _input = new TextEditingController();
  String _output = "Resultado";
  final String explicacao;
  final String nome;
  final Autokey autokey = new Autokey();

  Autokey(this.explicacao, this.nome);

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
