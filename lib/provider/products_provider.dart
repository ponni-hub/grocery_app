import 'package:flutter/foundation.dart';
import 'package:grocery_app/api/api_service.dart';
import 'package:grocery_app/models/product_item.dart';
import 'package:grocery_app/models/category_model.dart';

class SortBy {
  String value;
  String text;
  String sortOrder;

  SortBy(this.value, this.text, this.sortOrder);
}

enum LoadMoreStatus { INITIAL, LOADING, STABLE }

class ProductsProvider with ChangeNotifier {
  final List<ProductModel> _productList = [];
  SortBy _sortBy = SortBy("popularity", "popularity", "asc");
  int totalPages = 0, pageSize = 10;
  LoadMoreStatus _loadMoreStatus = LoadMoreStatus.STABLE;
  String _strSearch = '', _categoryId = '';

  List<ProductModel> get allProducts => _productList;
  double get totalRecords => _productList.length.toDouble();

  // Getter for load more status
  LoadMoreStatus getLoadMoreStatus() => _loadMoreStatus;

  String get strSearch => _strSearch;
  String get categoryId => _categoryId;
  ProductsProvider() {
    resetStreams();
    _sortBy = SortBy("popularity", "popularity", "asc");
  }

  void resetStreams() {
    _productList.clear();
    setLoadMoreState(LoadMoreStatus.INITIAL);
  }

  setLoadMoreState(LoadMoreStatus LoadMoreStatus) {
    _loadMoreStatus = LoadMoreStatus;
    notifyListeners();
  }

  fetchProducts(
    pageNumber, {
    String? strSearch,
    String? categoryId,
    String? sortBy,
    String? sortOrder = "asc",
  }) async {
    setLoadMoreState(LoadMoreStatus.LOADING);
    List<ProductModel>? itemModel = await ApiService.getProducts(
      strSearch: _strSearch,
      pageNumber: pageNumber,
      pageSize: pageSize,
      categoryId: _categoryId,
      sortBy: _sortBy.value,
      sortOrder: _sortBy.sortOrder,
    );
    if (itemModel!.isNotEmpty) _productList.addAll(itemModel);
    setLoadMoreState(LoadMoreStatus.STABLE);
    notifyListeners();
  }

  setSortOrder(SortBy sortBy) {
    _sortBy = sortBy;
    resetStreams();
  }

  setSearchStr(val) {
    _strSearch = val;
    resetStreams();
    fetchProducts(1);
  }

  setProductCategory(val) {
    _categoryId = val.toString();
    _strSearch = "";
    resetStreams();
    fetchProducts(1);
  }
}
