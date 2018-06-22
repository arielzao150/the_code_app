import 'package:flutter/material.dart';
import './basic_crypto.dart';
import './criptografias/base64.dart';
import './criptografias/caesar.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    List<Criptografia> types = new List<Criptografia>();
    types.add(new Base64());
    types.add(new CaesarShift());

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
                    title: new Text(tipo.nome),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => tipo));
                    },
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
