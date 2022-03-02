import 'dart:async';
import 'dart:html';
import 'dart:math';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  String _theState = "0";
  int _actualWordType = 0;
  int puntos = 0;
  bool _wrong = false;
  final _random = new Random();

  int next(int min, int max) => min + _random.nextInt(max - min);

  @override
  void initState() {
    super.initState();
    setRandomWord();
  }

  void setRandomWord() {
    setState(() {
      _actualWordType = next(0, 2);
    });
    if (_actualWordType == 0) {
      print("change to noun");
      setState(() {
        _theState = (nouns.toList()..shuffle()).first;
      });
    } else {
      print("change to adjective");
      setState(() {
        _theState = (adjectives.toList()..shuffle()).first;
      });
    }
  }

  void _onPressed(int word) {
    if (word == _actualWordType) {
      setState(() {
        puntos++;
      });
      setRandomWord();
    } else {
      setState(() {
        puntos = 0;
        _wrong = true;
      });
      Timer(Duration(seconds: 1), () {
        setState(() {
          _wrong = false;
        });
      });
      setRandomWord();
    }
  }

  void _onReset() {
    setState(() {
      puntos = 0;
    });
    setRandomWord();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Random Words"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text("PUNTOS: " + "$puntos",
              style: TextStyle(fontSize: 20, color: Colors.blue)),
          Text("$_theState",
              style: TextStyle(fontSize: 20, color: Colors.blue)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Container(
                  height: 200,
                  child: ElevatedButton(
                      onPressed: () => _onPressed(0),
                      child: Text("Noun", style: TextStyle(fontSize: 20)),
                      style: ElevatedButton.styleFrom(
                          primary: _wrong ? Colors.grey : Colors.blue)),
                ),
              ),
              Expanded(
                child: Container(
                  height: 200,
                  child: ElevatedButton(
                      onPressed: () => _onPressed(1),
                      child: Text("Adjective", style: TextStyle(fontSize: 20)),
                      style: ElevatedButton.styleFrom(
                          primary: _wrong ? Colors.grey : Colors.blue)),
                ),
              )
            ],
          ),
          ElevatedButton(onPressed: () => _onReset(), child: Text("Reset")),
        ],
      ),
    );
  }
}
