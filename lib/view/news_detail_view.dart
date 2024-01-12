import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/model/news_headlines_model.dart';
import 'package:provider/provider.dart';

class NewsDetailView extends StatelessWidget {
  final Articles newsDetail;
  const NewsDetailView({
    super.key,
    required this.newsDetail,
  });

  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormat = DateFormat('MM dd yyyy');
    final DateTime dateTime = DateTime.parse(newsDetail.publishedAt.toString());
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: Get.height * 0.45,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: newsDetail.urlToImage.toString(),
                placeholder: (context, url) => SpinKitFadingCircle(),
                errorWidget: (context, url, error) => const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: Get.height * 0.55,
            margin: EdgeInsets.only(top: Get.height * 0.42),
            padding: EdgeInsets.symmetric(horizontal: Get.height * 0.03),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: ListView(
              children: [
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Text(
                  newsDetail.title.toString(),
                  style: GoogleFonts.poppins(
                      fontSize: 15, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Row(
                  children: [
                    Expanded(
                        child: Text(
                      newsDetail.source!.name.toString(),
                      style: GoogleFonts.poppins(
                          fontSize: 15, fontWeight: FontWeight.w600),
                    )),
                    Text(
                      dateFormat.format(dateTime).toString(),
                      style: GoogleFonts.poppins(
                          fontSize: 12, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Text(
                  newsDetail.description.toString(),
                  style: GoogleFonts.poppins(
                      fontSize: 15, fontWeight: FontWeight.w400),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
