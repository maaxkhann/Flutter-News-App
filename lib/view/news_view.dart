import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/model/news_headlines_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:news_app/view/news_category_view.dart';
import 'package:news_app/view_model/news_view_model.dart';
import 'package:provider/provider.dart';

class NewsView extends StatelessWidget {
  const NewsView({super.key});

  @override
  Widget build(BuildContext context) {
    final newsViewModel = Provider.of<NewsViewModel>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.to(() => const NewsCategoryView()),
          icon: Image.asset(
            'assets/images/category_icon.png',
            width: Get.width * 0.065,
            height: Get.height * 0.065,
          ),
        ),
        title: Center(
          child: Padding(
            padding: EdgeInsets.only(right: Get.width * 0.14),
            child: Text(
              'News',
              style: GoogleFonts.poppins(
                  fontSize: 24, letterSpacing: 2, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        actions: [
          PopupMenuButton<FilterList>(
              initialValue: newsViewModel.selectedMenu,
              onSelected: (FilterList item) {
                if (FilterList.bbcNews.name == item.name) {
                  newsViewModel.selectMenu(item, 'bbc-news');
                }
                if (FilterList.bbcSport.name == item.name) {
                  newsViewModel.selectMenu(item, 'bbc-sport');
                }
                if (FilterList.alJazeeraNews.name == item.name) {
                  newsViewModel.selectMenu(item, 'al-jazeera-english');
                }

                if (FilterList.cnnNews.name == item.name) {
                  newsViewModel.selectMenu(item, 'cnn');
                }
                if (FilterList.espnNews.name == item.name) {
                  newsViewModel.selectMenu(item, 'espn');
                }
              },
              itemBuilder: (BuildContext context) =>
                  <PopupMenuEntry<FilterList>>[
                    const PopupMenuItem<FilterList>(
                        value: FilterList.bbcNews, child: Text('BBC News')),
                    const PopupMenuItem<FilterList>(
                        value: FilterList.bbcSport, child: Text('BBC Sport')),
                    const PopupMenuItem<FilterList>(
                        value: FilterList.alJazeeraNews,
                        child: Text('Al Jazeera News')),
                    const PopupMenuItem<FilterList>(
                        value: FilterList.cnnNews, child: Text('CNN News')),
                    const PopupMenuItem<FilterList>(
                        value: FilterList.espnNews, child: Text('ESPN News'))
                  ])
        ],
      ),
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
                              Container(
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
                                                    fontSize: 16,
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
          )
        ],
      ),
    );
  }
}
