import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farectory/Screens/lands_view_page.dart';
import 'package:farectory/Screens/request_review_screen.dart';
import 'package:farectory/Utils/safe_google_font.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LandPage extends StatefulWidget {
  const LandPage({super.key});

  @override
  State<LandPage> createState() => _LandPageState();
}

class _LandPageState extends State<LandPage>
    with AutomaticKeepAliveClientMixin {
  late final PageController pageController;
  int pageNo = 0;
  Timer? carasouelTmer;
  late Future<QuerySnapshot> _future;

  Timer getTimer() {
    return Timer.periodic(const Duration(seconds: 3), (timer) {
      if (pageNo == 3) {
        pageNo = 0;
      }
      if (pageController.hasClients) {
        pageController.animateToPage(
          pageNo,
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOutCirc,
        );
      }
      pageNo++;
    });
  }

  List<Widget> sliderImages = [
    Image.asset(
      'images/farm1.jpg',
      fit: BoxFit.cover,
    ),
    Image.asset('images/farm3.png', fit: BoxFit.cover),
    Image.asset('images/farm.png', fit: BoxFit.cover),
  ];

  @override
  void initState() {
    pageController = PageController(initialPage: 0, viewportFraction: 0.85);
    carasouelTmer = getTimer();
    _future = FirebaseFirestore.instance.collection('FarmLands').get();
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      onRefresh: () {
            setState(() {});
            return Future.delayed(const Duration(seconds: 2));
          },
      child: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: 200,
            child: PageView.builder(
                controller: pageController,
                onPageChanged: (index) {
                  pageNo = index;
                  setState(() {});
                },
                itemBuilder: (_, index) {
                  return AnimatedBuilder(
                    animation: pageController,
                    builder: (ctx, child) {
                      return child!;
                    },
                    child: GestureDetector(
                      onTap: () {},
                      onPanDown: (d) {
                        carasouelTmer?.cancel();
                        carasouelTmer = null;
                      },
                      onPanCancel: () {
                        carasouelTmer = getTimer();
                      },
                      child: Container(
                          margin: const EdgeInsets.only(
                              right: 8, left: 8, top: 24, bottom: 12),
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                            child: sliderImages[index],
                          )),
                    ),
                  );
                },
                itemCount: 3),
          ),
          const SizedBox(
            height: 12.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              sliderImages.length,
              (index) => GestureDetector(
                child: Container(
                  margin: const EdgeInsets.all(2.0),
                  child: Icon(
                    Icons.circle,
                    size: 12.0,
                    color: pageNo == index ? Colors.blue : Colors.grey.shade300,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
            Text('Are you a land owner??'),
            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (_) => const RequestReviewPage()));
                                },
                                child: const Text(
                                  "Request a land review",
                                  style: TextStyle(color: Colors.blue),
                                ))
          ],),
          SizedBox(height: 20),
          Text(
            'Available lands',
            style: TextStyle(
              fontSize: 30,
            ),
          ),
          SizedBox(height: 20),
          FutureBuilder<QuerySnapshot>(
              future: _future,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.blue)));
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
      
                List featuredList = [];
                snapshot.data!.docs.forEach((element) {
                  final size = element.get('Size');
                  final imageURL = element.get('ImageURL');
                  final description = element.get('Description');
                  final location = element.get('Location');
                  final tenure = element.get('Tenure');
      
                  List<Map<String, dynamic>> details = [
                    {
                      'size': size,
                      'imageURL': imageURL,
                      'description': description,
                      'tenure': tenure,
                      'location': location,
                    }
                  ];
                  featuredList.add(details);
                });
      
                final landDetails = featuredList.asMap();
                return Column(
                    children: List.generate(landDetails.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (_) => const LandsViewPage()));
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 30, top: 20),
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                          color: Colors.white),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40),
                            ),
                            child: Container(
                              height: 250,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          landDetails[index][0]['imageURL']),
                                      fit: BoxFit.cover,
                                      filterQuality: FilterQuality.high)),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const CircleAvatar(
                                        backgroundColor:
                                            Color.fromARGB(23, 77, 158, 245),
                                        radius: 20,
                                        child: Icon(
                                          Icons.landscape,
                                          color: Colors.blue,
                                          size: 15,
                                        )),
                                    const SizedBox(width: 10),
                                    SizedBox(
                                      width: 240,
                                      child: Text(landDetails[index][0]['size'],
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: SafeGoogleFont('Arial',
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold)),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 15),
                                Text(landDetails[index][0]['description'],
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                    style: SafeGoogleFont('Arial', fontSize: 16)),
                                const SizedBox(height: 13),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Icon(Icons.landscape, color: Colors.grey),
                                    Text(landDetails[index][0]['tenure']),
                                    Icon(Icons.location_on, color: Colors.grey),
                                    Text(landDetails[index][0]['location'])
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }));
              }),
        ]),
      ),
    );
  }
}
