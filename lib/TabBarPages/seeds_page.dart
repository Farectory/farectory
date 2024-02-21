import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farectory/Screens/seeds_view_page.dart';
import 'package:farectory/Utils/safe_google_font.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SeedsPage extends StatefulWidget {
  const SeedsPage({super.key});

  @override
  State<SeedsPage> createState() => _SeedsPageState();
}

class _SeedsPageState extends State<SeedsPage>
    with AutomaticKeepAliveClientMixin {
  late final PageController pageController;
  int pageNo = 0;
  late Future<QuerySnapshot> _future;

  List<Widget> sliderTexts = [
    Text(
        'The adoption of genetically modified crops has resulted in enormous environmental benefits, including a significant reduction of greenhouse gas emissions from agricultural practices. This results from less fuel use and additional soil carbon storage from reduced tillage and zero tillage practices. with genetically modified crops. In 2013, this was equivalent to removing 28 billion kg of carbon dioxide from the atmosphere or equal to removing 12.4 million cars from the road for one year.'),
    Text(
        'From 1996-2013, Australian genetically modified cotton and canola farmers have realised farm income benefits of more than US\$885 million. Over the same period the global farm income gain from genetically modified crops has been US\$133.5 billion'),
    Text(
        'The unprecedented adoption rates of genetically modified crops are testimony to trust and confidence by millions of famers worldwide. A 100-fold increase in the acreage of genetically modified crops planted since 1996 makes genetically modified crops the fastest adopted crop technology in the world. In 2014, biotech crops were grown by 18 million farmers on 170 million hectares in 28 countries.')
  ];

  @override
  void initState() {
    pageController = PageController(initialPage: 0, viewportFraction: 1);
    _future = FirebaseFirestore.instance.collection('Seeds').get();
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
        child: Column(
      children: [
        Lottie.asset('images/fruit_animation.json',
            height: 150, fit: BoxFit.cover),
        AnimatedTextKit(
          repeatForever: true,
          pause: const Duration(seconds: 1),
          animatedTexts: [
            TypewriterAnimatedText('FACTS',
                textAlign: TextAlign.center,
                textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                speed: const Duration(milliseconds: 150)),
          ],
        ),
        SizedBox(
          height: 320,
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
                  child: Container(
                    margin: const EdgeInsets.only(
                        right: 8, left: 8, top: 24, bottom: 12),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(24, 95, 159, 228),
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(width: 2, color: Colors.blue),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: const Offset(
                                0, 1), // changes position of shadow
                          ),
                        ]),
                    child: Center(
                      child: Container(
                          padding: EdgeInsets.all(20),
                          child: sliderTexts[index]),
                    ),
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
            sliderTexts.length,
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
          height: 50,
        ),
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
                final name = element.get('Name');
                final imageURL = element.get('ImageURL');
                final price = element.get('Price');
                final sliderImages = element.get('SliderImages');
                final quantity = element.get('Quantity');
                final description = element.get('Description');
                final features = element.get('Details');
                final units = element.get('Units');

                List<Map<String, dynamic>> details = [
                  {
                    'name': name,
                    'imageURL': imageURL,
                    'price': price,
                    'quantity': quantity,
                    'description': description,
                    'features': features,
                    'sliderImages': sliderImages,
                    'units': units
                  }
                ];
                featuredList.add(details);
              });

              final machineDetails = featuredList.asMap();
              return Column(
                  children: List.generate(machineDetails.length, (index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (_) => SeedsViewPage(
                                  name: machineDetails[index][0]['name'],
                                  imageURL: machineDetails[index][0]
                                      ['imageURL'],
                                  description: machineDetails[index][0]
                                      ['description'],
                                  price: machineDetails[index][0]['price'],
                                  features: machineDetails[index][0]
                                      ['features'],
                                  sliderImages: machineDetails[index][0]
                                      ['sliderImages'],
                                  quantity: machineDetails[index][0]
                                      ['quantity'],
                                  units: machineDetails[index][0]['units'],
                                )));
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
                                        machineDetails[index][0]['imageURL']),
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
                                        Icons.car_repair,
                                        color: Colors.blue,
                                        size: 15,
                                      )),
                                  const SizedBox(width: 10),
                                  SizedBox(
                                    width: 240,
                                    child: Text(
                                        machineDetails[index][0]['name'],
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: SafeGoogleFont('Arial',
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold)),
                                  )
                                ],
                              ),
                              const SizedBox(height: 15),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }));
            }),
      ],
    ));
  }
}
