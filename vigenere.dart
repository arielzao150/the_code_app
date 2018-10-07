import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../basic_crypto.dart';

class Vigenere extends Criptografia {
  final String explicacao = "\b\bA cifra de Vigenère é uma técnica de criptografia por "
      "substituição polialfabética que utiliza uma "
      "série de cifras de César diferentes, baseadas "
      "nas letras de uma palavra-chave."
      "\n\b\b"
      "O método foi descrito originalmente pelo criptologista italiano Giovan Battista Bellaso. "
      "Entretanto, foi atribuído posteriormente - e de forma errônea - a Blaise de Vigenère no "
      "século XIX, e por isso é conhecida até os dias de hoje por 'Cifra de Vigenère.'"
      "\n\b\b"
      "Trata-se de uma cifra muito simples de entender, implementar e até mesmo quebrar, "
      "mas mesmo assim três séculos se passaram até que alguém conseguisse quebrá-la (decifrar mensagens). "
      "Chegou a receber a alcunha de 'le chiffre indéchiffrable' ('A cifra indecifrável', em francês). "
      "Um método geral de decifrá-la foi publicado pelo criptógrafo e arqueólogo alemão Friedrich Kasiski em 1863 apenas.";
  final String nome = "Vigenère Cipher";
  final Nivel nivel = Nivel.MEDIO;
  final int code_init = "A".codeUnits.first;
  final int code_end = "Z".codeUnits.first;
  final int code_space = 32;

  @override
  State<StatefulWidget> createState() => _VigenereState(explicacao, nome);

  List generateKeyCodes(int length, String key) {
    var newKeys = new List(length);

    for (int i = 0, j = 0; i < length; ++i, ++j) {
      if (j == key.length) j = 0;
      var keyCode = key[j].codeUnits.first;
      if (keyCode >= code_init && keyCode <= code_end) newKeys[i] = keyCode;
    }

    return newKeys;
  }

  @override
  String decrypt(String cipherText, {String key}) {
    var cipherLength = cipherText.length;
    var keyCodes = generateKeyCodes(cipherLength, key);

    var decrypted = new List(cipherLength);
    for (int i = 0; i < cipherLength; ++i) {
      var cipherCode = cipherText[i].codeUnits.first;

      if (cipherCode == code_space)
        decrypted[i] = " ";
      else {
        var charCode = ((((cipherCode - keyCodes[i]) + 26) % 26) + code_init);
        decrypted[i] = new String.fromCharCode(charCode);
      }
    }

    var plaintext = "";
    for (int i = 0; i < decrypted.length; i++) plaintext += decrypted[i];

    return plaintext;
  }

  @override
  String encrypt(String plaintext, {String key}) {
    var textLength = plaintext.length;
    var keyCodes = generateKeyCodes(textLength, key);

    var encrypted = new List(textLength);
    for (int i = 0; i < textLength; ++i) {
      var charCode = plaintext[i].codeUnits.first;

      if (charCode == code_space)
        encrypted[i] = " ";
      else {
        var cipherCode = (((charCode + keyCodes[i]) % 26) + code_init);
        encrypted[i] = new String.fromCharCode(cipherCode);
      }
    }

    var cipherText = "";
    for (int i = 0; i < encrypted.length; i++) cipherText += encrypted[i];

    return cipherText;
  }
}

class _VigenereState extends State<Vigenere> {
  final TextEditingController _input = new TextEditingController();
  final TextEditingController _key = new TextEditingController();
  String _output = "";
  final String explicacao;
  final String nome;
  final Vigenere CRIPTO = new Vigenere();

  _VigenereState(this.explicacao, this.nome);

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
         // new Image.asset(
         //   'assets/images/quadrado-vigenere-criptografia.png'
         // ),
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

                for (int i = 0; i < input.length; i++) {
                  var value = input[i].codeUnits.first;
                  if (value < "A".codeUnits.first ||
                      value > "Z".codeUnits.first &&
                      value < "a".codeUnits.first ||
                      value > "z".codeUnits.first) return "Input inválido";
                }
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
              maxLines: 1,
              decoration: new InputDecoration(
                labelText: "Chave",
              ),
              validator: (input) {
                if (input.isEmpty) return "Chave não pode ser vazia";

                for (int i = 0; i < input.length; i++) {
                  var value = input[i].codeUnits.first;
                  if (value < "A".codeUnits.first ||
                      value > "Z".codeUnits.first &&
                          value < "a".codeUnits.first ||
                      value > "z".codeUnits.first) return "Chave inválida";
                }
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
                      _output = CRIPTO.encrypt(_input.text.toUpperCase(),
                          //.replaceAll(new RegExp(r"\s+\b|\b\s"), ""), //Caso seja desesável criptografar sem manter os espaços
                          key: _key.text.toUpperCase());
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
                      _output = CRIPTO.decrypt(_input.text.toUpperCase(),
                          key: _key.text.toUpperCase());
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
                left: 16.0, right: 16.0, top: 16.0, bottom: 16.0),
            child: new Text(
              _output != null ? 'Resultado: ' + _output : null,
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
