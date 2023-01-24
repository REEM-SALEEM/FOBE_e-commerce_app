import 'package:finalproject/app/navigation%20items/profile/address/model/address_model.dart';
import 'package:finalproject/app/navigation%20items/profile/address/provider/address_prov.dart';
import 'package:finalproject/app/navigation%20items/profile/address/provider/profile_prov.dart';
import 'package:finalproject/app/navigation%20items/profile/address/view/address_form.dart';
import 'package:finalproject/app/utils/error_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressViewnAdd extends StatelessWidget {
  const AddressViewnAdd({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<AddressProvider>(context, listen: false)
          .getAllAddress(context);
    });
    return Consumer2<ProfileProvider, AddressProvider>(
      builder: (BuildContext context, value, value1, Widget? child) {
        return Scaffold(
          backgroundColor: const Color.fromARGB(255, 240, 237, 237),
          appBar: AppBar(
            backgroundColor: Colors.white,
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Expanded(
                  child: Consumer<AddressProvider>(
                    builder: (context, value, child) {
                      return value.addressList.isEmpty
                          ? const Center(child: Text('Add Address'))
                          : ListView.separated(
                              physics: const ScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                value.addressList[index]
                                                    .fullName,
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Container(
                                                height: 20,
                                                width: 50,
                                                decoration: BoxDecoration(
                                                    color: Colors.orange,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: Center(
                                                  child: Text(
                                                    value.addressType,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            value.addressList[index].address,
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                          Text(
                                            "PIN: ${value.addressList[index].pin}",
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                          Text(
                                            value.addressList[index].state,
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            value.addressList[index].phone,
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                          const SizedBox(height: 10),
                                          const Divider(
                                            color: Colors.black,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                        builder: (context) {
                                                          return AdressForm(
                                                            addressScreenCheck:
                                                                AddressScreen
                                                                    .editAddressScreen,
                                                            addressId: value
                                                                .addressList[
                                                                    index]
                                                                .id,
                                                          );
                                                        },
                                                      ),
                                                    );
                                                  },
                                                  child: const Text('Edit')),
                                              const VerticalDivider(
                                                color: Colors.black,
                                              ),
                                              TextButton(
                                                  onPressed: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AddressAlertWidget(
                                                            index: index);
                                                      },
                                                    );
                                                  },
                                                  child: const Text('Remove')),
                                            ],
                                          )
                                        ]),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  const SizedBox(),
                              itemCount: value.addressList.length);
                    },
                  ),
                ),
                SizedBox(
                    child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AdressForm(
                              addressScreenCheck:
                                  AddressScreen.addAddressScreen,
                              addressId: "",
                            ),
                          ));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          minimumSize: const Size.fromHeight(50),
                        ),
                        child: const Text(
                          '+ Add Address',
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                ))
              ],
            ),
          ),
        );
      },
    );
  }
}

class AddressAlertWidget extends StatelessWidget {
  const AddressAlertWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;
  @override
  Widget build(BuildContext context) {
    return Consumer<AddressProvider>(builder: (context, address, child) {
      return AlertDialog(
        title: const Text(
          'Remove Item',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text(
          'Are you sure want to delete address?',
          style: TextStyle(
            color: Color.fromARGB(255, 78, 77, 77),
            letterSpacing: 0.1,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          FittedBox(
            child: Row(
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'No',
                    style: TextStyle(
                      fontFamily: "Manrope",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    address.deleteAddress(
                      address.addressList[index].id,
                      context,
                    );
                    Navigator.of(context).pop();
                    SnackBarPop.popUp(
                        context, "Address Removed Successfully", Colors.red);
                    address.getAllAddress(context);
                  },
                  child: const Text(
                    'Yes',
                    style: TextStyle(
                      fontFamily: "Manrope",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      );
    });
  }
}
