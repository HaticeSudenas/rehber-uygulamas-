class Contact {
  int? id;
  late String name;
  late String phonenumber;

  static List<Contact> contacts = [
    Contact(name: "DALİ", phonenumber: "0555 666 7766"),
    Contact(name: "AHMET", phonenumber: "0555 656 7766"),
    Contact(name: "AYŞE", phonenumber: "0555 660 7736"),
    Contact(name: "ALİ", phonenumber: "0555 666 7766"),
    Contact(name: "NUR", phonenumber: "0555 666 7766"),
    Contact(name: "FATMA", phonenumber: "0555 666 7266"),
    Contact(name: "ZEHRA", phonenumber: "0545 666 7166"),
    Contact(name: "SAHRA", phonenumber: "0575 666 7786"),
    Contact(name: "TUNA", phonenumber: "0595 666 7796"),
    Contact(name: "SUDE", phonenumber: "0505 666 7706"),
    Contact(name: "MEHMET", phonenumber: "0515 666 7756"),
    Contact(name: "ELİF", phonenumber: "0535 666 7716"),
    Contact(name: "ZEYNEP", phonenumber: "0595 666 7776"),
  ];
  Contact({required this.name,required this.phonenumber});

  Map<String,dynamic> toMap(){
    var map=Map<String,dynamic>();
    map["name"]=name;
    map["phone_number"]=phonenumber;
    return map;
  }
  Contact.fromMap(Map<String,dynamic> map){
        id=map["id"];
        name=map["name"];
        phonenumber=map["phone_number"];

  }
}