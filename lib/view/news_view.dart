import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/model/news_headlines_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:news_app/view_model/news_view_model.dart';

class NewsView extends StatelessWidget {
  const NewsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
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
      ),
      body: ListView(
        children: [
          SizedBox(
            width: Get.width * 0.9,
            height: Get.height * 0.5,
            child: FutureBuilder<NewsHeadlinesModel>(
                future: NewsViewModel().fetchNewsHeadlines(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: SpinKitCircle(
                      color: Colors.blue,
                    ));
                  } else {
                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.articles!.length,
                        itemBuilder: (context, index) {
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
