// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
//
// import '../model/item.dart';
//
//
//
// class Products extends GetxController {
//   RxList<Book> items = RxList<Book>();
//   RxList<Book> wishListItems = RxList<Book>();
//
//   Future<void> fetchDataFromJson() async {
//       final response = await http.get(Uri.parse(
//           'https://raw.githubusercontent.com/arakaneserohingya/Rhg_Books_Assets/main/rhghistoricalbooksjson'));
//
//       if (response.statusCode == 200) {
//         final List<dynamic> jsonData = json.decode(response.body);
//
//         items.assignAll(jsonData.map((data) => Book.fromJson(data)).toList());
//       } else {
//         throw Exception('Failed to load data');
//       }
//     }
//
//   void addItem(String productId) {
//     final product = items.firstWhere((element) => element.bookimageurl == productId);
//     if (!wishListItems.contains(product)) {
//       wishListItems.add(product);
//       product.inWishList.value = true;
//     }
//   }
//
//   void removeItem(String productId) {
//     final product =
//         items.firstWhere((element) => element.bookimageurl == productId);
//     if (wishListItems.contains(product)) {
//       wishListItems.remove(product);
//       product.inWishList.value = false;
//     }
//   }
// }
//
//
// class Book {
//   final String bookimageurl;
//   final String bookname;
//   final String bookdescription;
//   final String bookdownloadurl;
//
//   final RxBool inWishList;
//
//   Book({
//     required this.bookimageurl,
//     required this.bookname,
//     required this.bookdescription,
//     required this.bookdownloadurl, //required this.price
//   }) : inWishList = false.obs;
//
//   factory Book.fromJson(Map<String, dynamic> json) {
//     return Book(
//       bookimageurl: json['mImageUrls'],
//       bookname: json['mNames'],
//       bookdescription: json['mDescription'],
//       bookdownloadurl: json['mdwnurl'],
//
//     );
//   }
// }
// // // state/products.dart
// // import 'package:get/get.dart';
// // import 'dart:math';
// // import '../model/item.dart';
// //
// //
// // class Products extends GetxController {
// //   // All products
// //   // In production, these things usually be loaded them from API or database or something like that
// //   final RxList<Item> _items = List.generate(
// //       100,
// //           (index) => Item(
// //           bookimageurl: index,
// //           bookname: 'Product $index',
// //           price: Random().nextDouble() * 100,
// //           inWishList: false.obs)).obs;
// //
// //   // Use this to retrieve all products
// //   List<Item> get items {
// //     return [..._items];
// //   }
// //
// //   // This will return the products that were added to wish list
// //   List<Item> get wishListItems {
// //     return _items.where((item) => item.inWishList.value == true).toList();
// //   }
// //
// //   // Add an item to the wish list
// //   void addItem(int bookimageurl) {
// //     final int index = _items.indexWhere((item) => item.bookimageurl == bookimageurl);
// //     _items[index].inWishList.value = true;
// //   }
// //
// //   // Remove an item from the wish list
// //   void removeItem(int bookimageurl) {
// //     final int index = _items.indexWhere((item) => item.bookimageurl == bookimageurl);
// //     _items[index].inWishList.value = false;
// //   }
// // }
