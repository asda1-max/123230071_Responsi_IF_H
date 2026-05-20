import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/main_controller.dart';
import 'home_screen.dart';
import 'cart_screen.dart';
import 'profile_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize MainController
    final MainController controller = Get.put(MainController());

    final List<Widget> widgetOptions = <Widget>[
      const HomeScreen(),
      const CartScreen(),
      const ProfileScreen(),
    ];

    return Obx(() => Scaffold(
      backgroundColor: Colors.white,
      body: widgetOptions.elementAt(controller.selectedIndex.value),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            activeIcon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: controller.selectedIndex.value,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        onTap: controller.changeTabIndex,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
    ));
  }
}
