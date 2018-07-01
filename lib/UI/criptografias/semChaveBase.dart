import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../basic_crypto.dart';

class NOME_DA_CRIPTOGRAFIA extends Criptografia {
  final String explicacao = """INSERIR EXPLICAÇÃO DA CRIPTOGRAFIA AQUI""";
  final String nome = "NOME DA CRIPTOGRAFIA";
  final Nivel nivel = Nivel.AVANCADO;

  @override
  State<StatefulWidget> createState() => _NOME_DA_CRIPTOGRAFIAState(explicacao, nome);

  @override
  String decrypt(String cyphertext, {String key}) {
    return "DECRYPT Plain = " + cyphertext;
  }

  @override
  String encrypt(String plaintext, {String key}) {
    return "ENCRYPT Plain = " + plaintext;
  }
}

class _NOME_DA_CRIPTOGRAFIAState extends State<NOME_DA_CRIPTOGRAFIA> {
  final TextEditingController _input = new TextEditingController();
  String _output = "Resultado";
  final String explicacao;
  final String nome;
  final NOME_DA_CRIPTOGRAFIA CRIPTO = new NOME_DA_CRIPTOGRAFIA();

  _NOME_DA_CRIPTOGRAFIAState(this.explicacao, this.nome);

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
        Scaffold
            .of(context)
            .showSnackBar(new SnackBar(content: new Text("Resultado copiado")));
      },
      color: Colors.grey.shade300,
    );
  }
}
