import 'package:chatgtp/views/imagegenrration.dart';
import 'package:chatgtp/views/textgeneration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> with TickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AI"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Get.changeTheme(
                  Get.isDarkMode ? ThemeData.light() : ThemeData.dark());
            },
            icon: const Icon(Icons.sunny),
          )
        ],
        bottom: TabBar(
          controller: tabController,
          tabs: const [
            Tab(
              icon: Icon(Icons.abc),
              child: Text("Text"),
            ),
            Tab(
              icon: Icon(Icons.image),
              child: Text("Image"),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          textgeneration(),
          imagegeneration(),
        ],
      ),
    );
  }
}
