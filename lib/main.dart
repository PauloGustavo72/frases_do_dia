import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:frases_do_dia/domain.dart';

void main() => runApp(MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
    ));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    _loadCrosswordAsset().then((value) => this._phrase = value);
    super.initState();
  }

  var _phrase;
  var _generatedPhrase = "Clique abaixo para gerar uma frase!";

  Future<List<Phrase>> _loadCrosswordAsset() async {
    List<Phrase> phrasesByJson = List();

    String jsonString = await rootBundle.loadString('data/phrases.json');

    var json = jsonDecode(jsonString);

    json.forEach((j) => phrasesByJson.add(Phrase.fromJson(j)));

    return phrasesByJson;
  }

  Future<void> _generatePhrase() async {
    var numberDrawn = Random().nextInt(_phrase.length);
    _generatedPhrase = _phrase[numberDrawn].phrase;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Frases do dia"),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset('images/logo.png'),
              Text(
                _generatedPhrase,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 17,
                  fontStyle: FontStyle.italic,
                  color: Colors.black,
                ),
              ),
              RaisedButton(
                child: Text(
                  'Nova Frase',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                color: Colors.green,
                onPressed: () {
                  setState(() {
                    _generatePhrase();
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
