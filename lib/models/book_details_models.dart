// To parse this JSON data, do
//
//     final booksDetails = booksDetailsFromJson(jsonString);

import 'dart:convert';

BooksDetails booksDetailsFromJson(String str) =>
    BooksDetails.fromJson(json.decode(str));

String booksDetailsToJson(BooksDetails data) => json.encode(data.toJson());

class BooksDetails {
  BooksDetails({
    this.code,
    this.isbn,
    this.title,
    this.description,
    this.category,
    this.date,
    this.price,
    this.cover,
    this.id,
  });

  final String? code;
  final String? isbn;
  final String? title;
  final String? description;
  final String? category;
  final String? date;
  final String? price;
  final String? cover;
  final String? id;

  factory BooksDetails.fromJson(Map<String, dynamic> json) => BooksDetails(
        code: json["code"],
        isbn: json["isbn"],
        title: json["title"],
        description: json["description"],
        category: json["category"],
        date: json["date"],
        price: json["price"],
        cover: json["cover"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "isbn": isbn,
        "title": title,
        "description": description,
        "category": category,
        "date": date,
        "price": price,
        "cover": cover,
        "id": id,
      };
}
