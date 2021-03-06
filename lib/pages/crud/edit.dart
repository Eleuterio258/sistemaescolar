import 'package:flutter/material.dart';
import 'package:sistema_escolar/helpers/database_helper.dart';
import 'package:sistema_escolar/models/contact.dart';
import 'package:sistema_escolar/pages/crud/home_page.dart';

// ignore: must_be_immutable
class EditPage extends StatefulWidget {
  Contact contact;

  EditPage({Key key, this.contact}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new EditPageState();
  }
}

class EditPageState extends State<EditPage> {
  var textEditingControllerName = new TextEditingController();
  var textEditingControllerPhone = new TextEditingController();
  var textEditingControllerDescription = new TextEditingController();
  var textEditingControllerEmail = new TextEditingController();
  var textEditingControllerAdress = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    textEditingControllerName.text = widget.contact.name;
    textEditingControllerPhone.text = widget.contact.phone;
    textEditingControllerDescription.text = widget.contact.description;
    textEditingControllerEmail.text = widget.contact.email;
    textEditingControllerAdress.text = widget.contact.address;

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: Text("Edit Contact"),
          ),
          body: Padding(
            padding: EdgeInsets.all(10),
            child: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(hintText: "Name"),
                  controller: textEditingControllerName,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: "Phone"),
                  controller: textEditingControllerPhone,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(hintText: "Adress"),
                  controller: textEditingControllerAdress,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(hintText: "Email"),
                  controller: textEditingControllerEmail,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(hintText: "Description"),
                  controller: textEditingControllerDescription,
                  maxLines: 5,
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: ElevatedButton(
                        child: Text("Save"),
                        onPressed: () async {
                          widget.contact.name = textEditingControllerName.text;
                          widget.contact.description =
                              textEditingControllerDescription.text;
                          widget.contact.phone =
                              textEditingControllerPhone.text;
                          widget.contact.address =
                              textEditingControllerAdress.text;
                          widget.contact.email =
                              textEditingControllerEmail.text;
                          var contact = new Contact(
                            name: textEditingControllerName.text,
                            description: textEditingControllerDescription.text,
                            phone: textEditingControllerPhone.text,
                            address: textEditingControllerAdress.text,
                            email: textEditingControllerEmail.text,
                          );
                          var db = DatabaseHelper();
                          await db.update(widget.contact);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ));
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5, right: 5),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        child: Text("Cancel"),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ));
                        },
                      ),
                    ),
                  ],
                )
              ],
            )),
          ),
        ));
  }
}
