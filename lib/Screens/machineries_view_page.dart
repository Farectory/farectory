import 'dart:async';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MachineriesViewPage extends StatefulWidget {
  String name;
  String price;
  String description;
  String imageURL;
  List features;
  int units;
  List sliderImages;
  String brand;
  MachineriesViewPage(
      {super.key,
      required this.name,
      required this.brand,
      required this.description,
      required this.imageURL,
      required this.features,
      required this.sliderImages,
      required this.units,
      required this.price});

  @override
  State<MachineriesViewPage> createState() => _MachineriesViewPageState();
}

class _MachineriesViewPageState extends State<MachineriesViewPage> {
  late final PageController pageController;
  Timer? carasouelTmer;
  int pageNo = 0;

  @override
  void initState() {
    pageController = PageController(initialPage: 0, viewportFraction: 0.85);
    carasouelTmer = getTimer();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        bottomNavigationBar: Container(
          width: double.infinity,
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(width: 2, color: Colors.blue),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: const Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: IconButton(
                    onPressed: () async {},
                    icon: Icon(
                      Icons.home_outlined,
                      color: Colors.blue,
                    )),
              ),
              Container(
                height: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(width: 2, color: Colors.blue),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: const Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: TextButton(
                  onPressed: () async {},
                  child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.phone,
                          color: Colors.blue,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Call to rent',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ]),
                ),
              ),
              IconButton(
                onPressed: () {
                  
                },
                icon: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue),
                  width: 150,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.trolley,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          )
                        ],
                      ),
                      Text(
                        'ADD TO CART',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.favorite_border_outlined,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ],
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Column(children: [
                  SizedBox(height: 25),
                  SizedBox(
                    height: 300,
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
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15)),
                                    child: Image.network(widget.sliderImages[index])
                                  )),
                            ),
                          );
                        },
                        itemCount: widget.sliderImages.length),
                  ),
                  Expanded(
                    child: Container(
                      // margin: EdgeInsets.only(bottom: 60),
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(60),
                              topRight: Radius.circular(60)),
                          color: Colors.white),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(10, 20, 10, 10),
                              width: double.infinity,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(30, 0, 30, 0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(widget.name.toUpperCase(),
                                        maxLines: 3,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 22,
                                        )),
                                    Text(
                                      'Brand: ${widget.brand}',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    Text(
                                      '₦ ${widget.price}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 19),
                                    ),
                                    Text(
                                      '${widget.units} Unit(s) left',
                                      style: TextStyle(color: Colors.red),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                              thickness: 1.5,
                              color: Colors.blue,
                            ),
                            Text(
                              'Description',
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            Container(
                                padding:
                                    const EdgeInsets.fromLTRB(40, 0, 40, 60),
                                child: Column(
                                  children: [
                                    Text(widget.description,
                                        style: TextStyle(fontSize: 17)),
                                    SizedBox(height: 20),
                                    Text(
                                      'Features & advantages',
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      child: Column(
                                        children: [
                                          SizedBox(height:	5),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: List.generate(widget.features.length, (index) {
                                              return Text(widget.features[index],
                                              style: TextStyle(fontSize: 17),);
                                            }
                                          )),
                                        ],
                                      ),
                                    )
                                    
                                  ],
                                ))
                          ],
                        ),
                      ),
                    ),
                  )
                ])),
          ],
        )));
  }
}
