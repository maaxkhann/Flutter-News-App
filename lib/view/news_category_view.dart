import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
            SizedBox(
              height: Get.height * 0.07,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: newsCategoryViewModel.categoryList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      newsCategoryViewModel.setCategory(newsCategoryViewModel
                          .currentCategorySelected
                          .toString());
                      newsCategoryViewModel.currentCategorySelected =
                          newsCategoryViewModel.categoryList[index];
                    },
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        margin: const EdgeInsets.symmetric(horizontal: 10),
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
            Expanded(
              child: FutureBuilder(
                  future: newsCategoryViewModel.fetchNewsCategory(
                      newsCategoryViewModel.currentCategorySelected.toString()),
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: SpinKitCircle(
                          color: Colors.blue,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return const Center(child: Text('Something went wrong'));
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data!.articles!.length,
                          itemBuilder: (context, index) {
                            DateTime dateTime = DateTime.parse(snapshot
                                .data!.articles![index].publishedAt
                                .toString());
                            return Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(10),
                                  width: Get.width * 0.3,
                                  height: Get.height * 0.18,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: CachedNetworkImage(
                                      imageUrl: snapshot
                                          .data!.articles![index].urlToImage
                                          .toString(),
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          const SpinKitFadingCircle(
                                        color: Colors.blue,
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(
                                        Icons.error_outline,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: SizedBox(
                                    height: Get.height * 0.18,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          snapshot.data!.articles![index].title
                                              .toString(),
                                          style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600),
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const Spacer(),
                                        FittedBox(
                                          fit: BoxFit.fitWidth,
                                          child: Row(
                                            children: [
                                              Text(
                                                snapshot.data!.articles![index]
                                                    .source!.name
                                                    .toString(),
                                                style: GoogleFonts.poppins(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              SizedBox(
                                                width: Get.width * 0.04,
                                              ),
                                              Text(
                                                newsCategoryViewModel.dateFormat
                                                    .format(dateTime)
                                                    .toString(),
                                                style: GoogleFonts.poppins(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            );
                          });
                    }
                  })),
            )
          ],
        ));
  }
}
