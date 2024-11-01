import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:news_app/description_page.dart';
import 'package:news_app/widget/build_text_widget.dart';
import 'news_models.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  NewsModel newsModel = NewsModel();
  bool isLoading = false;


  getData() async {
    final response = await Dio().get(
        'https://gnews.io/api/v4/search?q=example&lang=en&country=us&max=10&apikey=c56baf88b05c656b99482fcc33c1b0a5');
    newsModel = NewsModel.fromJson(response.data);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    setState(() {
      isLoading = true;
    });
    getData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Image.asset(
            'lib/assets/image/n logo.png',
            color: Colors.white,
          ),
        ),
        title: const BuildTextWidget(
          text: '            NewsVista',
          style: TextStyle(
              fontFamily: 'Oswald',
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 30),
        ),
        actions: [
          const Icon(
            Icons.more_vert,
            color: Colors.white,
          ),
          SizedBox(width: MediaQuery.of(context).size.width / 25),
        ],
      ),
      body: isLoading
          ? const Center(
              child: SpinKitPouringHourGlass(
                color: Colors.black,
              ),
            )
          : PageView.builder(
              scrollDirection: Axis.vertical,
              controller: _pageController,
              itemCount: newsModel.articles!.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 2.05,
                          child: newsModel.articles![index].image != null
                              ? Image.network(
                                  newsModel.articles![index].image!,
                                  fit: BoxFit.fitHeight,
                                )
                              : const Placeholder(),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 1.12,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Card(
                                elevation: 10,
                                shadowColor: Colors.black,
                                margin: const EdgeInsets.only(top: 20),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      // Padding(
                                      //   padding:
                                      //       const EdgeInsets.only(right: 250),
                                      //   child: Expanded(
                                      //     child: Container(
                                      //       decoration: BoxDecoration(
                                      //         color: Colors.black,
                                      //         borderRadius:
                                      //             BorderRadius.circular(10),
                                      //       ),
                                      //       child: const Center(
                                      //           // child: BuildTextWidget(
                                      //           //   text: newsModel
                                      //           //       .articles![index].content,
                                      //           //   style: const TextStyle(
                                      //           //       color: Colors.white,
                                      //           //       fontWeight:
                                      //           //           FontWeight.bold),
                                      //           // ),
                                      //           ),
                                      //     ),
                                      //   ),
                                      // ),
                                      Text(
                                        newsModel.articles![index].title ??
                                            'No title available',
                                        style: const TextStyle(
                                          fontSize: 22,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              49),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                7,
                                        child: BuildTextWidget(
                                          text: newsModel.articles![index]
                                                  .description ??
                                              'No description available',
                                          maxLines: 5,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    DescriptionPage(
                                                  description: newsModel
                                                          .articles![index]
                                                          .description ??
                                                      '',
                                                  title: newsModel
                                                          .articles![index]
                                                          .title ??
                                                      '',
                                                  content: newsModel
                                                          .articles![index]
                                                          .content ??
                                                      '',
                                                  image: newsModel
                                                          .articles![index]
                                                          .image ??
                                                      '',
                                                ),
                                              ),
                                            );
                                          },
                                          child: const BuildTextWidget(
                                            text: 'Continue Reading...',
                                            style:
                                                TextStyle(color: Colors.blue),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Column(
                                            children: [
                                              Align(
                                                alignment: Alignment.bottomLeft,
                                                child: Padding(
                                                  padding: const EdgeInsets.only(right:40),
                                                  child: BuildTextWidget(
                                                    text: DateFormat('HH:mm a').format(newsModel.articles![index].publishedAt!),
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w700,
                                                    ),
                                                  ),
                                                ),
                                              ),Align(
                                                alignment: Alignment.bottomLeft,
                                                child: BuildTextWidget(
                                                  text: DateFormat('MMMM d,y').format(newsModel.articles![index].publishedAt!),
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Spacer(),
                                          // Row(
                                          //   children: [
                                          //     IconButton(
                                          //       icon: isFavourite
                                          //           ? const Icon(
                                          //               Icons.favorite,
                                          //               color: Colors.red,
                                          //             )
                                          //           : const Icon(
                                          //               Icons.favorite_border,
                                          //               color: Colors.black,
                                          //             ),
                                          //       onPressed: () {
                                          //         setState(() {
                                          //           isFavourite = !isFavourite;
                                          //         });
                                          //       },
                                          //     ),
                                          //      SizedBox(
                                          //       width: MediaQuery.of(context).size.width/40,
                                          //     ),IconButton(
                                          //       icon: isSaved
                                          //           ? const Icon(
                                          //         Icons.turned_in,
                                          //         color: Colors.black,
                                          //       )
                                          //           : const Icon(
                                          //         Icons.turned_in_not,
                                          //         color: Colors.black,
                                          //       ),
                                          //       onPressed: () {
                                          //         setState(() {
                                          //           isSaved = !isSaved;
                                          //         });
                                          //       },
                                          //     ),
                                          //      SizedBox(
                                          //       width: MediaQuery.of(context).size.width/26.66,
                                          //     ),
                                          //     const Icon(
                                          //       Icons.share,
                                          //       color: Colors.black,
                                          //     ),
                                          //   ],
                                          // ),
                                        ],
                                      ),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              40),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }),
    );
  }
}
