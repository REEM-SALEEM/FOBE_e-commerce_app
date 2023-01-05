
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/profile_prov.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 100),
          Consumer<ProfileProvider>(
            builder: (BuildContext context, value, Widget? child) {
              return Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: value.iconsprof[index],
                        title: Text(
                          value.title[index],
                          style: const TextStyle(color: Colors.black),
                        ),
                        trailing: value.buttonprof[index],
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: value.title.length),
              );
            },
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.black,
              disabledForegroundColor: Colors.grey,
              elevation: 20,
              minimumSize: const Size(350, 50),
            ),
            onPressed: () {
              Provider.of<ProfileProvider>(context, listen: false).logOut(context);
            },
            child: const Text('Log Out'),
          ),
        ],
      ),
    );
  }
}
