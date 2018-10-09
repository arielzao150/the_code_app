import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../basic_crypto.dart';

class Atbash extends Criptografia {
  final String explicacao = "Atbash é uma criptografia de simples substituição do alfabeto hebraico. Ela consiste na substituição do aleph (a primeira letra) pela tav (a última), beth (a segunda) pela shin (a penúltima), e assim por diante, invertendo o alfabeto usual."
                            "\nUma decodificação em Atbash para o alfabeto romano seria assim: "
                            "\n\nNormal:  A B C D E F G H I J K L M N O P Q R S T U V W X Y Z"
                            "\nCódigo:  Z Y X W V U T S R Q P O N M L K J I H G F E D C B A"
                            "\n\nO método Atbash pode ser usado para criptografar expressões de qualquer alfabeto, devido à simplicidade da substituição das letras. ";
  final String nome = "Atbash";
  final Nivel nivel = Nivel.BASICO;

  @override
  State<StatefulWidget> createState() => _AtbashState(explicacao, nome);

  @override
  String decrypt(String cyphertext, {String key}) {
    String alfa = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    String alfaReverso = "";
    //Revertendo o Alfabeto
    for(int i = alfa.length-1; i > -1; i--){
      alfaReverso += alfa[i];
    }

    String dencryText = "";
    for (int i = 0; i < cyphertext.length; i++){
      if(cyphertext.codeUnitAt(i) == 32){
        dencryText += " ";
      }
      else{

        for(int j = 0; j < alfaReverso.length; j++){
          if(cyphertext[i] == alfaReverso[j]){
            dencryText += alfa[j];
            break;
          }
        }
      }
    }
    return dencryText;
  }

  @override
  String encrypt(String plaintext, {String key}) {
    String alfa = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    String alfaReverso = "";
    //Revertendo o Alfabeto
    for(int i = alfa.length-1; i > -1; i--){
      alfaReverso += alfa[i];
    }

    String encryText = "";
    plaintext = plaintext.toUpperCase();
    for (int i = 0; i < plaintext.length; i++){
      if(plaintext.codeUnitAt(i) == 32){
        encryText += " ";
      }
      else{

        for(int j = 0; j < alfa.length; j++){
          if(plaintext[i] == alfa[j]){
            encryText += alfaReverso[j];

          }
        }
      }
    }
    return encryText;
  }
}

class _AtbashState extends State<Atbash> {
  final TextEditingController _input = new TextEditingController();
  String _output = "Resultado";
  final String explicacao;
  final String nome;
  final Atbash CRIPTO = new Atbash();

  _AtbashState(this.explicacao, this.nome);

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
