// To parse this JSON data, do
//
//     final getBooks = getBooksFromJson(jsonString);

import 'dart:convert';

List<GetBooks> getBooksFromJson(String str) =>
    List<GetBooks>.from(json.decode(str).map((x) => GetBooks.fromJson(x)));

String getBooksToJson(List<GetBooks> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetBooks {
  GetBooks({
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

  factory GetBooks.fromJson(Map<String, dynamic> json) => GetBooks(
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
