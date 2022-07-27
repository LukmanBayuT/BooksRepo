import 'package:asiaquest/services/api_service.dart';
import 'package:asiaquest/views/add_books.dart';
import 'package:asiaquest/views/details_book.dart';
import 'package:asiaquest/views/edit_books.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePages extends StatelessWidget {
  const HomePages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Books Homepages',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                  width: Get.width,
                  height: Get.height / 8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        'List Buku Yang Tersedia',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      SizedBox(
                        child: ElevatedButton(
                            onPressed: () {
                              Get.to(() => const AddBooks());
                            },
                            child: const Text(
                              'Tambahkan Buku',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )),
                      )
                    ],
                  )),
              SizedBox(
                height: Get.height / 1,
                child: FutureBuilder(
                  future: ApiServices().getBooksList(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      var data = snapshot.data;
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 50,
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(() => DetailsBook(id: data[index].id));
                                },
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(data[index].title),
                                        Row(
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  Get.to(() => EditBooks(
                                                      id: data[index].id));
                                                },
                                                icon: const Icon(Icons.edit)),
                                            IconButton(
                                                onPressed: () {
                                                  ApiServices().deleteBooks(
                                                      data[index].id);
                                                },
                                                icon: const Icon(Icons.delete)),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
