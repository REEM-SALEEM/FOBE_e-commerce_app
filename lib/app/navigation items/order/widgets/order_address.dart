
import 'package:finalproject/app/navigation%20items/order/widgets/addresslist.dart';
import 'package:finalproject/app/navigation%20items/profile/address/provider/address_prov.dart';
import 'package:finalproject/app/navigation%20items/profile/address/view/address_add.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderAddressWidget extends StatelessWidget {
  const OrderAddressWidget({
    Key? key,
    required this.index,
    required this.value,
  }) : super(key: key);

  final int index;
  // final dynamic value;
  final AddressProvider value;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      child: Column(
        children: [
        AddressWidget(
                        name: value.addressList[value.selectIndex].fullName,
                        title: value.addressList[value.selectIndex].title,
                        address:
                            '''${value.addressList[value.selectIndex].address},
${value.addressList[value.selectIndex].state} - ${value.addressList[value.selectIndex].pin}
Land Mark - ${value.addressList[value.selectIndex].landMark}
''',
                        number: value.addressList[value.selectIndex].phone,
                        onPreesed: () {
                          Navigator.of(context).push(CupertinoPageRoute(
                            builder: (context) {
                              return const AddressViewnAdd();
                            },
                          ));
                        },
                      ),
          Container(
            padding: const EdgeInsets.only(left: 15, right: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: value.isLoading == true
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // kSize,
                      Row(
                        children: [
                          Text(
                            value.addressList[index].fullName.toUpperCase(),
                            style: const TextStyle(
                              fontFamily: "Manrope",
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          // kWidth,
                          Container(
                            height: 20,
                            width: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.black.withOpacity(0.3),
                            ),
                            child: Text(
                              value.addressList[index].title.toUpperCase(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontFamily: "Manrope",
                                fontSize: 14,
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.edit),
                              ),
                              IconButton(
                                onPressed: () {
                                  // value.deleteAddress(
                                  //     value.addressList[index].id, context);
                                },
                                icon: const Icon(
                                  Icons.delete,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Text(
                        value.addressList[index].address,
                        style: const TextStyle(
                          fontFamily: "Manrope",
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "PIN :${value.addressList[index].pin}, ",
                            style: const TextStyle(
                              fontFamily: "Manrope",
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            value.addressList[index].state,
                            style: const TextStyle(
                              fontFamily: "Manrope",
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        value.addressList[index].place,
                        style: const TextStyle(
                          fontFamily: "Manrope",
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                      // kSize,
                      Text(
                        value.addressList[index].phone,
                        style: const TextStyle(
                          fontFamily: "Manrope",
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                      // kSize,
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}