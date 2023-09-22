import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import '../state/products.dart';
import 'wish_list_screen.dart';

void main() {
  runApp(GetMaterialApp(
    home: HomeScreen(),
  ));
}

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Products _p = Get.put(Products());
  bool isLoading = true; // Add a flag to track loading state
  @override
  void initState() {
    super.initState();
    // _p.fetchDataFromJson();
    _p.fetchDataFromJson(); // Fetch data when the app starts
    _p.loadWishListItems(); // Load favorite items from shared preferences
  }

  // Future<void> fetchDataFromJson() async {
  //   final response = await http.get(Uri.parse(
  //       'https://raw.githubusercontent.com/arakaneserohingya/Rhg_Books_Assets/main/rhghistoricalbooksjson'));
  //
  //   if (response.statusCode == 200) {
  //     final List<dynamic> jsonData = json.decode(response.body);
  //
  //     items.assignAll(jsonData.map((data) => Book.fromJson(data)).toList());
  //   } else {
  //     throw Exception('Failed to load data');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add to Favourite'),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),

          ///to show favourite  items
          InkWell(
            child: Container(
              width: 300,
              height: 80,
              color: Colors.teal,
              alignment: Alignment.center,
              child: Obx(() => Text(
                    'Wish List: ${_p.wishListItems.length}',
                    style: const TextStyle(fontSize: 28, color: Colors.white),
                  )),
            ),
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => WishListScreen())),
          ),

          const SizedBox(
            height: 30,
          ),
          // ListView.separated(
          //   itemCount: _p.items.length,
          //   itemBuilder: (context, index) {
          //     final product = _p.items[index];
          //     // return YourListItemWidget(product: product); // Replace with your list item widget
          //   },
          //   separatorBuilder: (context, index) {
          //     return SizedBox(height: 10); // Adjust the height as needed
          //   },
          // )

          Expanded(
            child: Obx(
              () => ListView.separated(
               // padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0), // Adjust vertical and horizontal gaps as needed

                itemCount: _p.items.length,
                itemBuilder: (context, index) {
                  final product = _p.items[index];
                  return Container(
                    // color: Colors.green,
                    // color: Colors.transparent,///using transparent color as bg
                    height: 175,
                    margin: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                    ),
                    alignment: Alignment.bottomLeft,
                    child: Stack(
                      children: <Widget>[
                        Container(
                          height: 180,
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            width: double.infinity,
                            height: 140,
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            decoration: BoxDecoration(
                              color: Colors.teal,
                             borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: 110,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width - 170,
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        child: Text(
                                          product.bookname,
                                          textAlign: TextAlign.start,
                                          overflow: TextOverflow.clip,
                                          maxLines: 2,
                                          style: const TextStyle(
                                            fontFamily: 'MyanmarTanGu',
                                            fontWeight: FontWeight.w500,
                                            fontStyle: FontStyle.normal,
                                            fontSize: 14,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        product.bookdescription,
                                        textAlign: TextAlign.start,
                                        overflow: TextOverflow.clip,
                                        style: const TextStyle(
                                          fontFamily: 'MyanmarTanGu',
                                          fontWeight: FontWeight.w500,
                                          fontStyle: FontStyle.normal,
                                          fontSize: 14,
                                          color: Colors.white,
                                        ),
                                        maxLines: 2,
                                      ),
                                      Spacer(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Card(
                        //   elevation: 20,
                        //   margin: const EdgeInsets.symmetric(
                        //       vertical: 0, horizontal: 10),
                           Container(
                            height: 150,
                            margin: const EdgeInsets.only(
                              left: 10,
                              right: 6,
                              top: 6,
                              bottom: 6,
                            ),
                            child: boookImage(product),
                            
                           /* CachedNetworkImage(
                              imageUrl: product.bookimageurl,
                              height: 130,
                              width: 100,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  color: Colors.white,
                                  height: 130,
                                  width: 100,
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),*/
                          ),
                        // ),
                        Positioned(
                          bottom: 10,
                          // Adjust this value as needed to position the favorite button
                          right: 10,
                          // Adjust this value as needed to position the favorite button
                          child: Obx(
                            () => IconButton(
                              onPressed: () {
                                if (product.inWishList.value == false) {
                                  _p.addItem(product.bookimageurl);
                                } else {
                                  _p.removeItem(product.bookimageurl);
                                }
                              },
                              icon: Icon(
                                Icons.favorite,
                                color: product.inWishList.value == false
                                    ? Colors.white
                                    : Colors.red,
                              ),
                            ),
                          ),
                        ),


                      ],
                    ),
                  );

               
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 10); // to add space between list item rows
                },

              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Products extends GetxController {
  RxList<Book> items = RxList<Book>();
  RxList<Book> wishListItems = RxList<Book>();

  Future<void> fetchDataFromJson() async {
    final response = await http.get(Uri.parse(
        'https://raw.githubusercontent.com/arakaneserohingya/Rhg_Books_Assets/main/rhghistoricalbooksjson'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);

      items.assignAll(jsonData.map((data) => Book.fromJson(data)).toList());
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> saveWishListItems() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final itemsToSave =
          wishListItems.map((item) => item.bookimageurl).toList();
      await prefs.setStringList('wishListItems', itemsToSave);
    } catch (e) {
      print('Error saving wishListItems: $e');
    }
  }

  Future<void> loadWishListItems() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedItems = prefs.getStringList('wishListItems') ?? [];
      wishListItems.assignAll(
        items.where((item) => savedItems.contains(item.bookimageurl)),
      );
    } catch (e) {
      print('Error loading wishListItems: $e');
    }
  }

  void addItem(String productId) {
    final product =
        items.firstWhere((element) => element.bookimageurl == productId);
    if (!wishListItems.contains(product)) {
      wishListItems.add(product);
      product.inWishList.value = true;
      saveWishListItems(); // Save the updated list of favorites
    }
  }

  void removeItem(String productId) {
    final product =
        items.firstWhere((element) => element.bookimageurl == productId);
    if (wishListItems.contains(product)) {
      wishListItems.remove(product);
      product.inWishList.value = false;
      saveWishListItems(); // Save the updated list of favorites
    }
  }
}

class Book {
  final String bookimageurl;
  final String bookname;
  final String bookdescription;
  final String bookdownloadurl;

  final RxBool inWishList;

  Book({
    required this.bookimageurl,
    required this.bookname,
    required this.bookdescription,
    required this.bookdownloadurl, //required this.price
  }) : inWishList = false.obs;

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      bookimageurl: json['mImageUrls'],
      bookname: json['mNames'],
      bookdescription: json['mDescription'],
      bookdownloadurl: json['mdwnurl'],
    );
  }
}
Widget boookImage(Book product) {
  return Hero(
    tag: product.bookimageurl,
    child: Container(
      height: 280,
      width: 100,

      decoration: BoxDecoration(

        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 6,
            blurRadius: 10,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          border: Border.all(
            color: Colors.white, // White border color
            width: 4, // Border width
          ),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(7),
            bottomRight: Radius.circular(7),
          ),
          child: CachedNetworkImage(
            imageUrl: product.bookimageurl,
            fit: BoxFit.fill,
            placeholder: (context, url) {
              // Use Shimmer as a placeholder
              return Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(),
              );
            },
            errorWidget: (context, url, error) =>
                Icon(Icons.error), // Add your own error widget
          ),
        ),
      ),
    ),
  );
}

