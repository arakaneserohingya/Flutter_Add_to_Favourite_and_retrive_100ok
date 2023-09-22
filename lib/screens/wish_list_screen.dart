// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../state/products.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class WishListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Products _p = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: Text('Wish List'),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: Obx(
                  () => ListView.builder(
                itemCount: _p.wishListItems.length,
                itemBuilder: (context, index) {
                  final product = _p.wishListItems[index];
                  return ListTile(
                    title: Text(product.name),
                    subtitle: Text("\$${product.price.toStringAsFixed(2)}"),
                    trailing: IconButton(
                      onPressed: () {
                        _p.removeItem(product.id);
                      },
                      icon: Icon(
                        Icons.favorite,
                        color: Colors.red,
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


// // screens/wish_list_screen.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../state/products.dart';
//
// class WishListScreen extends StatelessWidget {
//   // Ask Get to find our "controller"
//   final Products _p = Get.find<Products>();
//
//   WishListScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('WishList'),
//         ),
//         body: Obx(
//               () => ListView.builder(
//             itemCount: _p.wishListItems.length,
//             itemBuilder: (context, index) {
//               final item = _p.wishListItems[index];
//               return Card(
//                 key: ValueKey(item.id),
//                 margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//                 color: Colors.blue[200],
//                 child: ListTile(
//                   title: Text(item.name),
//                   subtitle: Text(item.price.toStringAsFixed(2)),
//                   // This button use to remove )the item from wish list
//                   trailing: IconButton(
//                     icon: const Icon(Icons.close),
//                     onPressed: () {
//                       item.inWishList.value = false;
//                       _p.removeItem(item.id);
//                     },
//                   ),
//                 ),
//               );
//             },
//           ),
//         ));
//   }
// }