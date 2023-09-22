import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../state/products.dart';
import 'wish_list_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Products _p = Get.put(Products());

  @override
  void initState() {
    super.initState();
    _p.fetchDataFromJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kindacode.com'),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          InkWell(
            child: Container(
              width: 300,
              height: 80,
              color: Colors.red,
              alignment: Alignment.center,
              child: Obx(() => Text(
                'Wish List: ${_p.wishListItems.length}',
                style: const TextStyle(fontSize: 28, color: Colors.white),
              )),
            ),
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => WishListScreen())),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: Obx(
                  () => ListView.builder(
                itemCount: _p.items.length,
                itemBuilder: (context, index) {
                  final product = _p.items[index];
                  return Card(
                    key: ValueKey(product.id),
                    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    color: Colors.amber.shade300,
                    child: ListTile(
                      title: Text(product.name),
                      subtitle: Text("\$${product.price.toStringAsFixed(2)}"),
                      trailing: Obx(
                            () => IconButton(
                          onPressed: () {
                            if (product.inWishList.value == false) {
                              _p.addItem(product.id);
                            } else {
                              _p.removeItem(product.id);
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
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(GetMaterialApp(
    home: HomeScreen(),
  ));
}




















//
// // screens/home_screen.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../state/products.dart';
// import 'wish_list_screen.dart';
//
// class HomeScreen extends StatelessWidget {
//   // Instantiate our Products class using Get.put()
//   final Products _p = Get.put(Products());
//
//   HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Kindacode.com'),
//       ),
//       body: Column(
//         children: [
//           const SizedBox(
//             height: 20,
//           ),
//           // This button also shows you how many items in the wish list
//           // It lets you go to the WishListScreen
//           InkWell(
//             child: Container(
//               width: 300,
//               height: 80,
//               color: Colors.red,
//               alignment: Alignment.center,
//               // Use Obx(()=> to update Text() whenever _wishList.items.length is changed
//               child: Obx(() => Text(
//                 'Wish List: ${_p.wishListItems.length}',
//                 style: const TextStyle(fontSize: 28, color: Colors.white),
//               )),
//             ),
//             onTap: () => Navigator.push(context,
//                 MaterialPageRoute(builder: (context) => WishListScreen())),
//           ),
//
//           const SizedBox(
//             height: 20,
//           ),
//
//           Expanded(
//             // Display all products in home screen
//               child: ListView.builder(
//                   itemCount: _p.items.length,
//                   // List item widget
//                   itemBuilder: (context, index) {
//                     final product = _p.items[index];
//                     return Card(
//                       key: ValueKey(product.id),
//                       margin: const EdgeInsets.symmetric(
//                           vertical: 5, horizontal: 10),
//                       color: Colors.amber.shade300,
//                       child: ListTile(
//                         title: Text(product.name),
//                         subtitle: Text("\$${product.price.toStringAsFixed(2)}"),
//                         // Use Obx(()=> to update icon color when product.inWishList change
//                         trailing: Obx(() => IconButton(
//                           onPressed: () {
//                             if (product.inWishList.value == false) {
//                               _p.addItem(product.id);
//                             } else {
//                               _p.removeItem(product.id);
//                             }
//                           },
//                           icon: Icon(
//                             Icons.favorite,
//                             color: product.inWishList.value == false
//                                 ? Colors.white
//                                 : Colors.red,
//                           ),
//                         )),
//                       ),
//                     );
//                   })),
//         ],
//       ),
//     );
//   }
// }
