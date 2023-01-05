import 'package:finalproject/app/navigation%20items/home/model/categorylist_model.dart';
import 'package:finalproject/app/navigation%20items/home/model/productlist_model.dart';
import 'package:finalproject/app/services/category_service.dart';
import 'package:finalproject/app/services/products_servicecs.dart';
import 'package:flutter/material.dart';

class HomeProv extends ChangeNotifier {
  HomeProv(context) {
    getCategory(context);
    getProduct(context);
    // getProduct(context);
  }

//----------------------------------*Get Categorylist
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

//----------------------------------*Get productList
  List<ProductModel> productList = [];
  ProductServices product = ProductServices();
  void getProduct(context) async {
    isLoading = true;
    notifyListeners();
    await product.homeProducts(context).then((value) {
      if (value != null) {
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
//----------------------------------*Get Carousellist
  // List<CarousalModel> carousalList = [];
  // CarousalService carousal = CarousalService();
  //  void getCarousel(context) async {
  //   isLoading = true;
  //   notifyListeners();
  //   await carousal.homeCarousel(context).then((value) {
  //     if (value != null) {
  //       log('carousal no null');
  //       carousalList = value;
  //       notifyListeners();
  //       isLoading = false;
  //       notifyListeners();
  //     } else {
  //       isLoading = false;
  //       notifyListeners();
  //       return null;
  //     }
  //   });
  // }
  //------------------------------------------
  final urlimages = [
    Image.network(
        "https://images.pexels.com/photos/213780/pexels-photo-213780.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
    Image.network(
        "https://images.pexels.com/photos/2899097/pexels-photo-2899097.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
    Image.network(
        "https://images.pexels.com/photos/2820884/pexels-photo-2820884.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
  ];
  // List<String> items = [
  //   'https://m.media-amazon.com/images/I/71yzJoE7WlL._AC_UY327_FMwebp_QL65_.jpg',
  //   'https://m.media-amazon.com/images/I/81lnKynSaqL._AC_UY327_FMwebp_QL65_.jpg',
  //   'https://m.media-amazon.com/images/I/81-fFXQdPTL._AC_UY327_FMwebp_QL65_.jpg',
  //   'https://m.media-amazon.com/images/I/71AvQd3VzqL._AC_UY327_FMwebp_QL65_.jpg',
  // ];
  List caritems = [
    Image.asset('assets/Carousel2.jpg'),
    Image.asset('assets/b16c168ebffe4b25344d66b83f5abbfb.jpg'),
  ];

  List items = [
    Image.asset('assets/Swa1.webp'),
    Image.asset('assets/5610472_png.webp'),
    Image.asset('assets/5610472_png.webp'),
    Image.asset(
        'assets/pocket-watch--silver-tone--stainless-steel-swarovski-5615855.jpg'),
  ];
  List<String> items1 = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcROEy6HFi9g3cF8EttxQpGM0juTIVLAhhxAbQ&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT2ueq9b3-C9p-BzUtfeaE5MCsrwSG1R751zQ&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQjJEY_JtGFkmuwMl-T-MpMFSbBtU8cWmah1w&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRm5N931d5WVvluRD3SygGFKlkUWZpokJ37FA&usqp=CAU',
    'https://img2.junaroad.com/stories/story_p_63a390baadb8b82d0e0f299b-1671673435.jpeg',
    'https://img2.junaroad.com/stories/story_p_63870c45adb8b82d0eece6da-1671739758.jpeg',
  ];
}
