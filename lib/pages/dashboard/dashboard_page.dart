import 'package:flutter/material.dart';
import 'package:grocery_app/pages/dashboard/navigator_item.dart';
import 'package:grocery_app/utils/colors.dart';
import 'package:flutter_svg/svg.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int curentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigatoritems[curentIndex].screen,
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      currentIndex: curentIndex,
      onTap: (index) => setState(() => curentIndex = index),
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.primarycolor,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
      unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
      unselectedItemColor: Colors.black,
      items: navigatoritems.map((e) => getNavigatorBarItem(e)).toList(),
    );
  }

  BottomNavigationBarItem getNavigatorBarItem(NavigatorItem item) {
    Color iconColor =
        item.index == curentIndex ? AppColors.primarycolor : Colors.black;
    return BottomNavigationBarItem(
        label: item.label, icon: Icon(item.icon, color: iconColor));
  }
}
