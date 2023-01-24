import 'package:finalproject/app/navigation%20items/profile/address/view/address_add.dart';
import 'package:finalproject/app/navigation%20items/profile/logout/logout_alert.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../address/provider/profile_prov.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 60),
            const Text(
              'Profile',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const ListTile(
              leading: Icon(Icons.person),
              title: Text("Gender", style: TextStyle(color: Colors.black)),
            ),
            const Divider(),
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const AddressViewnAdd(),
                ));
              },
              child: const ListTile(
                leading: Icon(Icons.location_city),
                title: Text("Address", style: TextStyle(color: Colors.black)),
              ),
            ),
            const Divider(),
            const ListTile(
              leading: Icon(Icons.email),
              title: Text("Email", style: TextStyle(color: Colors.black)),
            ),
            const Divider(),
            const ListTile(
              leading: Icon(Icons.phone_android_outlined),
              title:
                  Text("Phone number", style: TextStyle(color: Colors.black)),
            ),
            const Divider(),
            const ListTile(
              leading: Icon(Icons.lock),
              title: Text("change password",
                  style: TextStyle(color: Colors.black)),
            ),
            const Divider(),
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return const LogoutAlertWidget();
                  },
                );
              },
              child: const ListTile(
                leading: Icon(Icons.logout_outlined),
                title: Text("Log out", style: TextStyle(color: Colors.black)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
