class Contact {
  int id;
  String name;
  String address;
  String phone;
  String description;
  String email;

  Contact(
      {this.id,
      this.name,
      this.phone,
      this.description,
      this.email,
      this.address});

  int get contactId => id;
  String get contactName => name;
  String get contactAddress => address;
  String get contactPhone => phone;
  String get contactDescription => description;
  String get contactEmail => email;

  factory Contact.fromJson(Map<String, dynamic> data) => new Contact(
        id: data["id"],
        name: data["name"],
        address: data["address"],
        phone: data["phone"],
        description: data["description"],
        email: data["email"],
      );

  Map<String, dynamic> toJSon() => {
        "id": id,
        "name": name,
        "phone": phone,
        "address": address,
        "description": description,
        "email": email,
      };
}
