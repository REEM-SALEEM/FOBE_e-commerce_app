import 'package:finalproject/app/navigation%20items/profile/about/aboutpop.dart';
import 'package:finalproject/app/navigation%20items/profile/address/provider/profile_prov.dart';
import 'package:finalproject/app/navigation%20items/profile/address/view/address_add.dart';
import 'package:finalproject/app/navigation%20items/profile/logout/logout_alert.dart';
import 'package:finalproject/app/navigation%20items/profile/orders/view/recent.dart';
import 'package:finalproject/app/navigation%20items/profile/shimmer/email.dart';
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
          'MY ACCOUNT',
          style: TextStyle(
              color: Color.fromARGB(255, 54, 52, 52),
              letterSpacing: 1,
              fontFamily: 'Teko-Medium',
              fontWeight: FontWeight.normal,
              fontSize: 25),
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
                  return value.savedName == null
                      ? const EmailShimmer()
                      : Row(children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.black,
                            child: value.savedName != null
                                ? Text(
                                    // '',
                                    value.savedName!
                                        .substring(0, 2)
                                        .toUpperCase(),
                                    style: const TextStyle(
                                        fontFamily: "PTSerif-Regular",
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
                                        // "",
                                        value.savedName!
                                            .substring(0,
                                                value.savedName!.indexOf('@'))
                                            .toUpperCase(),
                                        style: const TextStyle(
                                            fontFamily: "PTSerif-Regular",
                                            fontSize: 19,
                                            fontWeight: FontWeight.bold),
                                      )
                                    : const Text(''),
                                const SizedBox(height: 7),
                                value.savedName != null
                                    ? Text(
                                        value.savedName!,
                                        style: const TextStyle(
                                            fontFamily: "PTSerif-Regular",
                                            letterSpacing: .4,
                                            fontSize: 14,
                                            color: Color.fromARGB(
                                                255, 104, 103, 103)),
                                      )
                                    : const Text(''),
                                const SizedBox(height: 4),
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
              leading: Icon(Icons.add_location_alt_outlined,
                  color: Color.fromARGB(255, 105, 103, 103)),
              title: Text("Address",
                  style: TextStyle(
                    color: Colors.black,
                  )),
            ),
          ),
          const Divider(),
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const RecentScreen(),
              ));
            },
            child: ListTile(
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.black,
                size: 19,
              ),
              leading: SizedBox(
                width: 25,
                height: 30,
                child: Image.asset("assets/open-box.png"),
              ),
              title: const Text("Orders", style: TextStyle(color: Colors.black)),
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
          const SizedBox(
            height: 40,
          ),
          SizedBox(
            width: 400,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color.fromARGB(255, 63, 63, 63),
                side: const BorderSide(
                    color: Colors.red, width: 2),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return const LogoutAlertWidget();
                  },
                );
              },
              child: const Text(
                'LOG OUT',
                style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
                Text(
                  "V ",
                  style: TextStyle(
                      color: Color.fromARGB(255, 76, 74, 74), fontSize: 15),
                ),
                Text(
                  "1.0.0",
                  style: TextStyle(
                      color: Color.fromARGB(255, 76, 74, 74), fontSize: 13),
                ),
                SizedBox(height: 15)
              ]),
            ]),
          ),
          const SizedBox(height: 10),
        ]),
      ),
    );
  }
}
