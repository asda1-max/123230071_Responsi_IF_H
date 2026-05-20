import 'package:get/get.dart';
import '../models/product_model.dart';
import '../services/api_service.dart';

class ProductController extends GetxController {
  final ApiService _apiService = ApiService();
  
  var products = <Product>[].obs;
  var categories = <String>[].obs;
  var selectedCategory = RxnString();
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchInitialData();
  }

  Future<void> fetchInitialData() async {
    isLoading.value = true;
    try {
      final fetchedCategories = await _apiService.fetchCategories();
      final fetchedProducts = await _apiService.fetchProducts();
      categories.assignAll(fetchedCategories);
      products.assignAll(fetchedProducts);
    } catch (e) {
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchProductsByCategory(String? category) async {
    selectedCategory.value = category;
    isLoading.value = true;
    try {
      final fetchedProducts = category == null 
        ? await _apiService.fetchProducts()
        : await _apiService.fetchProductsByCategory(category);
      
      products.assignAll(fetchedProducts);
    } catch (e) {
    } finally {
      isLoading.value = false;
    }
  }
}
