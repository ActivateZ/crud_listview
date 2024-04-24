import 'package:flutter/material.dart';
import 'package:crud_display/crud.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  List<Crud> contacts = List.empty(growable: true);
  bool isEditing = false;
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("CRUD"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                  hintText: "Contact Name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ))),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: contactController,
              keyboardType: TextInputType.number,
              maxLength: 10,
              decoration: const InputDecoration(
                  hintText: "Contact Number",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ))),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (!isEditing)
                ElevatedButton(
                    onPressed: () {
                      //
                      String name = nameController.text.trim();
                      String contact = contactController.text.trim();
                      if (name.isNotEmpty && contact.isNotEmpty) {
                        setState(() {
                          nameController.text = '';
                          contactController.text = '';
                          contacts.add(Crud(name: name, contact: contact));
                        });
                      }
                      //
                    },
                    child: const Text('Save')),
                if (isEditing) // ตรวจสอบค่า isEditing แทน selectedIndex
                  ElevatedButton(
                    onPressed: () {
                      // Update logic
                      setState(() {
                        isEditing = false;
                        String name = nameController.text.trim();
                        String contact = contactController.text.trim();
                        nameController.text = '';
                        contactController.text = '';
                        contacts[selectedIndex].name = name;
                        contacts[selectedIndex].contact = contact;
                        selectedIndex = -1; // Reset isEditing
                      });
                    },
                    child: const Text('Update'),
                  ),
                  if (isEditing) // ตรวจสอบค่า isEditing แทน selectedIndex
                  ElevatedButton(
                    onPressed: () {
                      // Update logic
                      setState(() {
                        isEditing = false;
                        nameController.clear(); // Clear name text field
                        contactController.clear();
                      });
                    },
                    child: const Text('Cancel'),
                  ),
              ],
            ),
            const SizedBox(height: 30),
            contacts.isEmpty
                ? const Text(
                    "No Contact",
                    style: TextStyle(fontSize: 15),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: contacts.length,
                      itemBuilder: (context, index) => getRow(index),
                    ),
                  )
          ],
        ),
      ),
    );
  }

  Widget getRow(int index) {
    return Card(
      child: ListTile(
          leading: CircleAvatar(
            backgroundColor: index % 2 == 0 ? Colors.pink : Colors.blue,
            foregroundColor: Colors.white,
            child: Text(
              contacts[index].name[0],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                contacts[index].name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(contacts[index].contact),
            ],
          ),
          trailing: SizedBox(
            width: 70,
            child: Row(
              children: [
                InkWell(
                    onTap: (() {
                      //
                      setState(() {
                        nameController.text = contacts[index].name;
                        contactController.text = contacts[index].contact;
                        isEditing = true; // Set isEditing to true
                        selectedIndex = index;
                      });
                      //
                    }),
                    child: const Icon(Icons.edit)),
                InkWell(
                    onTap: (() {
                      //
                      setState(() {
                        contacts.removeAt(index);
                      });
                      //
                    }),
                    child: const Icon(Icons.delete)),
              ],
            ),
          )),
    );
  }
}
