import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class ProfileScreen extends GetView<AuthController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('My Profile', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 24)),
        backgroundColor: Colors.grey.shade50,
        elevation: 0,
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 32),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
              ),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.red.withOpacity(0.2),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Image.network(
                        'https://i.pravatar.cc/150?img=11',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            width: 100,
                            height: 100,
                            color: Colors.grey.shade200,
                            alignment: Alignment.center,
                            child: CircularProgressIndicator(
                              color: Colors.red.shade300,
                              strokeWidth: 2,
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) => 
                          Container(
                            width: 100,
                            height: 100,
                            color: Colors.grey.shade200,
                            child: const Icon(Icons.person, size: 50, color: Colors.grey),
                          ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.edit, size: 16, color: Colors.red.shade700),
                      const SizedBox(width: 4),
                      Text(
                        'Ganti Foto',
                        style: TextStyle(color: Colors.red.shade700, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 10,
                          spreadRadius: 2,
                          offset: const Offset(0, 4),
                        ),
                      ],
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Column(
                      children: [
                        const ListTile(
                          leading: Icon(Icons.person_outline, color: Colors.red),
                          title: Text('Nama', style: TextStyle(fontSize: 12, color: Colors.grey)),
                          subtitle: Text('Muhammad Abdurohim', style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500)),
                        ),
                        Divider(height: 1, color: Colors.grey.shade100, indent: 16, endIndent: 16),
                        const ListTile(
                          leading: Icon(Icons.badge_outlined, color: Colors.red),
                          title: Text('NIM', style: TextStyle(fontSize: 12, color: Colors.grey)),
                          subtitle: Text('123222222', style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500)),
                        ),
                        Divider(height: 1, color: Colors.grey.shade100, indent: 16, endIndent: 16),
                        Obx(() => ListTile(
                          leading: const Icon(Icons.alternate_email, color: Colors.red),
                          title: const Text('Username', style: TextStyle(fontSize: 12, color: Colors.grey)),
                          subtitle: Text(controller.username.value, style: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500)),
                        )),
                      ],
                    ),
                  ),
                  const SizedBox(height: 48),
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(27),
                          side: BorderSide(color: Colors.red.shade200),
                        ),
                        elevation: 0,
                      ),
                      onPressed: controller.logout,
                      child: const Text('Logout', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
