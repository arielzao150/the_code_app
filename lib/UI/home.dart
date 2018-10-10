import 'package:flutter/material.dart';
import './basic_crypto.dart';

// Criptografias
import './criptografias/base64.dart';
import './criptografias/caesar.dart';
import './criptografias/RailFence.dart';
import './criptografias/transposition.dart';
import './criptografias/vigenere.dart';
import './criptografias/semChaveBase.dart';
import './criptografias/atbash.dart';
import './criptografias/Kamasutra.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    List<Criptografia> types = new List<Criptografia>();

    // Inserir todas as criptografias aqui
    types.add(new Base64());
    types.add(new Transposition());
    types.add(new CaesarShift());
    types.add(new RailFence());
    types.add(new Vigenere());
    types.add(new Atbash());
    types.add(new Kamasutra());
    types.add(new NOME_DA_CRIPTOGRAFIA());

    types.sort((Criptografia a, Criptografia b) {
      if (a.nivel == b.nivel)
        return a.nome.compareTo(b.nome);
      else
        return a.nivel.index > b.nivel.index ? 1 : -1;
    });
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("The Code App"),
      ),
      body: new Container(
        child: new Center(
          child: ListView.builder(
            itemCount: types.length,
            itemBuilder: (context, index) {
              final Criptografia tipo = types[index];
              return new Column(
                children: <Widget>[
                  new ListTile(
                    title: new Text(
                      tipo.nome,
                      style: new TextStyle(fontSize: 20.0),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => tipo));
                    },
                    trailing: new Text(tipo.nivel.toString().substring(6)),
                    leading: new Icon(Icons.vpn_key),
                  ),
                  new Divider(
                    color: Colors.grey,
                    height: 2.0,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
