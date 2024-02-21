import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LandsViewPage extends StatefulWidget {
  const LandsViewPage({super.key});

  @override
  State<LandsViewPage> createState() => _LandsViewPageState();
}

class _LandsViewPageState extends State<LandsViewPage> {
   late final PageController pageController;
  int pageNo = 0;
  Timer? carasouelTmer;

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
    Image.network(
      'https://media.istockphoto.com/id/522961501/photo/picturesque-landscape-fenced-ranch-at-sunrise.jpg?s=612x612&w=0&k=20&c=Jn4ujmVfUNUCejnoE3QJ2n9tV6bhjiYtA706dtJemOY=',
      fit: BoxFit.cover,
    ),
    Image.asset('images/farm3.png', fit: BoxFit.cover),
    Image.asset('images/farm.png', fit: BoxFit.cover),
  ];

  @override
  void initState() {
    pageController = PageController(initialPage: 0, viewportFraction: 1);
    carasouelTmer = getTimer();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.close), color: Colors.white,),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                            child: sliderImages[index],
                          )),
                    ),
                  );
                },
                itemCount: 3),
          ),
          SizedBox(height: 15,),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(50),
              topRight: Radius.circular(50)),
              border: Border.all(width: 2, color: Colors.blue),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset:
                                const Offset(0, 1), // changes position of shadow
                          ),]
            ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text('Agriculture, humanity\'s foundational endeavor, nurtures life and sustains civilizations. Rooted in the earth\'s embrace, it embodies resilience and abundance. Agriculture intertwines nature\'s rhythm with human ingenuity, cultivating sustenance from soil and sunlight. It births vitality, nourishing bodies and communities, fostering growth and prosperity. Across ages, it evolves, embracing innovation while honoring tradition. Agriculture, a harmonious dance of labor and land, yields nourishment for body and soul, connecting past, present, and future. It\'s a testament to humanity\'s symbiotic relationship with the earth, embodying resilience, nourishment, and the eternal cycle of life.',
                    style: TextStyle(fontSize: 17),),
                    SizedBox(height: 20,),
                    Text('Soil Profile',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                    ),),
                    Container(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text('Size', style: TextStyle(fontSize: 17),)
                                ],
                              ),
                              Text('300 hectares')

                          ],),
                          SizedBox(height: 8,),
                          Text('Climatic factors', style: TextStyle(fontSize: 17),),
                          SizedBox(height: 8,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: 20),
                                  Icon(FontAwesomeIcons.temperatureEmpty),
                                  SizedBox(width: 15),
                                  Text('Average temperature')
                                ],
                              ),
                              Text('35° C')

                          ],),
                          SizedBox(height: 8,),
                           Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: 20),
                                  Icon(FontAwesomeIcons.cloudRain),
                                  SizedBox(width: 15),
                                  Text('Rainfall per anum')
                                ],
                              ),
                              Text('117 cm')

                          ],),
                          SizedBox(height: 8,),
                          Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: 20),
                                  Icon(FontAwesomeIcons.cloudSun),
                                  SizedBox(width: 15),
                                  Text('Sunshine hours')
                                ],
                              ),
                              Text('13 hours')

                          ],),
                          SizedBox(height: 8,),
                          Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: 20),
                                  Icon(FontAwesomeIcons.cloud),
                                  SizedBox(width: 15),
                                  Text('Relative humidity')
                                ],
                              ),
                              Text('87%')
                          ]),
                          SizedBox(height: 8,),
                          Text('Edaphic Factors', style: TextStyle(fontSize: 17),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: 20),
                                  Icon(Icons.landscape_outlined),
                                  SizedBox(width: 15),
                                  Text('Soil Type')
                                ],
                              ),
                              Text('Loamy')

                          ],),
                          SizedBox(height: 8,),
                           Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: 20),
                                  Icon(FontAwesomeIcons.bacteria),
                                  SizedBox(width: 15),
                                  Text('Soil pH')
                                ],
                              ),
                              Text('7.8')

                          ],),
                          SizedBox(height: 8,),
                          Text('Soil Fertility', style: TextStyle(fontSize: 17),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: 20,),
                                  Text('Calcium')
                                ],
                              ),
                              Text('3.8µmp'),
                              
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: 20,),
                                  Text('Nitrogen')
                                ],
                              ),
                              Text('112g'),
                              
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: 20,),
                                  Text('Magnesium')
                                ],
                              ),
                              Text('13.5mg'),
                              
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: 20,),
                                  Text('Pottassium')
                                ],
                              ),
                              Text('45µmg'),
                              
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: 20,),
                                  Text('Calcium')
                                ],
                              ),
                              Text('3.8µmp'),
                              
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                )),
                Text('Crop Recommendations',
                 style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold
                    ),),
                     Container(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Text('Maize'),
                                Text('Rice'),
                                Text('Corn'),
                                  Text('Yam'),
                              ],
                            ))
                        ]))
            ],
          ),
          ),
          ],
        ),
      ),
    );
  }
}
