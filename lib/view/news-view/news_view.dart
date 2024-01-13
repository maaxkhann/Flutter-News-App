import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/model/news_category_model.dart';
import 'package:news_app/model/news_headlines_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:news_app/view/news_detail_view.dart';
import 'package:news_app/view/news-view/widget/news_view_appBar.dart';
import 'package:news_app/view_model/news_category_view_model.dart';
import 'package:news_app/view_model/news_view_model.dart';
import 'package:provider/provider.dart';

class NewsView extends StatelessWidget {
  const NewsView({super.key});

  @override
  Widget build(BuildContext context) {
    final newsViewModel = Provider.of<NewsViewModel>(context, listen: true);
    final newsCategoryViewModel =
        Provider.of<NewsCategoryViewModel>(context, listen: true);
    return Scaffold(
      appBar: const NewsViewAppBar(),
      body: ListView(
        children: [
          SizedBox(
            width: Get.width * 0.9,
            height: Get.height * 0.5,
            child: FutureBuilder<NewsHeadlinesModel>(
                future: newsViewModel.fetchNewsHeadlines(newsViewModel.source),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: SpinKitCircle(
                      color: Colors.blue,
                    ));
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Something went wrong'));
                  } else {
                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.articles!.length,
                        itemBuilder: (context, index) {
                          DateTime dateTime = DateTime.parse(
                              snapshot.data!.articles![index].publishedAt!);
                          return Stack(
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.to(() => NewsDetailView(
                                        newsDetail:
                                            snapshot.data!.articles![index],
                                      ));
                                },
                                child: Container(
                                  width: Get.width * 0.9,
                                  height: Get.height * 0.5,
                                  padding: EdgeInsets.symmetric(
                                      vertical: Get.height * 0.02,
                                      horizontal: Get.width * 0.02),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: CachedNetworkImage(
                                      imageUrl: snapshot
                                          .data!.articles![index].urlToImage!,
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
                              ),
                              Positioned(
                                left: Get.width * 0.037,
                                bottom: Get.height * 0.022,
                                child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Container(
                                    padding: const EdgeInsets.all(12),
                                    alignment: Alignment.bottomCenter,
                                    height: Get.height * 0.2,
                                    width: Get.width * 0.8,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: Get.width * 0.7,
                                          child: Text(
                                            snapshot
                                                .data!.articles![index].title!,
                                            style: GoogleFonts.poppins(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600),
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        const Spacer(),
                                        SizedBox(
                                          width: Get.width * 0.7,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
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
                                              Text(
                                                newsViewModel.dateFormat
                                                    .format(dateTime)
                                                    .toString(),
                                                style: GoogleFonts.poppins(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          );
                        });
                  }
                }),
          ),
          FutureBuilder<NewsCategoryModel>(
              future: newsCategoryViewModel.fetchNewsCategory('General'),
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
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                                fontWeight: FontWeight.w600),
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
                                                fontWeight: FontWeight.w500),
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
              }))
        ],
      ),
    );
  }
}
