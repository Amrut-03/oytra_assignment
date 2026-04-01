import 'package:get/get.dart';
import 'package:oytra_app/data/models/product.dart';
import 'package:oytra_app/data/services/api_services.dart';

class OrderController extends GetxController {
  var products = <Product>[].obs;
  var selectedProduct = Rxn<Product>();
  var quantity = 0.obs;
  var customerType = "Retail".obs;

  var totalPrice = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();

    everAll([selectedProduct, quantity, customerType], (_) {
      calculatePrice();
    });
  }

  void fetchProducts() async {
    products.value = await ProductService.fetchProducts();
  }

  void calculatePrice() {
    if (selectedProduct.value == null || quantity.value == 0) {
      totalPrice.value = 0;
      return;
    }

    double base = selectedProduct.value!.price;

    if (customerType.value == 'Dealer') {
      base *= 0.8;
    }

    totalPrice.value = base * quantity.value;
  }

  String validateMOQ() {
    if (quantity.value < selectedProduct.value!.moq) {
      return "Minimum order is ${selectedProduct.value!.moq}";
    }
    return "";
  }
}