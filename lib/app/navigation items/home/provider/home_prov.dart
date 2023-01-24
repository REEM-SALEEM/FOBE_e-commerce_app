import 'dart:developer';
import 'package:finalproject/app/navigation%20items/home/model/carouselist_model.dart';
import 'package:finalproject/app/navigation%20items/home/model/categorylist_model.dart';
import 'package:finalproject/app/navigation%20items/home/model/productlist_model.dart';
import 'package:finalproject/app/navigation%20items/product/view/product_details_screen.dart';
import 'package:finalproject/app/services/carousel_services.dart';
import 'package:finalproject/app/services/category_services.dart';
import 'package:finalproject/app/services/products_services.dart';
import 'package:flutter/material.dart';

class HomeProv extends ChangeNotifier {
  HomeProv(context) {
    getCategory(context);
    getProduct(context);
    getCarousel(context);
  }

//-----------------------------------------------------*Get Categorylist
  bool isLoading = false;
  List<CategoryModel> categoryList = [];
  CategoryServices category = CategoryServices();

  final icons = [];
  void getCategory(context) async {
    isLoading = true;
    notifyListeners();
    await category.categoryUsers(context).then(
      (value) {
        if (value != null) {
          categoryList = value;
          notifyListeners();
          isLoading = false;
          notifyListeners();
        } else {
          isLoading = false;
          notifyListeners();
          return null;
        }
      },
    );
    isLoading = false;
    notifyListeners();
  }

//-----------------------------------------------------*Get productList
  List<ProductModel> productList = [];
  ProductServices product = ProductServices();

  void getProduct(context) async {
    log("message");
    isLoading = true;
    notifyListeners();
    await product.homeProducts(context).then((value) {
      if (value != null) {
        log("message");
        productList = value;
        notifyListeners();
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
        return null;
      }
    });
  }

//-----------------------------------------------------*Get Carousellist
  List<CarouselModel> carousalList = [];
  CarouselServices carousal = CarouselServices();

  void getCarousel(context) async {
    isLoading = true;
    notifyListeners();
    await carousal.carouselUsers(context).then((value) {
      if (value != null) {
        log('carousal no null');
        carousalList = value;
        notifyListeners();
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
        return null;
      }
    });
  }

//-----------------------------------------------------*Product Screen passing by id
  void toProductScreen(context, index) {
    Navigator.of(context)
        .pushNamed(ProvDetails.routeName, arguments: productList[index].id);
    log("argument passing: ${productList[index].id}");
    notifyListeners();
  }

  ProductModel findById(String id) {
    return productList.firstWhere((element) => element.id == id);
   
  }

//-----------------------------------------------------*Category Screen passing by id
  List<ProductModel> findByCategoryId(String categoryId) {
    return productList
        .where((element) => element.category.contains(categoryId))
        .toList();
  }

  CategoryModel findByName(String id) {
    return categoryList.firstWhere((element) => element.id == id);
  }

  List<ProductModel> findByCategoryIdin(String id) {
    return productList.where((element) => element.id.contains(id)).toList();
  }
}



 // List<CategoryModel> fromCategoryToProductView(String categoryId) {
  //   return categoryList
  //       .where((element) => element.id.contains(categoryId))
  //       .toList();
  // }
  // void fromCategoryToProductView(context, index) {
  //   Navigator.of(context)
  //       .pushNamed(ProductView.routeName, arguments: model[index].);
  // }
  //  void toProductScreen(context, index) {
  //   Navigator.of(context)
  //       .pushNamed(ProvDetails.routeName, arguments: wishList[index]);
  // }