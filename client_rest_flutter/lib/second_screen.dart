import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  final controller = TextEditingController();
  String response = '';

  Future<void> getData(String code) async {
    var res = await http.get(Uri.parse('http://172.17.0.76/server_REST.php?codice=$code'));
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
      backgroundColor: const Color.fromARGB(255, 80, 78, 78),
      appBar: AppBar(
        title: Text('Seconda Schermata'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: controller,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Inserisci il codice',
                labelStyle: TextStyle(color: Colors.white),
              ),
            ),
            ElevatedButton(
              child: Text('Invia richiesta'),
              onPressed: () {
                getData(controller.text);
              },
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 16.0),
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color.fromARGB(255, 194, 182, 182)),
                ),
                child: Text(response, style: TextStyle(color: Color.fromARGB(255, 253, 251, 251))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}