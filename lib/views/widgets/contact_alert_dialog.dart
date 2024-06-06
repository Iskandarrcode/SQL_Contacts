import 'package:flutter/material.dart';
import 'package:iyun6/models/contact_model.dart';
import 'package:iyun6/services/contacts_local_database.dart';

// ignore: must_be_immutable
class ContactAlertDialog extends StatefulWidget {
  final ContactModel contactModel;
  late bool isDialog;
  ContactAlertDialog({
    super.key,
    required this.isDialog,
    required this.contactModel,
  });

  @override
  State<ContactAlertDialog> createState() => _ContactAlertDialogState();
}

class _ContactAlertDialogState extends State<ContactAlertDialog> {
  final ContactsLocalDatabase contactsLocalDatabase = ContactsLocalDatabase();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(147, 71, 97, 211),
      title: widget.isDialog
          ? const Text("Add Contact")
          : const Text("Edit Contact"),
      content: Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: nameController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                label: Text("Name"),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Input Name";
                }
                return null;
              },
            ),
            TextFormField(
              controller: phoneNumberController,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                label: Text("Phone Number"),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Input Phone Number";
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Bekor qilish"),
        ),
        ElevatedButton(
          onPressed: () {
            if (nameController.text.isNotEmpty &&
                phoneNumberController.text.isNotEmpty) {
              contactsLocalDatabase.addContact(
                name: nameController.text,
                phoneNumber: phoneNumberController.text,
              );
            }
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          ),
          child: const Text("Qo'shish"),
        )
      ],
    );
  }
}
