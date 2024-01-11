import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/view_model/news_category_view_model.dart';
import 'package:provider/provider.dart';

class NewsCategoryView extends StatelessWidget {
  const NewsCategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final newsCategoryViewModel =
        Provider.of<NewsCategoryViewModel>(context, listen: true);
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: newsCategoryViewModel.categoryList.length,
                itemBuilder: (context, index) {
                  return Align(
                    alignment: Alignment.topCenter,
                    child: InkWell(
                      splashColor: Colors.blue,
                      onTap: () {
                        newsCategoryViewModel.setCategory(newsCategoryViewModel
                            .currentCategorySelected
                            .toString());
                        newsCategoryViewModel.currentCategorySelected =
                            newsCategoryViewModel.categoryList[index];
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        height: Get.height * 0.07,
                        decoration: BoxDecoration(
                            color: newsCategoryViewModel.categoryList[index] ==
                                    newsCategoryViewModel
                                        .currentCategorySelected
                                ? Colors.blue
                                : Colors.grey,
                            borderRadius: BorderRadius.circular(12)),
                        child: Center(
                            child: Text(
                          newsCategoryViewModel.categoryList[index],
                          style: GoogleFonts.poppins(
                              fontSize: 15, fontWeight: FontWeight.w500),
                        )),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ));
  }
}
