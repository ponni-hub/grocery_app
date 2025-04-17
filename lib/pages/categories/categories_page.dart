import 'dart:ffi';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:grocery_app/api/api_service.dart';
import 'package:grocery_app/models/category_model.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:grocery_app/provider/products_provider.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  List<String> gridColors = [
    '#53b175',
    '#F8A44C',
    '#F7A593',
    '#D3B0E0',
    '#FDE598',
    '#B7DFF5',
    '#836AF6',
    '#D73B77'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          const SizedBox(height: 20),
          const Center(
              child: Text(
            "All Categories",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )),
          const SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: _categoriesList(),
            ),
          )
        ],
      )),
    );
  }

  Widget getStaggeredGrid(List<CategoryModel> data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: StaggeredGrid.count(
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4.0,
        children: data.asMap().entries.map<Widget>((e) {
          int index = e.key;
          CategoryModel categoryItem = e.value;
          return GestureDetector(
            onTap: () => onCategoryItemClicked(context, categoryItem),
            child: Container(
              padding: const EdgeInsets.all(10),
              child: buildCategoryCard(
                categoryItem,
                color: HexColor(gridColors[index % gridColors.length]),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _categoriesList() {
    return FutureBuilder(
      future: ApiService.getCategories(),
      builder: (
        BuildContext context,
        AsyncSnapshot<List<CategoryModel>?> model,
      ) {
        if (model.hasData) {
          return getStaggeredGrid(model.data!);
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  void onCategoryItemClicked(BuildContext context, CategoryModel categoryItem) {
    var productProvider = Provider.of<ProductsProvider>(context, listen: false);
    productProvider.setProductCategory(categoryItem.categoryId);
    Navigator.of(context).pushNamed(
      "/products",
      arguments: {
        'catId': categoryItem.categoryId,
        'catName': categoryItem.categoryName,
      },
    );
  }

  Widget buildCategoryCard(CategoryModel category, {Color? color}) {
    final imageUrl = category.image?.url;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            color: color ?? Colors.grey.shade200,
            borderRadius: BorderRadius.circular(12),
          ),
          child: imageUrl != null && imageUrl.isNotEmpty
              ? Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(child: CircularProgressIndicator());
                  },
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.broken_image,
                    color: Colors.red,
                    size: 50,
                  ),
                )
              : const Icon(
                  Icons.image_not_supported,
                  size: 50,
                  color: Colors.grey,
                ),
        ),
        const SizedBox(height: 8),
        Text(
          category.categoryName ?? 'Unnamed',
          style: const TextStyle(fontSize: 14),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor"; // Add alpha if not provided
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
