import 'package:flutter/material.dart';
import 'package:iyun6/models/contact_model.dart';
import 'package:iyun6/services/contacts_local_database.dart';
import 'package:iyun6/views/widgets/contact_alert_dialog.dart';
import 'package:iyun6/views/widgets/costum_contact.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final ContactsLocalDatabase _contactDatabase = ContactsLocalDatabase();

  void editContact({required ContactModel contact}) async {
    await _contactDatabase.editContact(
      id: contact.id,
      newName: contact.name,
      newPhoneNumber: contact.phoneNumber,
    );
    setState(() {});
  }

  void deleteContact({required int id}) async {
    await _contactDatabase.deleteContact(id: id);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(152, 33, 149, 243),
        title: const Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.contacts,
                color: Color.fromARGB(255, 33, 61, 243),
              ),
              SizedBox(width: 10),
              Text(
                "Contacts",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return ContactAlertDialog(
                      contactModel: ContactModel(
                        id: 0,
                        name: "",
                        phoneNumber: "",
                      ),
                      isDialog: true);
                },
              ));
            },
            icon: const Icon(
              Icons.add,
              size: 25,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: _contactDatabase.getContacts(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<ContactModel>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError || !snapshot.hasData) {
                    return const Center(
                      child: Text('Error loading contacts'),
                    );
                  } else {
                    List<ContactModel> contactss = snapshot.data!;
                    contactss.sort((ContactModel a, ContactModel b) =>
                        a.name.compareTo(b.name));
                    return ListView.builder(
                      itemCount: contactss.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CustomContactsWidget(
                          contact: contactss[index],
                          onEdit: (ContactModel updatedContact) {
                            editContact(contact: updatedContact);
                          },
                          onDelete: (int id) {
                            deleteContact(id: id);
                          },
                        );
                      },
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }
}
