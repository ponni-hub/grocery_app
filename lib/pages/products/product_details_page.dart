import 'package:flutter/material.dart';
import 'package:grocery_app/api/api_service.dart';
import 'package:grocery_app/models/product_item.dart';
import 'package:grocery_app/pages/categories/categories_page.dart';
import 'package:grocery_app/pages/products/related_products.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({super.key});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  ProductModel? model;

  late String productId;
  late String productName;

  bool active = false;

  @override
  void initState() {
    super.initState();
    model = ProductModel();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    productId = arguments["productId"]?.toString() ?? "";
    productName = arguments["productName"]?.toString() ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(productName ?? ""),
      ),
      body: SafeArea(
          child: Container(
        color: HexColor("f3f1f6"),
        child: productdetails(),
      )),
    );
  }

  Widget productdetails() {
    return FutureBuilder(
        future: ApiService.getProductDetails(productId),
        builder: (BuildContext context, AsyncSnapshot<ProductModel?> data) {
          if (data.hasData) {
            model = data.data;

            return SingleChildScrollView(
              child: Column(
                children: [
                  getImageWidget(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          color: Colors.white,
                          child: Column(
                            children: [productTitle(), buildAmountWidget()],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        productdetailsWidget(),
                        SizedBox(height: 10),
                        model!.relatedIds!.isNotEmpty
                            ? RelatedProducts(
                                products: model!.relatedIds!,
                                title: "you might also like")
                            : SizedBox()
                      ],
                    ),
                  )
                ],
              ),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  Widget getImageWidget() {
    return Container(
      color: Colors.white,
      height: 300,
      child: Center(
        child: Image.network(model!.images![0].url!),
      ),
    );
  }

  Widget productTitle() {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 10),
      child: Text(
        model!.productName!,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget buildAmountWidget() {
    return ListTile(
      contentPadding:
          const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 10),
      title: Text(
        "\$ ${model!.price!}",
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      ),
      trailing: SizedBox(
        width: 100,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            visualDensity: VisualDensity.compact,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: Colors.red,
            elevation: 0,
            textStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            minimumSize: Size.fromHeight(50),
          ),
          onPressed: () {},
          child: Text(
            'Add',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget productdetailsWidget() {
    return ExpansionPanelList(
      elevation: 0,
      dividerColor: Colors.transparent,
      expandedHeaderPadding: EdgeInsets.symmetric(vertical: 0),
      expansionCallback: (int expndedIndex, bool isExpanded) {
        active = !active;
        setState(() {});
      },
      children: [
        ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return const ListTile(
              title: Text(
                'product Information',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            );
          },
          body: Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 15, top: 2),
              child: Text(model!.description!),
            ),
          ),
          isExpanded: active,
          canTapOnHeader: true,
        ),
      ],
    );
  }
}
