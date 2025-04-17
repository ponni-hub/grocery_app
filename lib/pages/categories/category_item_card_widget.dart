import 'package:flutter/material.dart';
import 'package:grocery_app/models/category_model.dart';
import 'package:grocery_app/utils/colors.dart';

class CategoryItemCardWidget extends StatelessWidget {
  const CategoryItemCardWidget({
    super.key,
    required this.item,
    this.color =Colors.blue  ,
    });

  final CategoryModel item;
  final double height =150.0;
  final double width =175.0;
  final Color borderColor =AppColors.darkGrey;
final double borderRadious =18;
final Color color;



  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Container(
            decoration: BoxDecoration(
              color: color.withOpacity(.1),
              borderRadius: BorderRadius.circular(borderRadious)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 90,
                  width: 100,
                  child:SizedBox(
                    width: 80,
                    child: Image.network(item.image!.url!),
                  ) ,
                )
              ],
            ),
          ),

        ),

SizedBox(
  height: 30,
  child: Text(item.categoryName!,style:const TextStyle(fontSize: 12),textAlign:TextAlign.center ,),
)

      ],
    );
  }
}