import 'dart:developer';
import 'package:finalproject/app/navigation%20items/profile/address/model/address_model.dart';
import 'package:finalproject/app/navigation%20items/profile/address/model/addressget_model.dart';
import 'package:finalproject/app/navigation%20items/profile/address/view/address_form.dart';
import 'package:finalproject/app/services/address_services.dart';
import 'package:finalproject/app/utils/error_snackbar.dart';
import 'package:flutter/material.dart';

class AddressProvider extends ChangeNotifier {
  AddressProvider(context) {
    getAllAddress(context);
  }
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController pinController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController placeController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController landmarkController = TextEditingController();

  bool isLoading = false;
  bool isLoading2 = false;
  bool isSelected = true;
  bool isOfficeSelected = false;

  List<GetAddressModel> addressList = [];
  String addressType = 'Home';

  Future<String?> getAllAddress(context) async {
    isLoading = true;
    notifyListeners();
    await AddressService().getAddress(context).then((value) {
      if (value != null) {
        log(value.toString());
        addressList = value;
        notifyListeners();
        isLoading = false;
        notifyListeners();
        // return 'Done';
      } else {
        isLoading = false;
        notifyListeners();
        return null;
      }
    });
    return null;
  }

  void addAddress(context) async {
    isLoading2 = true;
    notifyListeners();
    final CreateAddressModel model = CreateAddressModel(
      title: addressType,
      fullName: nameController.text,
      phone: phoneController.text,
      pin: pinController.text,
      state: stateController.text,
      place: placeController.text,
      address: addressController.text,
      landMark: landmarkController.text,
    );

    await AddressService().addAddress(model, context).then((value) {
      if (value != null) {
        log('hai');
        clearAllControllers();
        Navigator.of(context).pop();
        SnackBarPop.popUp(context, 'Address added successfully', Colors.green);
        isLoading2 = false;
        getAllAddress(context);
        notifyListeners();
      } else {
        isLoading2 = false;
        notifyListeners();
      }
    });
    return null;
  }

  void saveAddress(context, AddressScreen addressScreenCheck, String id) {
    if (addressScreenCheck == AddressScreen.addAddressScreen) {
      addAddress(context);
      notifyListeners();
    } else {
      updateAddress(id, context);
      Navigator.pop(context);
      getAllAddress(context);
      notifyListeners();
    }
  }

  void setAddressScreen(
      AddressScreen addressScreenCheck, String? addressId, context) async {
    if (addressScreenCheck == AddressScreen.addAddressScreen) {
      clearAllControllers();
    } else {
      await AddressService()
          .getSingleAddress(context, addressId!)
          .then((value) {
        if (value != null) {
          nameController.text = value.fullName;
          phoneController.text = value.phone;
          pinController.text = value.pin;
          stateController.text = value.state;
          placeController.text = value.place;
          addressController.text = value.address;
          landmarkController.text = value.landMark;
          notifyListeners();
          value.title == "Home" ? isSelected = true : isSelected = false;
          notifyListeners();
        }
      });
    }
  }

  void updateAddress(String addressId, context) async {
    isLoading2 = true;
    notifyListeners();
    final CreateAddressModel model = CreateAddressModel(
      title: addressType,
      fullName: nameController.text,
      phone: phoneController.text,
      pin: pinController.text,
      state: stateController.text,
      place: placeController.text,
      address: addressController.text,
      landMark: landmarkController.text,
    );
    await AddressService()
        .updateAddress(model, addressId, context)
        .then((value) {
      if (value != null) {
        clearAllControllers();
        getAllAddress(context);
        notifyListeners();
        isLoading2 = false;
        notifyListeners();
      } else {
        isLoading2 = false;
        notifyListeners();
      }
    });
    return null;
  }

  void deleteAddress(String addressId, context) async {
    isLoading2 = true;
    notifyListeners();
    log('delete function entered');
    await AddressService().deleteAddress(addressId, context).then((value) {
      if (value != null) {
        isLoading2 = false;
        notifyListeners();
      } else {
        return;
      }
    });
  }

  void buttonSelection() {
    isSelected = !isSelected;
    notifyListeners();
    isSelected == true ? addressType = 'Home' : addressType = 'Office';
    log(addressType);
    notifyListeners();
  }

  String? fullNameValidation(String? value) {
    if (value!.isEmpty) {
      return 'Please enter the username';
    } else if (value.length < 2) {
      return 'Too short username';
    } else {
      return null;
    }
  }

  String? mobileValdation(String? value) {
    if (value!.isEmpty) {
      return 'Please enter your mobile number';
    } else if (value.length < 10) {
      return 'Invalid mobile number,make sure your entered 10 digits';
    } else {
      return null;
    }
  }

  String? pincodeValdation(String? value) {
    if (value!.isEmpty) {
      return 'Please enter your PIN number';
    } else if (value.length < 6) {
      return 'Invalid Pin No';
    } else {
      return null;
    }
  }

  String? stateValidation(String? value) {
    if (value!.isEmpty) {
      return 'Please enter the state';
    } else {
      return null;
    }
  }

  String? placeValidation(String? value) {
    if (value!.isEmpty) {
      return 'Please enter the state';
    } else {
      return null;
    }
  }

  String? addressValidation(String? value) {
    if (value!.isEmpty) {
      return 'Please enter the state';
    } else {
      return null;
    }
  }

  String? landmarkValidation(String? value) {
    if (value!.isEmpty) {
      return 'Please enter the state';
    } else {
      return null;
    }
  }

  void pop(context) {
    Navigator.of(context).pop();
    notifyListeners();
  }

  void clearAllControllers() {
    nameController.clear();
    addressType = "Home";
    pinController.clear();
    stateController.clear();
    placeController.clear();
    addressController.clear();
    phoneController.clear();
    landmarkController.clear();
  }

  GetAddressModel findById(String id) {
    return addressList.firstWhere((element) => element.id == id);
  }
}
