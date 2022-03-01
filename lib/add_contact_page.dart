import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_project_1/database/db_helper.dart';
import 'package:flutter_project_1/model/contact.dart';
import 'package:image_picker/image_picker.dart';

class AddContactPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("add new context"),
      ),
      body: const SingleChildScrollView(child: AddContactForm()),
    );
  }
}

class AddContactForm extends StatefulWidget {
  const AddContactForm({Key? key}) : super(key: key);

  @override
  _AddContactFormState createState() => _AddContactFormState();
}

class _AddContactFormState extends State<AddContactForm> {
  final _formkey = GlobalKey<FormState>();
  XFile? _file;
  late DbHelper _dbHelper;
  
  @override
  void initState(){
    _dbHelper=DbHelper();
  }
  @override
  Widget build(BuildContext context) {
    String? name;
    String? PhoneNumber;
    return Column(
      children: [
        Stack(children: [
          Image.asset(
            _file==null ? "assets/no_avatar.jpg" :_file!.path,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          Positioned(
            right: 8,
            bottom: 8,
            child: IconButton(
              onPressed:getFile,
              icon: Icon(Icons.camera_alt),
              color: Colors.white,
            ),
          ),
        ]),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: TextFormField(
                    decoration: const InputDecoration(hintText: "contact Name"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "name required";
                      }
                    },
                    onSaved: (Value) {
                      name = Value;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: TextFormField(
                    decoration: const InputDecoration(hintText: "phoneNumber"),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "phone number required";
                      }
                    },
                    onSaved: (Value) {
                      PhoneNumber = Value;
                    },
                  ),
                ),
                RaisedButton(
                  onPressed: () async {
                    if (_formkey.currentState!.validate()) {
                      _formkey.currentState!.save();
                      var contact=Contact(
                          name: name.toString(),
                          phonenumber: PhoneNumber.toString());
                     await _dbHelper.insertContacts(contact);
                      var snackBar = Scaffold.of(context).showSnackBar(
                        SnackBar(
                            duration: const Duration(milliseconds: 400),
                            content: Text("$name has been saved")),
                      );
                      snackBar.closed.then((value) => Navigator.pop(context));
                    }
                  },
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: Text("Submit"),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
  Future<void> getFile() async {
  
  var image=await ImagePicker().pickImage(source: ImageSource.camera);

  setState(() {
    _file=image;
  });
 }
}

