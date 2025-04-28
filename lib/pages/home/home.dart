import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart' as carousel;

class SliderModel {
  final String? image;
  SliderModel({this.image});
}

class ProductModel {
  final String? image;
  ProductModel({this.image});
}

class APIService {
  static Future<List<SliderModel>> getSliders() async {
    await Future.delayed(Duration(seconds: 2));
    return [
      SliderModel(image: 'https://via.placeholder.com/600x400'),
      SliderModel(image: 'https://via.placeholder.com/600x400'),
    ];
  }

  static Future<List<ProductModel>> getProducts() async {
    await Future.delayed(Duration(seconds: 2));
    return [
      ProductModel(image: 'https://via.placeholder.com/150'),
      ProductModel(image: 'https://via.placeholder.com/150'),
    ];
  }
}

class ProductItemCardWidget extends StatelessWidget {
  final ProductModel item;
  const ProductItemCardWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      color: Colors.grey,
      child: (item.image != null && item.image!.isNotEmpty)
          ? Image.network(item.image!, fit: BoxFit.cover)
          : const Icon(Icons.image_not_supported),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 20),
                const Text(
                  "Delivery in 10 min",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 10),
                _sliderList(),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: const Text(
                      "Weekly Deals",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                _categoriesList(),
                const SizedBox(height: 10),
                _productsList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _sliderList() {
    return FutureBuilder<List<SliderModel>?>(
      future: APIService.getSliders(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text("Error loading slider"));
        } else if (!snapshot.hasData ||
            snapshot.data == null ||
            snapshot.data!.isEmpty) {
          return const Center(child: Text('No Sliders found'));
        }

        return carousel.CarouselSlider.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index, realIndex) {
            final item = snapshot.data![index];
            return Container(
              margin: const EdgeInsets.all(5),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  item.image ?? '',
                  fit: BoxFit.fill,
                ),
              ),
            );
          },
          options: carousel.CarouselOptions(
            height: 200,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 2),
            enlargeCenterPage: true,
            viewportFraction: 0.8,
          ),
        );
      },
    );
  }

  Widget _productsList() {
    return FutureBuilder<List<ProductModel>?>(
      future: APIService.getProducts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text("Error loading products"));
        } else if (!snapshot.hasData ||
            snapshot.data == null ||
            snapshot.data!.isEmpty) {
          return const Center(child: Text('No Products found'));
        }

        return SizedBox(
          height: 230,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data!.length,
            separatorBuilder: (context, index) => const SizedBox(width: 20),
            itemBuilder: (context, index) {
              final productItem = snapshot.data![index];
              return GestureDetector(
                onTap: () {},
                child: ProductItemCardWidget(item: productItem),
              );
            },
          ),
        );
      },
    );
  }

  Widget _categoriesList() {
    return const SizedBox(); // you can add your category list here
  }
}
