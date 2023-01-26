import 'package:finalproject/app/navigation%20items/profile/about/aboutpop.dart';
import 'package:finalproject/app/navigation%20items/profile/address/provider/profile_prov.dart';
import 'package:finalproject/app/navigation%20items/profile/address/view/address_add.dart';
import 'package:finalproject/app/navigation%20items/profile/logout/logout_alert.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      ((timeStamp) {
        Provider.of<ProfileProvider>(context, listen: false)
            .getSavedData(context);
      }),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'My Account',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          Container(
            color: const Color.fromARGB(255, 217, 220, 220),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Consumer<ProfileProvider>(
                builder: (context, value, child) {
                  return Row(children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.black,
                      child: value.savedName != null
                          ? Text(
                              value.savedName!.substring(0, 2).toUpperCase(),
                              style: const TextStyle(
                                  fontSize: 35,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )
                          : const Text(''),
                    ),
                    const SizedBox(width: 20),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          value.savedName != null
                              ? Text(
                                  value.savedName!,
                                  style: const TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold),
                                )
                              : const Text(''),
                          const SizedBox(height: 8),
                          value.savedEmail != null
                              ? Text(
                                  value.savedEmail!,
                                  style: const TextStyle(
                                      letterSpacing: .4,
                                      fontSize: 13,
                                      color:
                                          Color.fromARGB(255, 104, 103, 103)),
                                )
                              : const Text(''),
                          const SizedBox(height: 4),
                          value.savedPhone != null
                              ? Text(
                                  value.savedPhone!,
                                  style: const TextStyle(
                                      letterSpacing: .1,
                                      fontSize: 15,
                                      color:
                                          Color.fromARGB(255, 104, 103, 103)),
                                )
                              : const Text(''),
                        ]),
                  ]);
                },
              ),
            ),
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const AddressViewnAdd(),
              ));
            },
            child: const ListTile(
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.black,
                size: 19,
              ),
              leading: Icon(Icons.location_city,
                  color: Color.fromARGB(255, 105, 103, 103)),
              title: Text("Address", style: TextStyle(color: Colors.black)),
            ),
          ),
          const Divider(),
          InkWell(
            onTap: () {
              aboutPopup(context);
            },
            child: const ListTile(
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.black,
                size: 19,
              ),
              leading: Icon(Icons.error_outline_outlined,
                  color: Color.fromARGB(255, 105, 103, 103)),
              title: Text("About", style: TextStyle(color: Colors.black)),
            ),
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
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.black,
                size: 19,
              ),
              leading: Icon(Icons.logout_outlined,
                  color: Color.fromARGB(255, 105, 103, 103)),
              title: Text("Log out", style: TextStyle(color: Colors.black)),
            ),
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              Text(
                "VERSION 1.0.1",
                style: TextStyle(
                    color: Color.fromARGB(255, 76, 74, 74), fontSize: 13),
              ),
              SizedBox(height: 15)
            ],
          ))
        ]),
      ),
    );
  }
}
