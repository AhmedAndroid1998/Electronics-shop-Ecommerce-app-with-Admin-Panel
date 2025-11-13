import 'package:electronics_store_e_commerce_with_admin_panel/services/asset_helper.dart';
import 'package:electronics_store_e_commerce_with_admin_panel/widgets/support_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 234, 235, 231),
      body: Container(
        margin: EdgeInsets.only(top: 50, left: 20, right: 20),
        child: Column(
          children: [
            _buildHeader(),
            SizedBox(height: 30),
            _buildSearchField(),
            SizedBox(height: 30),
            _buildCategoriesSection()
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hey, Ahmed',
              style: AppWidget.boldTextFieldStyle(),
            ),
            Text(
              'Good Morning',
              style: AppWidget.lightTextFieldStyle(),
            ),
          ],
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            'assets/images/boy.jpg',
            width: 70,
            height: 70,
            fit: BoxFit.cover,
          ),
        )
      ],
    );
  }

  Widget _buildSearchField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
            border: InputBorder.none, //removes the underline border
            hintText: 'Search Products',
            hintStyle: AppWidget.lightTextFieldStyle(),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.black,
            )),
      ),
    );
  }

  Widget _buildCategoriesSection() {
    final categoriesDummyImages = AssetHelper.getDummyCategoryImages(4);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Categories',
              style: AppWidget.smallBoldTextFieldStyle(),
            ),
            Text(
              'All',
              style: AppWidget.smallBoldTextFieldStyle()
                  .copyWith(color: Colors.deepOrange),
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Container(
              width: 60,
              height: 100,
              alignment: Alignment.center,
              margin: EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                  color: Colors.deepOrange, borderRadius: BorderRadius.circular(10)),
              child: Text(
                'ALL',
                style: AppWidget.smallBoldTextFieldStyle()
                    .copyWith(color: Colors.white),
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 100,
                child: ListView.builder(
                  itemCount: categoriesDummyImages.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return _buildCategoryListTile(categoriesDummyImages[index]);
                  },
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildCategoryListTile(String imageName) {
    return Container(
      width: 90,
      height: 90,
      alignment: Alignment.center,
      margin: EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            imageName,
            height: 70,
            width: 70,
            fit: BoxFit.cover,
          ),
          Icon(Icons.arrow_forward)
        ],
      ),
    );
  }
}
