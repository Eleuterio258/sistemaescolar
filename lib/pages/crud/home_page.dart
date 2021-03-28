import 'package:flutter/material.dart';
import 'package:sistema_escolar/helpers/database_helper.dart';
import 'package:sistema_escolar/helpers/synchronization_data.dart';
import 'package:sistema_escolar/models/contact.dart';
import 'package:sistema_escolar/pages/crud/add.dart';
import 'package:sistema_escolar/pages/crud/details.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:sistema_escolar/pages/Listar.dart';




class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future isInternet() async {
    await SynchronizationData.isInternet().then((conection) {
      if (conection) {
        print("internet connection available..");
      } else {
        Get.snackbar('Error', 'No internet..');
      }
    });
  }

  var db = new DatabaseHelper();
  List contacto;
  bool isLload = false;
  Future contactoList() async {
    contacto = await db.finfAll();
    setState(() {
      isLload = true;
    });
  }

  Future synToMysql() async {
    await SynchronizationData().fechAllsInfo().then((contactoList) async {
      EasyLoading.show(status: "Do not close the app. we are synchronizing..");
      await SynchronizationData().savetoMysl(contactoList);
      EasyLoading.showSuccess("Data synchronized successfully");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SQLITE"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddPage(),
                ),
              );
            },
            icon: Icon(Icons.add),
          ),
            IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Listar(),
                ),
              );
            },
            icon: Icon(Icons.no_flash),
          ),
          IconButton(
            onPressed: () async {
              await SynchronizationData.isInternet().then(
                (conection) {
                  if (conection) {
                    synToMysql();
                    print("internet available");
                  } else {
                    Get.snackbar('error', 'Error');
                  }
                },
              );
            },
            icon: Icon(Icons.refresh_sharp),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: FutureBuilder<List>(
          future: db.finfAll(),
          builder: (context, AsyncSnapshot<List> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  Contact contact = Contact.fromJson(snapshot.data[index]);
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(
                          contact.name.toString().substring(1, 2).toUpperCase(),
                        ),
                      ),
                      title: Text(contact.name),
                      subtitle: Text(contact.phone),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ContactDetailsPage(
                                contact: contact,
                              ),
                            ));
                      },
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
