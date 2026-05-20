import 'package:get/get.dart';
import '../models/product_model.dart';
import '../services/api_service.dart';
import '../services/session_service.dart';

class CartController extends GetxController {
  final ApiService _apiService = ApiService();
  final SessionService _sessionService = SessionService();
  
  var cartItems = <Product>[].obs;
  var cartIds = <int>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadCart();
  }

  Future<void> loadCart() async {
    isLoading.value = true;
    try {
      final ids = await _sessionService.getCartIds();
      cartIds.assignAll(ids);
      
      List<Product> products = [];
      for (int id in ids) {
        final product = await _apiService.fetchProductById(id);
        products.add(product);
      }
      cartItems.assignAll(products);
    } catch (e) {
    } finally {
      isLoading.value = false;
    }
  }

  bool isInCart(int productId) {
    return cartIds.contains(productId);
  }

  Future<void> toggleCart(int productId) async {
    if (isInCart(productId)) {
      await _sessionService.removeFromCart(productId);
      cartIds.remove(productId);
      cartItems.removeWhere((p) => p.id == productId);
      Get.snackbar('Cart', 'Removed from cart', snackPosition: SnackPosition.BOTTOM, duration: const Duration(seconds: 1));
    } else {
      await _sessionService.addToCart(productId);
      cartIds.add(productId);
      Get.snackbar('Cart', 'Added to cart', snackPosition: SnackPosition.BOTTOM, duration: const Duration(seconds: 1));
    }
  }
}
