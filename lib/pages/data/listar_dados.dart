import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sistema_escolar/models/contact.dart';

import 'package:sistema_escolar/utils/common.dart';
import 'package:http/http.dart' as http;

class Listar extends StatefulWidget {
  @override
  _ListarState createState() => _ListarState();
}

class _ListarState extends State<Listar> {
  List<Contact> contactos = <Contact>[];
  Future<List<Contact>> fetchContact() async {
    var result = await http.get(Uri.parse(allContactos));
    var cont = <Contact>[];

    if (result.statusCode == 200) {
      var jsonD = json.decode(result.body);
      for (var jsonOut in jsonD) {
        cont.add(Contact.fromJson(jsonOut));
      }
    }
    return cont;
  }

  @override
  void initState() {
    super.initState();
    fetchContact().then((value) {
      setState(() {
        contactos.addAll(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: FutureBuilder(
        future: fetchContact(),
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: contactos.length,
            itemBuilder: (context, int i) {
              return ListTile(
                leading: CircleAvatar(
                  child: Text(
                    contactos[i].name.toString().substring(1, 2).toUpperCase(),
                  ),
                ),
                title: Text(contactos[i].name),
              
              );
            },
          );
        },
      ),
    );
  }
}
