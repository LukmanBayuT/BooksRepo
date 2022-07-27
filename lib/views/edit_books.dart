import 'package:asiaquest/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditBooks extends StatefulWidget {
  EditBooks({Key? key, required this.id}) : super(key: key);

  String? id;

  @override
  State<EditBooks> createState() => _EditBooksState();
}

class _EditBooksState extends State<EditBooks> {
  TextEditingController bookCodeCont = TextEditingController();
  TextEditingController isbnCont = TextEditingController();
  TextEditingController titleCont = TextEditingController();
  TextEditingController desCont = TextEditingController();
  TextEditingController priceCont = TextEditingController();
  TextEditingController coverCont = TextEditingController();
  String dropdownvalue = 'Fantasy';

  var items = [
    'Fantasy',
    'Romance',
    'History',
    'Sci-Fi',
  ];

  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Buku',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildTitle('Book Code'),
            buildCard(bookCodeCont),
            buildTitle('ISBN'),
            buildCard(isbnCont),
            buildTitle('Title'),
            buildCard(titleCont),
            buildTitle('Description'),
            buildCard(desCont),
            buildTitle('Price'),
            buildCard(priceCont),
            buildTitle('Cover Yes / No'),
            buildCard(coverCont),
            buildTitle('Publish Date'),
            SizedBox(
              height: Get.height / 10,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('${date.year}/${date.month}/${date.day}'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                            onPressed: () async {
                              DateTime? newDate = await showDatePicker(
                                context: context,
                                initialDate: date,
                                firstDate: DateTime(2022),
                                lastDate: DateTime(2099),
                              );
                              if (newDate == null) return;
                              setState(() => date = newDate);
                            },
                            child: const Text('Pick Date')),
                      ],
                    )
                  ],
                ),
              ),
            ),
            buildTitle('Category'),
            SizedBox(
              width: Get.width / 1,
              height: Get.height / 10,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton(
                  alignment: AlignmentDirectional.topCenter,
                  value: dropdownvalue,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalue = newValue!;
                    });
                  },
                ),
              ),
            ),
            SizedBox(
              width: Get.width / 1.1,
              height: Get.height / 15,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.amber,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  onPressed: () {
                    if (bookCodeCont.text.isEmpty ||
                        isbnCont.text.isEmpty ||
                        titleCont.text.isEmpty ||
                        priceCont.text.isEmpty) {
                      Get.snackbar('Failed!', "Please Put Valid Information");
                    } else {
                      ApiServices().editBook(
                        widget.id!,
                        bookCodeCont.text,
                        isbnCont.text,
                        titleCont.text,
                        desCont.text,
                        dropdownvalue,
                        date.toString(),
                        priceCont.text,
                        coverCont.text,
                      );
                    }
                  },
                  child: const Text('Edit Buku')),
            ),
            const SizedBox(
              height: 60,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCard(TextEditingController cont) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SizedBox(
        width: Get.width / 1,
        height: Get.height / 10,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: cont,
            maxLines: 10,
            keyboardType: TextInputType.multiline,
            decoration: const InputDecoration.collapsed(
              hintText: 'Tulis Disini',
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTitle(String title) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
    );
  }
}
