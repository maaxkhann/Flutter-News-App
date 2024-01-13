import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/view_model/news_view_model.dart';
import 'package:provider/provider.dart';

import '../../news_category_view.dart';

class NewsViewAppBar extends StatelessWidget implements PreferredSizeWidget {
  const NewsViewAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final newsViewModel = Provider.of<NewsViewModel>(context);
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: IconButton(
          onPressed: () => Get.to(() => const NewsCategoryView()),
          icon: Image.asset(
            'assets/images/category_icon.png',
            width: Get.width * 0.065,
            height: Get.height * 0.065,
          ),
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Center(
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
      actions: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: PopupMenuButton<FilterList>(
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
                  ]),
        )
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(Get.height * 0.06);
}
