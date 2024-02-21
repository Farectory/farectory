import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:farectory/Model/bar_chart_model.dart';
import 'package:farectory/Screens/user_profile_page.dart';
import 'package:farectory/Utils/safe_google_font.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  late final PageController pageController;
  int pageNo = 0;
  Timer? carasouelTmer;
  int _counter = 12;
  int deadChild = 0;
  late Timer _timer;

  List<Widget> sliderImages = [
    Image.asset(
      'images/hunger.png',
      fit: BoxFit.contain,
    ),
    Image.asset('images/hunger2.jpg', fit: BoxFit.contain),
    Image.asset('images/hunger1.png', fit: BoxFit.contain),
    Image.asset('images/hunger4.jpg', fit: BoxFit.contain),
    Image.asset('images/hunger3.jpg', fit: BoxFit.contain),
  ];

  bool isMaizeContinet = true;
  bool isMaizeAfrica = true;
  bool isMaizeWorld = true;
  bool isRiceContinet = true;
  bool isRiceAfrica = true;
  bool isRiceWorld = true;

  List<BarChartData> data = [
    BarChartData(
      country: 'Sudan',
      hectares: 112664841,
      color: charts.ColorUtil.fromDartColor(Colors.blueGrey),
    ),
    BarChartData(
        country: 'South Africa',
        hectares: 96341963,
        color: charts.ColorUtil.fromDartColor(Colors.yellow)),
    BarChartData(
        country: 'Nigeria',
        hectares: 68644686,
        color: charts.ColorUtil.fromDartColor(Colors.deepPurple)),
    BarChartData(
        country: 'Chad',
        hectares: 50338503,
        color: charts.ColorUtil.fromDartColor(Colors.cyan)),
    BarChartData(
        country: 'Niger',
        hectares: 46595465,
        color: charts.ColorUtil.fromDartColor(Colors.cyan)),
    BarChartData(
        country: 'Angola',
        hectares: 45897458,
        color: charts.ColorUtil.fromDartColor(Colors.cyan)),
    BarChartData(
        country: 'Somalia',
        hectares: 44129441,
        color: charts.ColorUtil.fromDartColor(Colors.cyan)),
    BarChartData(
        country: 'Mali',
        hectares: 43131431,
        color: charts.ColorUtil.fromDartColor(Colors.cyan)),
    BarChartData(
        country: 'Mozambique',
        hectares: 41413834,
        color: charts.ColorUtil.fromDartColor(Colors.cyan)),
    BarChartData(
        country: 'Algeria',
        hectares: 41316074,
        color: charts.ColorUtil.fromDartColor(Colors.cyan)),
  ];

  Map<String, double> maizeDataMapContinent = {
    "Africa": 96637310,
    "Antartica": 18.47,
    "Asia": 378856400,
    "Europe": 141847700,
    "North America": 430073800,
    "Oceania": 537422,
    "South America": 162282560,
  };

  Map<String, double> maizeDataMapAfrica = {
    "Angola": 2970208,
    "Egypt": 7500000,
    "Ethiopia": 10722000,
    "Ghana": 3500000,
    "Kenya": 3303000,
    "Malawi": 4581000,
    "Mali": 3603000,
    "Nigeria": 12745000,
    "South Africa": 16870704,
    "Tanzania": 7039000,
  };

  Map<String, double> maizeDataMapWorld = {
    "United States": 383943000,
    "China": 272552000,
    "Brazil": 88461944,
    "Argentina": 60525804,
    "Ukraine": 42109850,
    "India": 31650000,
    "Mexico": 27503478,
    "Indonesia": 20010000,
    "South Africa": 16870704,
    "France": 15358300,
  };

  Map<String, double> riceDataMapContinent = {
    "Africa": 37188988,
    "Antartica": 10,
    "Asia": 708148400,
    "Europe": 3783854,
    "North America": 11519472,
    "Oceania": 437147,
    "South America": 26215990,
  };

  Map<String, double> riceDataMapAfrica = {
    "Nigeria": 8342000,
    "Egypt": 4841327,
    "Madagascar": 4391386,
    "Tanzania": 2688000,
    "Guinea": 2475325,
    "Mali": 2420245,
    "Sierra Leone": 1978905,
    "Cote d'Ivoire": 1659000,
    "DR Congo": 1580620,
    "Senegal": 1382120,
  };

  Map<String, double> riceDataMapWorld = {
    "China": 212843000,
    "India": 195425000,
    "Bangladesh": 56944550,
    "Indonesia": 54415296,
    "Vietnam": 43852730,
    "Thailand": 33582000,
    "Myanmar": 24910000,
    "Philippines": 19960170,
    "Pakistan": 13984009,
    "Brazil": 11660603,
  };

  List<Color> colorList = [
    const Color(0xffD95AF3),
    const Color(0xff3EE094),
    const Color(0xff3398F6),
    const Color(0xffFA4A42),
    const Color(0xffFE9539),
    const Color.fromARGB(255, 188, 149, 147),
    const Color.fromARGB(207, 244, 241, 48)
  ];

  List<Color> colorList1 = [
    const Color(0xffD95AF3),
    const Color(0xff3EE094),
    const Color.fromARGB(255, 243, 243, 243),
    const Color.fromARGB(255, 29, 238, 231),
    const Color(0xff3398F6),
    const Color(0xffFA4A42),
    const Color.fromARGB(255, 234, 17, 17),
    const Color(0xffFE9539),
    const Color.fromARGB(255, 188, 149, 147),
    const Color.fromARGB(207, 244, 241, 48)
  ];

  Timer getTimer() {
    return Timer.periodic(const Duration(seconds: 3), (timer) {
      if (pageNo == 5) {
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

  void _startTimer() {
    _counter = 13;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_counter > 0) {
        setState(() {
          _counter--;
        });
      } else {
        _timer.cancel();
        deadChild++;
        _startTimer();
      }
    });
  }

  @override
  void initState() {
    pageController = PageController(initialPage: 0, viewportFraction: 0.85);
    carasouelTmer = getTimer();
    _startTimer();

    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    final firstName =
        FirebaseAuth.instance.currentUser!.displayName?.split(' ')[0];
    List<charts.Series<BarChartData, String>> series = [
      charts.Series(
        id: "countries",
        data: data,
        overlaySeries: true,
        domainFn: (BarChartData series, _) => series.country,
        measureFn: (BarChartData series, _) => series.hectares,
        colorFn: (BarChartData series, _) => series.color,
      ),
    ];
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            floating: true,
            toolbarHeight: 55,
            leading: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (_) => const UserProfilePage()));
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 6,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image(
                      image: NetworkImage(FirebaseAuth
                              .instance.currentUser?.photoURL ??
                          'https://cobaltsettlements.com/wp-content/uploads/2019/03/blank-profile.jpg'),
                      height: 35.0,
                      fit: BoxFit.cover,
                      width: 35.0,
                    ),
                  ),
                ],
              ),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            shape: const ContinuousRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
            pinned: true,
            expandedHeight: MediaQuery.of(context).size.height * 0.8,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(50),
                  )),
              child: FlexibleSpaceBar(
                background: Lottie.asset('images/appbar_animation.json'),
                title: Row(
                  children: [
                    Lottie.asset('images/welcome_animation.json', height: 20),
                    SizedBox(width: 7),
                    Text(
                      '$firstName',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(15),
                child: Center(
                  child: SizedBox(
                    height: 200,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'WE',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'ARE...',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.amber,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        SizedBox(
                            width: 80,
                            height: 140,
                            child: Image.asset(
                              'images/farectory_splash.png',
                              fit: BoxFit.cover,
                            )),
                        const SizedBox(width: 5.0),
                        DefaultTextStyle(
                          style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: Color.fromARGB(255, 103, 182, 247),
                            fontWeight: FontWeight.bold,
                            fontSize: 40.0,
                            fontFamily: 'Horizon',
                          ),
                          child: AnimatedTextKit(
                            pause: const Duration(milliseconds: 0),
                            repeatForever: true,
                            animatedTexts: [
                              RotateAnimatedText('AST'),
                              RotateAnimatedText('ERTILE'),
                              RotateAnimatedText('EROCIOUS'),
                              RotateAnimatedText('EARLESS'),
                              RotateAnimatedText('ORMIDABLE',
                                  textStyle: const TextStyle(fontSize: 35)),
                              RotateAnimatedText('ARECTORY',
                                  transitionHeight: 50,
                                  duration: const Duration(seconds: 8),
                                  textStyle: const TextStyle(
                                      fontSize: 40,
                                      color: Colors.blue))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 250,
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
                    itemCount: 5),
              ),
              const SizedBox(
                height: 12.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  5,
                  (index) => GestureDetector(
                    child: Container(
                      margin: const EdgeInsets.all(2.0),
                      child: Icon(
                        Icons.circle,
                        size: 12.0,
                        color: pageNo == index
                            ? Colors.blue
                            : Colors.grey.shade300,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Container(
                margin: const EdgeInsets.all(5),
                child: const Text('The agro-industry in data (2021)...',
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 35)),
              ),
              Text('PRODUCTION',
                  textAlign: TextAlign.center,
                  style: SafeGoogleFont('Lato',
                      color: Colors.grey,
                      fontSize: 28,
                      fontWeight: FontWeight.bold)),
              Container(
                  padding: const EdgeInsets.fromLTRB(30, 5, 20, 5),
                  margin: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(24, 95, 159, 228),
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Switch(
                              value: isMaizeContinet,
                              onChanged: (value) {
                                setState(() {
                                  isMaizeContinet = value;
                                });
                              })
                        ],
                      ),
                      const SizedBox(height: 5),
                      Visibility(
                          visible: isMaizeContinet,
                          child: Column(
                            children: [
                              Text(
                                'MAIZE PRODUCTION BY CONTINENT',
                                style: SafeGoogleFont('Lato',
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 25),
                              PieChart(
                                dataMap: maizeDataMapContinent,
                                chartType: ChartType.ring,
                                colorList: colorList,
                                chartRadius:
                                    MediaQuery.of(context).size.width * 0.4,
                                ringStrokeWidth: 45,
                                animationDuration: const Duration(seconds: 3),
                                chartValuesOptions: const ChartValuesOptions(
                                    showChartValues: true,
                                    showChartValuesOutside: true,
                                    showChartValuesInPercentage: true,
                                    showChartValueBackground: false),
                                legendOptions: const LegendOptions(
                                    showLegends: true,
                                    legendShape: BoxShape.rectangle,
                                    legendTextStyle: TextStyle(fontSize: 15),
                                    showLegendsInRow: false),
                              ),
                            ],
                          ))
                    ],
                  )),
              const SizedBox(height: 30),
              Container(
                  padding: const EdgeInsets.fromLTRB(30, 5, 20, 5),
                  margin: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(24, 95, 159, 228),
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Switch(
                              value: isMaizeAfrica,
                              onChanged: (value) {
                                setState(() {
                                  isMaizeAfrica = value;
                                });
                              })
                        ],
                      ),
                      const SizedBox(height: 5),
                      Visibility(
                          visible: isMaizeAfrica,
                          child: Column(
                            children: [
                              Text(
                                'TOP 10 MAIZE PRODUCING COUNTRIES IN AFRICA',
                                style: SafeGoogleFont('Lato',
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 25),
                              PieChart(
                                dataMap: maizeDataMapAfrica,
                                chartType: ChartType.ring,
                                colorList: colorList1,
                                chartRadius:
                                    MediaQuery.of(context).size.width * 0.4,
                                ringStrokeWidth: 45,
                                animationDuration: const Duration(seconds: 3),
                                chartValuesOptions: const ChartValuesOptions(
                                    showChartValues: true,
                                    showChartValuesOutside: true,
                                    showChartValuesInPercentage: true,
                                    showChartValueBackground: false),
                                legendOptions: const LegendOptions(
                                    showLegends: true,
                                    legendShape: BoxShape.circle,
                                    legendTextStyle: TextStyle(fontSize: 15),
                                    showLegendsInRow: false),
                              ),
                            ],
                          )),
                    ],
                  )),
              const SizedBox(height: 30),
              Container(
                  padding: const EdgeInsets.fromLTRB(30, 5, 20, 5),
                  margin: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(24, 95, 159, 228),
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Switch(
                            value: isMaizeWorld,
                            onChanged: (value) {
                              setState(() {
                                isMaizeWorld = value;
                              });
                            })
                      ],
                    ),
                    const SizedBox(height: 5),
                    Visibility(
                        visible: isMaizeWorld,
                        child: Column(
                          children: [
                            Text(
                              'TOP 10 MAIZE PRODUCING COUNTRIES IN THE WORLD',
                              style: SafeGoogleFont('Lato',
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 25),
                            PieChart(
                              dataMap: maizeDataMapWorld,
                              chartType: ChartType.ring,
                              colorList: colorList1,
                              chartRadius:
                                  MediaQuery.of(context).size.width * 0.4,
                              ringStrokeWidth: 45,
                              animationDuration: const Duration(seconds: 3),
                              chartValuesOptions: const ChartValuesOptions(
                                  showChartValues: true,
                                  showChartValuesOutside: true,
                                  showChartValuesInPercentage: true,
                                  showChartValueBackground: false),
                              legendOptions: const LegendOptions(
                                  showLegends: true,
                                  legendShape: BoxShape.circle,
                                  legendTextStyle: TextStyle(fontSize: 15),
                                  showLegendsInRow: false),
                            ),
                          ],
                        ))
                  ])),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text('AFRICAN COUNTRIES WITH THE MOST ARABLE LANDS (in hectares)',
                style: TextStyle(fontWeight: FontWeight.bold,
                fontSize: 23),),
              ),
              Container(
                              height: 500,
                              width: double.infinity,
                              padding: const EdgeInsets.all(10),
                              child: charts.BarChart(
              series,
              animate: true,
              vertical: false,
                              ),
                            ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text('Did you know',
                    style: SafeGoogleFont('Heebo',
                        fontSize: 30, color: Colors.redAccent)),
                Text('?',
                    style: SafeGoogleFont('Heebo',
                        fontSize: 50,
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold))
              ]),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 3),
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                ),
                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(
                          height: 60,
                          width: 50,
                          child: Image.asset(
                            'images/hand.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                            width: 230,
                            child: AnimatedTextKit(
                                pause: const Duration(seconds: 20),
                                animatedTexts: [
                                  TypewriterAnimatedText(
                                      'Every year, approximately 3.1 million children die worldwide as a result of hunger. That is approximately 1 child death every 12 seconds',
                                      textStyle:
                                          SafeGoogleFont('Heebo', fontSize: 18),
                                      speed: const Duration(milliseconds: 75))
                                ])),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Text(
                        '$deadChild child(ren) have died since you logged in to this app... And another will die in',
                        style: SafeGoogleFont('Heebo', fontSize: 18)),
                    Text(
                      '$_counter',
                      style: GoogleFonts.alexandria(
                          color: Colors.redAccent,
                          fontSize: 90,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                        'What are you waiting for??? Reach out to us now and we will help you contribute your quota to humanity tod',
                        style: SafeGoogleFont('Heebo', fontSize: 18))
                  ],
                ),
              ),
              Container(
                  padding: const EdgeInsets.fromLTRB(30, 5, 20, 5),
                  margin: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(24, 95, 159, 228),
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Switch(
                              value: isRiceContinet,
                              onChanged: (value) {
                                setState(() {
                                  isRiceContinet = value;
                                });
                              })
                        ],
                      ),
                      const SizedBox(height: 5),
                      Visibility(
                          visible: isRiceContinet,
                          child: Column(
                            children: [
                              Text(
                                'RICE PRODUCTION BY CONTINENT',
                                style: SafeGoogleFont('Lato',
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 25),
                              PieChart(
                                dataMap: riceDataMapContinent,
                                chartType: ChartType.ring,
                                colorList: colorList,
                                chartRadius:
                                    MediaQuery.of(context).size.width * 0.4,
                                ringStrokeWidth: 45,
                                animationDuration: const Duration(seconds: 3),
                                chartValuesOptions: const ChartValuesOptions(
                                    showChartValues: true,
                                    showChartValuesOutside: true,
                                    showChartValuesInPercentage: true,
                                    showChartValueBackground: false),
                                legendOptions: const LegendOptions(
                                    showLegends: true,
                                    legendShape: BoxShape.rectangle,
                                    legendTextStyle: TextStyle(fontSize: 15),
                                    showLegendsInRow: false),
                              ),
                            ],
                          ))
                    ],
                  )),
              const SizedBox(height: 30),
              Container(
                  padding: const EdgeInsets.fromLTRB(30, 5, 20, 5),
                  margin: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(24, 95, 159, 228),
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Switch(
                              value: isRiceAfrica,
                              onChanged: (value) {
                                setState(() {
                                  isRiceAfrica = value;
                                });
                              })
                        ],
                      ),
                      const SizedBox(height: 5),
                      Visibility(
                          visible: isRiceAfrica,
                          child: Column(
                            children: [
                              Text(
                                'TOP 10 RICE PRODUCING COUNTRIES IN AFRICA',
                                style: SafeGoogleFont('Lato',
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 25),
                              PieChart(
                                dataMap: riceDataMapAfrica,
                                chartType: ChartType.ring,
                                colorList: colorList1,
                                chartRadius:
                                    MediaQuery.of(context).size.width * 0.4,
                                ringStrokeWidth: 45,
                                animationDuration: const Duration(seconds: 3),
                                chartValuesOptions: const ChartValuesOptions(
                                    showChartValues: true,
                                    showChartValuesOutside: true,
                                    showChartValuesInPercentage: true,
                                    showChartValueBackground: false),
                                legendOptions: const LegendOptions(
                                    showLegends: true,
                                    legendShape: BoxShape.circle,
                                    legendTextStyle: TextStyle(fontSize: 15),
                                    showLegendsInRow: false),
                              ),
                            ],
                          )),
                    ],
                  )),
              const SizedBox(height: 30),
              Container(
                  padding: const EdgeInsets.fromLTRB(30, 5, 20, 5),
                  margin: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(24, 95, 159, 228),
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Switch(
                            value: isRiceWorld,
                            onChanged: (value) {
                              setState(() {
                                isRiceWorld = value;
                              });
                            })
                      ],
                    ),
                    const SizedBox(height: 5),
                    Visibility(
                        visible: isRiceWorld,
                        child: Column(
                          children: [
                            Text(
                              'TOP 10 RICE PRODUCING COUNTRIES IN THE WORLD',
                              style: SafeGoogleFont('Lato',
                                  fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 25),
                            PieChart(
                              dataMap: riceDataMapWorld,
                              chartType: ChartType.ring,
                              colorList: colorList1,
                              chartRadius:
                                  MediaQuery.of(context).size.width * 0.4,
                              ringStrokeWidth: 45,
                              animationDuration: const Duration(seconds: 3),
                              chartValuesOptions: const ChartValuesOptions(
                                  showChartValues: true,
                                  showChartValuesOutside: true,
                                  showChartValuesInPercentage: true,
                                  showChartValueBackground: false),
                              legendOptions: const LegendOptions(
                                  showLegends: true,
                                  legendShape: BoxShape.circle,
                                  legendTextStyle: TextStyle(fontSize: 15),
                                  showLegendsInRow: false),
                            ),
                          ],
                        ))
                  ]))
            ],
          ),
        ),
      ),
    );
  }
}
