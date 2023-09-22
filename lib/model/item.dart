// import 'package:get/get.dart';
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