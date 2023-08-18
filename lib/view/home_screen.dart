import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app_in_flutter/models/categories_news_modeI.dart';
import 'package:news_app_in_flutter/models/news_channels_headIines_modeI.dart';
import 'package:news_app_in_flutter/view/categories_screen.dart';
import 'package:news_app_in_flutter/view_model/news_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum FitterList {
  bbcNews,
  aryNews,
  aftenposten,
  bloomberg,
  axios,
  independent,
  reuters,
  cnn,
  atJazeera
}

class _HomeScreenState extends State<HomeScreen> {
  NewsViewModel newsViewModel = NewsViewModel();

  FitterList? selctedMenu;

  final format = DateFormat("MMMM dd yyyy");

  String name = "bbc-news";

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 1;
    final height = MediaQuery.of(context).size.height * 1;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CategoriesScreen()));
            },
            icon: Image.asset(
              "images/category_icon.png",
              height: 30,
              width: 30,
            )),
        title: Text(
          "News",
          style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700),
        ),
        actions: [
          PopupMenuButton<FitterList>(
              initialValue: selctedMenu,
              icon: Icon(
                Icons.more_vert,
                color: Colors.black,
              ),
              onSelected: (item) {
                if (FitterList.bbcNews.name == item.name) {
                  name = "bbc-news";
                }
                if (FitterList.aryNews.name == item.name) {
                  name = "ary-news";
                }
                if (FitterList.aftenposten.name == item.name) {
                  name = "aftenposten";
                }
                if (FitterList.bloomberg.name == item.name) {
                  name = "bloomberg";
                }
                if (FitterList.axios.name == item.name) {
                  name = "axios";
                }

                setState(() {
                  selctedMenu = item;
                });
              },
              itemBuilder: (context) => <PopupMenuEntry<FitterList>>[
                    PopupMenuItem<FitterList>(
                        value: FitterList.bbcNews, child: Text("BBC News")),
                    PopupMenuItem<FitterList>(
                        value: FitterList.aryNews, child: Text("Ary News")),
                    PopupMenuItem<FitterList>(
                        value: FitterList.aftenposten,
                        child: Text("Aftenposten")),
                    PopupMenuItem<FitterList>(
                        value: FitterList.bloomberg, child: Text("Bloomberg")),
                    PopupMenuItem<FitterList>(
                        value: FitterList.axios, child: Text("Axios")),
                  ]),
        ],
      ),
      body: ListView(
        children: [
          SizedBox(
            height: height * .55,
            width: width,
            child: FutureBuilder<NewsChannelsHeadIinesModeI>(
              future: newsViewModel.fetchNewsChannelHeadlinesApi(newsId: name),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: SpinKitCircle(
                      size: 50,
                      color: Colors.blue,
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.articles!.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      DateTime dateTime = DateTime.parse(snapshot
                          .data!.articles![index].publishedAt
                          .toString());

                      return SizedBox(
                        child: Stack(alignment: Alignment.center, children: [
                          Container(
                            height: height * 0.6,
                            width: width * .9,
                            padding:
                                EdgeInsets.symmetric(horizontal: height * .02),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: CachedNetworkImage(
                                  imageUrl: snapshot
                                      .data!.articles![index].urlToImage
                                      .toString(),
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Container(
                                        child: spinkit2,
                                      ),
                                  errorWidget: (context, url, error) => Icon(
                                      Icons.error_outline,
                                      color: Colors.red)),
                            ),
                          ),
                          Positioned(
                            bottom: 20,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Container(
                                alignment: Alignment.bottomCenter,
                                padding: EdgeInsets.all(15),
                                height: height * .22,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: width * 0.7,
                                      child: Text(
                                          snapshot.data!.articles![index].title
                                              .toString(),
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.poppins(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w700)),
                                    ),
                                    Spacer(),
                                    Container(
                                      width: width * 0.7,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              snapshot.data!.articles![index]
                                                  .source!.name
                                                  .toString(),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.poppins(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w600)),
                                          Text(format.format(dateTime),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500)),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ]),
                      );
                    },
                  );
                }
              },
            ),
          ),

          
          Padding(
            padding: const EdgeInsets.all(20),
            child: FutureBuilder<CategoriesNewsModeI>(
              future:
                  newsViewModel.fetchCategoriesNewsApi(categories: "general"),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: SpinKitCircle(
                      size: 50,
                      color: Colors.blue,
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.articles!.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      DateTime dateTime = DateTime.parse(snapshot
                          .data!.articles![index].publishedAt
                          .toString());

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: CachedNetworkImage(
                                  height: height * .18,
                                  width: width * .3,
                                  imageUrl: snapshot
                                      .data!.articles![index].urlToImage
                                      .toString(),
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Container(
                                        child: Center(
                                          child: SpinKitCircle(
                                            size: 50,
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ),
                                  errorWidget: (context, url, error) => Icon(
                                      Icons.error_outline,
                                      color: Colors.red)),
                            ),
                            Expanded(
                                child: Container(
                              height: height * .18,
                              padding: EdgeInsets.only(left: 15),
                              child: Column(
                                children: [
                                  Text(
                                    snapshot.data!.articles![index].title
                                        .toString(),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Spacer(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        snapshot
                                            .data!.articles![index].source!.name
                                            .toString(),
                                        style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        format.format(dateTime),
                                        style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ))
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

const spinkit2 = SpinKitFadingCircle(
  color: Colors.amber,
  size: 50,
);
