import 'package:flutter/material.dart';
import 'package:iyun6/models/contact_model.dart';
import 'package:iyun6/views/widgets/contact_alert_dialog.dart';

class CustomContactsWidget extends StatelessWidget {
  final ContactModel contact;
  final Function(ContactModel contact) onEdit;
  final Function(int id) onDelete;

  const CustomContactsWidget({
    super.key,
    required this.contact,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  color: Color(0xFFDDE0E5),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    contact.name,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    contact.phoneNumber,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                onPressed: () async {
                  final ContactModel? returnedContact = await showDialog(
                    context: context,
                    builder: (BuildContext context) => ContactAlertDialog(
                      isDialog: true,
                      contactModel:
                          ContactModel(id: 0, name: "", phoneNumber: ""),
                    ),
                  );
                  if (returnedContact != null) {
                    onEdit(returnedContact);
                  }
                },
                icon: const Icon(
                  Icons.edit,
                  color: Color.fromARGB(163, 33, 149, 243),
                ),
              ),
              IconButton(
                onPressed: () {
                  onDelete(contact.id);
                },
                icon: const Icon(
                  Icons.delete,
                  color: Color.fromARGB(188, 244, 67, 54),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
