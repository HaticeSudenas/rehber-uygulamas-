import 'package:flutter/material.dart';
import 'package:flutter_project_1/database/db_helper.dart';
import 'package:url_launcher/url_launcher.dart';
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
              MaterialPageRoute(builder: (context) => AddContactPage(contact: Contact(name: "",phonenumber: ""),)));
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
              return GestureDetector(
                onTap: () async{
                  await Navigator.push(context, MaterialPageRoute(builder:(context)=>AddContactPage(contact: contact,)));
                  setState(() {});
                },
                child: Dismissible(
                  key:UniqueKey(),
                  direction:DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Icon(Icons.delete,color: Colors.white,size: 35,),
                    ),
                    color: Colors.red,
                    ),
                  onDismissed: (direction) async {
                    _dbHelper.removeContacts(contact.id!);
                    setState(() {});
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text("${contact.name} is have delected"),
                      action: SnackBarAction(
                        label: "UNDO",
                        onPressed: () async{
                          _dbHelper.insertContacts(contact);
                          setState(() {});
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
                    trailing: IconButton(icon: Icon(Icons.phone),onPressed: () async=>_callContact(contact.phonenumber),),
                  ),
                ),
              );
            });
         },),
      ),
    );
  }
}
_callContact(String PhoneNumber) async{
  String tel="tel:$PhoneNumber";  
 // if(await canLaunch(tel)){
  // await launch(tel);
 // } 
}
