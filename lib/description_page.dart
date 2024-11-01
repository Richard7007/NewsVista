import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:news_app/news_models.dart';
import 'package:news_app/widget/build_text_widget.dart';

class DescriptionPage extends StatefulWidget {
  final String title;
  final String description;
  final String content;
  final DateTime? publishedAt;

  final String image;

  const DescriptionPage({
    super.key,
    required this.description,
    required this.title,
    required this.content,
    required this.image,
    this.publishedAt,
  });

  @override
  _DescriptionPageState createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage> {
  final ScrollController _scrollController = ScrollController();
  bool _isVisible = false;
  NewsModel newsModel = NewsModel();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    // Call getData function when the widget initializes
    getData();
  }

  void _scrollListener() {
    if (_scrollController.offset <=
        _scrollController.position.minScrollExtent) {
      setState(() {
        _isVisible = false;
      });
    } else {
      setState(() {
        _isVisible = true;
      });
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0.0,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  // Fetch data from the API
  Future<void> getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await Dio().get(
          'https://gnews.io/api/v4/search?q=example&lang=en&country=us&max=10&apikey=c56baf88b05c656b99482fcc33c1b0a5');
      setState(() {
        newsModel = NewsModel.fromJson(response.data);
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(
              top: 130, bottom: 130, right: 155, left: 100),
          child: Image.asset(
            'lib/assets/image/n logo.png',
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      body: isLoading
          ?  const Center(
              child: SpinKitPouringHourGlass(
                color: Colors.black,
              ),
            )
          : Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  opacity: 0.07,
                  image: AssetImage('lib/assets/image/n logo.png'),
                  fit: BoxFit.scaleDown,
                ),
              ),
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 250),
                        child: Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Center(
                                // child: BuildTextWidget(
                                //   text: widget.content,
                                //   style: const TextStyle(
                                //     color: Colors.white,
                                //     fontWeight: FontWeight.bold,
                                //   ),
                                // ),
                                ),
                          ),
                        ),
                      ),
                      BuildTextWidget(
                        text: widget.title,
                        style: const TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 80),
                      SizedBox(
                        child: BuildTextWidget(text:
                          widget.description,
                          maxLines: 100,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 80),
                      // Row(
                      //   children: [
                      //     Column(
                      //       children: [
                      //         Align(
                      //           alignment: Alignment.bottomLeft,
                      //
                      //           child: Padding(
                      //             padding: const EdgeInsets.only(right: 25),
                      //             child: BuildTextWidget(
                      //               text: DateFormat('HH:mm a').format(newsModel.articles![index].publishedAt!),
                      //               style: const TextStyle(
                      //                 fontSize: 14,
                      //                 color: Colors.black,
                      //                 fontWeight: FontWeight.w700,
                      //               ),
                      //             ),
                      //           ),
                      //         ),Align(
                      //           alignment: Alignment.bottomLeft,
                      //           child: BuildTextWidget(
                      //             text: DateFormat('MMMM d,y').format(newsModel.articles![index].publishedAt!),
                      //             style: const TextStyle(
                      //               fontSize: 14,
                      //               color: Colors.black,
                      //               fontWeight: FontWeight.w700,
                      //             ),
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ],
                      // ),
                      SizedBox(height: MediaQuery.of(context).size.height / 40),
                      const Divider(
                        color: Colors.black,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 260),
                        child: BuildTextWidget(
                          text: 'Trending >',
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 80),
                      SizedBox(
                          height: MediaQuery.of(context).size.height / 5.33,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: newsModel.articles?.length ?? 0,
                            itemBuilder: (BuildContext context, int index) {
                              if (newsModel.articles != null &&
                                  newsModel.articles!.isNotEmpty) {
                                final article = newsModel.articles![index];
                                return Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                DescriptionPage(
                                              description:
                                                  article.description ?? '',
                                              title: article.title ?? '',
                                              content: article.content ?? '',
                                              image: article.image ?? '',
                                            ),
                                          ),
                                        );
                                      },
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                4.7,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2,
                                            decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            7.27),
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2.22,
                                                  child: BuildTextWidget(
                                                    text: article.title,
                                                    maxLines: 2,
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                7.27,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2,
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(15.0),
                                                topRight: Radius.circular(15.0),
                                              ),
                                            ),
                                            child: article.image != null
                                                ? Image.network(
                                                    article.image!,
                                                    fit: BoxFit.fill,
                                                  )
                                                : const Placeholder(),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          40,
                                    ),
                                  ],
                                );
                              } else {
                                return const SizedBox();
                              }
                            },
                          )),
                      const Divider(
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
            ),
      floatingActionButton: Visibility(
        visible: _isVisible,
        child: FloatingActionButton(
          onPressed: _scrollToTop,
          backgroundColor: Colors.black,
          child: const Icon(
            Icons.arrow_upward,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }
}
