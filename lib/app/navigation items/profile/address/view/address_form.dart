import 'dart:developer';

import 'package:finalproject/app/navigation%20items/profile/address/model/address_model.dart';
import 'package:finalproject/app/navigation%20items/profile/address/provider/address_prov.dart';
import 'package:finalproject/app/navigation%20items/profile/address/widgets/button.dart';
import 'package:finalproject/app/navigation%20items/profile/address/widgets/textform.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdressForm extends StatelessWidget {
  AdressForm(
      {super.key, required this.addressScreenCheck, required this.addressId});
  final GlobalKey<FormState> formGlobalKey = GlobalKey<FormState>();
  final AddressScreen addressScreenCheck;
  final String addressId;
  static const routeAddressName = '/address_form';

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        Provider.of<AddressProvider>(context, listen: false)
            .setAddressScreen(addressScreenCheck, addressId, context);
      },
    );
    return Consumer<AddressProvider>(
      builder: (BuildContext context, value, Widget? child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.white,
              title: const Text(
          'ADD ADDRESS',
          style: TextStyle(
              color: Color.fromARGB(255, 94, 90, 90),
              letterSpacing: 1,
              fontFamily: 'Teko-Medium',
              fontWeight: FontWeight.normal,
              fontSize: 25),
        ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Form(
                key: formGlobalKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Textform(
                        hinttext: 'Full Name',
                        formconsl: const Icon(Icons.person),
                        controller: value.nameController,
                        validator: (name) => value.fullNameValidation(name),
                      ),
                      Textform(
                        hinttext: 'Phone Number',
                        formconsl: const Icon(Icons.phone),
                        controller: value.phoneController,
                        validator: (phone) => value.mobileValdation(phone),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Textform(
                              hinttext: 'PIN Code',
                              formconsl: const Icon(Icons.pin),
                              controller: value.pinController,
                              validator: (pin) => value.pincodeValdation(pin),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Textform(
                              hinttext: 'State',
                              formconsl: const Icon(Icons.public),
                              controller: value.stateController,
                              validator: (state) =>
                                  value.stateValidation(state),
                            ),
                          ),
                        ],
                      ),
                      Textform(
                        hinttext: 'Place',
                        formconsl: const Icon(Icons.place),
                        controller: value.placeController,
                        validator: (tre) => value.placeValidation(tre),
                      ),
                      Textform(
                        hinttext: 'Address',
                        formconsl: const Icon(Icons.contact_mail),
                        controller: value.addressController,
                        validator: (addr) => value.addressValidation(addr),
                      ),
                      Textform(
                        hinttext: 'LandMark',
                        formconsl: const Icon(Icons.flag),
                        controller: value.landmarkController,
                        validator: (landm) => value.landmarkValidation(landm),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Type of Address',
                                style: TextStyle(fontSize: 17)),
                            const SizedBox(height: 7),
                            Row(children: [
                              TypeButton(
                                icon: Icon(
                                  Icons.home,
                                  color: value.isSelected == true
                                      ? Colors.orange
                                      : Colors.black,
                                ),
                                onPressed: () {
                                  value.buttonSelection();
                                },
                                text: 'Home',
                                color: value.isSelected == true
                                    ? Colors.orange
                                    : Colors.black,
                                textColor: value.isSelected == true
                                    ? Colors.orange
                                    : Colors.black,
                                borderColor: value.isSelected == true
                                    ? Colors.orange
                                    : Colors.black,
                              ),
                              const SizedBox(width: 10),
                              TypeButton(
                                icon: Icon(
                                  Icons.apartment,
                                  color: value.isSelected == false
                                      ? Colors.orange
                                      : Colors.black,
                                ),
                                onPressed: () {
                                  value.buttonSelection();
                                },
                                text: 'Office',
                                color: value.isSelected == false
                                    ? Colors.orange
                                    : Colors.black,
                                textColor: value.isSelected == false
                                    ? Colors.orange
                                    : Colors.black,
                                borderColor: value.isSelected == false
                                    ? Colors.orange
                                    : Colors.black,
                              ),
                            ]),
                            const SizedBox(height: 18),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.black,
                                disabledForegroundColor: Colors.grey,
                                elevation: 20,
                                minimumSize: const Size(350, 50),
                                shadowColor: Colors.blueGrey,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                              ),
                              onPressed: () {
                                if (formGlobalKey.currentState!.validate()) {
                                  log(formGlobalKey.currentState!.toString());
                                  formGlobalKey.currentState!.save();
                                  value.saveAddress(
                                      context, addressScreenCheck, addressId);
                                }
                              },
                              child: const Text('Save Address'),
                            ),
                          ],
                        ),
                      ),
                    ]),
              ),
            ),
          ),
        );
      },
    );
  }
}
