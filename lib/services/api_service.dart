// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:asiaquest/models/book_details_models.dart';
import 'package:asiaquest/models/booklist_models.dart';
import 'package:asiaquest/views/finished.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  Future<List<GetBooks>> getBooksList() async {
    var request = http.Request(
        'GET', Uri.parse('https://62e0f302fa8ed271c48aaddf.mockapi.io/Books'));

    http.StreamedResponse response = await request.send();

    var bookData = await response.stream.bytesToString();
    var decodeBook = jsonDecode(bookData);

    if (response.statusCode == 200) {
      print(decodeBook);
    } else {
      print(response.reasonPhrase);
    }
    return getBooksFromJson(bookData);
  }

  Future<BooksDetails> getBooksId(String id) async {
    var request = http.Request('GET',
        Uri.parse('https://62e0f302fa8ed271c48aaddf.mockapi.io/Books/$id'));

    http.StreamedResponse response = await request.send();

    var bookDetails = await response.stream.bytesToString();
    var decodeBooks = jsonDecode(bookDetails);

    if (response.statusCode == 200) {
      print(decodeBooks);
    } else {
      print(response.reasonPhrase);
    }
    return booksDetailsFromJson(bookDetails);
  }

  Future<BooksDetails> postBooks(
    String code,
    isbn,
    title,
    des,
    cat,
    date,
    price,
    cover,
  ) async {
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var request = http.Request(
        'POST', Uri.parse('https://62e0f302fa8ed271c48aaddf.mockapi.io/Books'));
    request.bodyFields = {
      'code': code,
      'isbn': isbn,
      'title': title,
      'description': des,
      'category': cat,
      'date': date,
      'price': price,
      'cover': cover,
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    var booksDetails = await response.stream.bytesToString();
    var decodeBooks = jsonDecode(booksDetails);

    if (response.statusCode == 200) {
      print(decodeBooks);
      Get.to(() => const Finished());
    } else {
      print(response.reasonPhrase);
      Get.to(() => const Finished());
    }
    return booksDetailsFromJson(booksDetails);
  }

  Future<BooksDetails> editBook(
    String id,
    code,
    isbn,
    title,
    des,
    cat,
    date,
    price,
    cover,
  ) async {
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var request = http.Request('PUT',
        Uri.parse('https://62e0f302fa8ed271c48aaddf.mockapi.io/Books/$id'));
    request.bodyFields = {
      'code': code,
      'isbn': isbn,
      'title': title,
      'description': des,
      'category': cat,
      'date': date,
      'price': price,
      'cover': cover,
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var booksDetails = await response.stream.bytesToString();
    var decodeBooks = jsonDecode(booksDetails);

    if (response.statusCode == 200) {
      print(decodeBooks);
      Get.to(() => const Finished());
    } else {
      print(response.reasonPhrase);
    }
    return booksDetailsFromJson(decodeBooks);
  }

  Future<BooksDetails> deleteBooks(String id) async {
    var request = http.Request('DELETE',
        Uri.parse('https://62e0f302fa8ed271c48aaddf.mockapi.io/Books/$id'));

    http.StreamedResponse response = await request.send();
    var bookDetails = await response.stream.bytesToString();
    var bookDecode = jsonDecode(bookDetails);

    if (response.statusCode == 200) {
      print(bookDecode);
      Get.to(() => const Finished());
    } else {
      print(response.reasonPhrase);
    }
    return booksDetailsFromJson(bookDetails);
  }
}
