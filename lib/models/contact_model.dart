class ContactModel {
  final int id;
  String name;
  String phoneNumber;

  ContactModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
  });

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      id: json["id"],
      name: json["name"],
      phoneNumber: json["phoneNumber"],
    );
  }
}
