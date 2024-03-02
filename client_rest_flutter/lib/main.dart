import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    home: FirstScreen(),
  ));
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prima Schermata'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Vai alla seconda schermata'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SecondScreen()),
            );
          },
        ),
      ),
    );
  }
}

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  final controller = TextEditingController();
  String response = '';

  Future<void> getData(String code) async {
    var res = await http.get(Uri.parse('http://172.17.0.1011/server.php?codice=$code'));
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      setState(() {
        response = 'Nome: ${data['nome']}\n'
            'Cognome: ${data['cognome']}\n'
            'Reparto: ${data['reparto']}';
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seconda Schermata'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: 'Inserisci il codice',
              ),
            ),
            ElevatedButton(
              child: Text('Invia richiesta'),
              onPressed: () {
                getData(controller.text);
              },
            ),
            Text(response),
          ],
        ),
      ),
    );
  }
}