import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../basic_crypto.dart';

class CaesarShift extends Criptografia {
  final String explicacao = """Um dos métodos mais simples e conhecidos de criptografia, a Cifra de César, nomeada assim por ter sido utilizada na correspondência de Júlio César, utiliza o método de substituição para transformar cada letra do plaintext em outra letra em ordem alfabética. Por exemplo, com nível 3, a letra A viraria D, B viraria E, e assim por diante.

Esta criptografia é normalmente incorporada em outros esquemas mais complexos, como a Cifra Vigenère, e ainda tem aplicações mais modernas. Assim como todas cifras de substituição mono-alfabéticas (que utilizam somente 1 alfabeto), a Cifra de César é facilmente quebrada e em práticas modernas oferece essencialmente nenhuma segurança.""";
  final String nome = "Cifra de César";
  final Nivel nivel = Nivel.BASICO;

  @override
  State<StatefulWidget> createState() => _CaesarShiftState(explicacao, nome);

  @override
  String decrypt(String cyphertext, {String key}) {
    int chave = key.isEmpty ? -1 : -int.parse(key);

    String plaintext = "";
    for (int i = 0; i < cyphertext.length; i++)
      plaintext += transformaChar(cyphertext[i], chave);
    return plaintext;
  }

  String transformaChar(String plain, int chave) {
    var alphabet = [
      'A',
      'B',
      'C',
      'D',
      'E',
      'F',
      'G',
      'H',
      'I',
      'J',
      'K',
      'L',
      'M',
      'N',
      'O',
      'P',
      'Q',
      'R',
      'S',
      'T',
      'U',
      'V',
      'W',
      'X',
      'Y',
      'Z'
    ];

    if (plain == 'a' || plain == 'A')
      return alphabet[0 + chave % 26];
    else if (plain == 'b' || plain == 'B')
      return alphabet[(1 + chave) % 26];
    else if (plain == 'c' || plain == 'C')
      return alphabet[(2 + chave) % 26];
    else if (plain == 'd' || plain == 'D')
      return alphabet[(3 + chave) % 26];
    else if (plain == 'e' || plain == 'E')
      return alphabet[(4 + chave) % 26];
    else if (plain == 'f' || plain == 'F')
      return alphabet[(5 + chave) % 26];
    else if (plain == 'g' || plain == 'G')
      return alphabet[(6 + chave) % 26];
    else if (plain == 'h' || plain == 'H')
      return alphabet[(7 + chave) % 26];
    else if (plain == 'i' || plain == 'I')
      return alphabet[(8 + chave) % 26];
    else if (plain == 'j' || plain == 'J')
      return alphabet[(9 + chave) % 26];
    else if (plain == 'k' || plain == 'K')
      return alphabet[(10 + chave) % 26];
    else if (plain == 'l' || plain == 'L')
      return alphabet[(11 + chave) % 26];
    else if (plain == 'm' || plain == 'M')
      return alphabet[(12 + chave) % 26];
    else if (plain == 'n' || plain == 'N')
      return alphabet[(13 + chave) % 26];
    else if (plain == 'o' || plain == 'O')
      return alphabet[(14 + chave) % 26];
    else if (plain == 'p' || plain == 'P')
      return alphabet[(15 + chave) % 26];
    else if (plain == 'q' || plain == 'Q')
      return alphabet[(16 + chave) % 26];
    else if (plain == 'r' || plain == 'R')
      return alphabet[(17 + chave) % 26];
    else if (plain == 's' || plain == 'S')
      return alphabet[(18 + chave) % 26];
    else if (plain == 't' || plain == 'T')
      return alphabet[(19 + chave) % 26];
    else if (plain == 'u' || plain == 'U')
      return alphabet[(20 + chave) % 26];
    else if (plain == 'v' || plain == 'V')
      return alphabet[(21 + chave) % 26];
    else if (plain == 'w' || plain == 'W')
      return alphabet[(22 + chave) % 26];
    else if (plain == 'x' || plain == 'X')
      return alphabet[(23 + chave) % 26];
    else if (plain == 'y' || plain == 'Y')
      return alphabet[(24 + chave) % 26];
    else if (plain == 'z' || plain == 'Z')
      return alphabet[(25 + chave) % 26];
    else
      return plain;
  }

  @override
  String encrypt(String plaintext, {String key}) {
    int chave = key.isEmpty ? 1 : int.parse(key);

    String cyphertext = "";
    for (int i = 0; i < plaintext.length; i++)
      cyphertext += transformaChar(plaintext[i], chave);
    return cyphertext;
  }
}

class _CaesarShiftState extends State<CaesarShift> {
  final TextEditingController _input = new TextEditingController();
  final TextEditingController _key = new TextEditingController();
  String _output = "Resultado";
  final String explicacao;
  final String nome;
  final CaesarShift CRIPTO = new CaesarShift();

  _CaesarShiftState(this.explicacao, this.nome);

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
                      _output = CRIPTO.encrypt(_input.text, key: _key.text);
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
                      _output = CRIPTO.decrypt(_input.text, key: _key.text);
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
        Scaffold
            .of(context)
            .showSnackBar(new SnackBar(content: new Text("Resultado copiado")));
      },
      color: Colors.grey.shade300,
    );
  }
}
