import 'package:flutter/material.dart';
import 'package:flutter_project_1/database/db_helper.dart';

import 'add_contact_page.dart';
import 'model/contact.dart';

class ContactPage extends StatefulWidget {
  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  late List<Contact> contacts;
  late DbHelper _dbHelper;
  @override
  void initState() {
    contacts = Contact.contacts;
    _dbHelper=DbHelper();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Contact.contacts
        .sort((Contact a, Contact b) => a.name[0].compareTo(b.name[0]));
    return Scaffold(
      appBar: AppBar(
        title: const Text("PHONE BOOK"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddContactPage()));
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: 
        FutureBuilder(
          future: _dbHelper.getContacts(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) { 
            if(!snapshot.hasData) return CircularProgressIndicator();
            if(snapshot.data.isEmpty) return Text("your contact is empty");
          return ListView.builder(
            itemCount:snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              Contact contact = snapshot.data[index];
              return Dismissible(
                key: Key(contact.name),
                onDismissed: (direction) {
                  setState(() {
                    contacts.removeAt(index);
                  });
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text("${contact.name} is have delected"),
                    action: SnackBarAction(
                      label: "UNDO",
                      onPressed: () {
                        setState(() {
                          contacts.add(contact);
                        });
                      },
                    ),
                  ));
                },
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text(
                      contact.name[0],
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  title: Text(contact.name),
                  subtitle: Text(contact.phonenumber),
                ),
              );
            });
         },),
      ),
    );
  }
}
