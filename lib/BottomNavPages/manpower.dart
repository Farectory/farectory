import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farectory/Model/profile_search_model.dart';
import 'package:farectory/Screens/bookmarked_page.dart';
import 'package:farectory/Screens/profile_search_screen.dart';
import 'package:farectory/Screens/profile_view.dart';
import 'package:farectory/Utils/safe_google_font.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ManPower extends StatefulWidget {
  const ManPower({super.key});

  @override
  State<ManPower> createState() => _ManPowerState();
}

class _ManPowerState extends State<ManPower> {
  ScrollController scrollController = ScrollController();
  IconData bookmark = Icons.bookmark_add_outlined;
  String image = 'images/iphone.png';
  String name = 'Oral Roboerts Michael Jre';
  String profileDescription =
      'Roboerts, a seasoned farmer with weathered hands and a heart deeply rooted in the land, embodies the epitome of agricultural resilience. With unwavering dedication, he tends to his crops, nurturing each seedling with meticulous care. From dawn till dusk, amidst the verdant fields, he orchestrates the symphony of nature, harmonizing with the earth\'s rhythm. His weathered face bears witness to countless seasons, each etching a story of perseverance and triumph. Beyond the toil and sweat lies a profound connection to the soil, a testament to his unwavering commitment to feed the world and cultivate a sustainable legacy for generations to come.';
  static List<ProfileModel> featured_profile_list = [
    ProfileModel('Priscilia Magret', 'images/prof1.jpg', 'Lagos, Nigeria',
        '2 years', 'Labourer'),
    ProfileModel('Jessica Helen', 'images/prof2.jpg', 'Kano, Nigeria',
        '2 Months', 'Labourer'),
    ProfileModel('Peter Harrison', 'images/prof4.png', 'Delta, Nigeria',
        '2 years', 'Labourer'),
    ProfileModel('Donald Cater', 'images/prof5.png', 'FCT Abuja, Nigeria',
        '2 years', 'Labourer')
  ];

  List<ProfileModel> display_list = List.from(featured_profile_list);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(
                  bottom: 10, top: 38, left: 15, right: 15),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                  color: Colors.blue),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (_) => const BookmarkHistory()));
                        },
                        icon: Icon(
                          Icons.bookmarks,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      Icon(
                        Icons.notifications,
                        color: Colors.white,
                        size: 30,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 55,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Colors.white),
                    child: TextFormField(
                      readOnly: true,
                      onTap: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (_) => const ProfileSearchScreen()));
                      },
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Looking for someone?',
                          prefixIcon: Icon(Icons.search)),
                    ),
                  )
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Who to hire?',
                        style: SafeGoogleFont('Arial', fontSize: 23),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (scrollController.hasClients) {
                                scrollController.animateTo(-10,
                                    duration: Duration(seconds: 1),
                                    curve: Curves.easeIn);
                              }
                            },
                            child: CircleAvatar(
                                backgroundColor: Colors.blue,
                                radius: MediaQuery.of(context).size.width / 7.5,
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.person_4,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                    Text(
                                      'Labourers',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                )),
                          ),
                          CircleAvatar(
                              backgroundColor:
                                  const Color.fromARGB(255, 141, 194, 238),
                              radius: MediaQuery.of(context).size.width / 7.5,
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.car_repair,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  Text(
                                    'Technicians',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              )),
                        ],
                      )
                    ])),
            SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(60)),
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.blue, Colors.white, Colors.blue])),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 35,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'Featured profiles',
                        style: SafeGoogleFont('Cambri',
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('FeaturedProfiles')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                              child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white)));
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        }

                        List featuredList = [];
                        snapshot.data!.docs.forEach((element) {
                          final profileName = element.get('Name');
                          final imageURL = element.get('ImageURL');
                          final profileDescription = element.get('Description');
                          final gender = element.get('Gender');
                          final location = element.get('Location');
                          final workExperience = element.get('WorkExperience');
                          final userID = element.get('UserID');

                          List<Map<String, dynamic>> details = [
                            {
                              'profileName': profileName,
                              'imageURL': imageURL,
                              'profileDescription': profileDescription,
                              'gender': gender,
                              'location': location,
                              'workExperience': workExperience,
                              'userID': userID,
                            }
                          ];
                          featuredList.add(details);
                        });

                        final userValues = featuredList.asMap();
                        return Column(
                          children: List.generate(userValues.length, (index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (_) => ProfileViewPage(
                                              profileName: userValues[index][0]
                                                  ['profileName'],
                                              imagePath: userValues[index][0]
                                                  ['imageURL'],
                                              bio: userValues[index][0]
                                                  ['profileDescription'],
                                              userID: userValues[index][0]
                                                  ['userID'],
                                              workExperience: userValues[index]
                                                  [0]['workExperience'],
                                              location: userValues[index][0]
                                                  ['location'],
                                            )));
                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom: 30, top: 20),
                                width: MediaQuery.of(context).size.width * 0.9,
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(40)),
                                    color: Colors.white),
                                child: Column(
                                  children: [
                                    ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(40),
                                          topRight: Radius.circular(40),
                                        ),
                                        child: Stack(
                                            fit: StackFit.passthrough,
                                            children: [
                                              Container(
                                                height: 250,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                  image: NetworkImage(
                                                      userValues[index][0]
                                                          ['imageURL']),
                                                  fit: BoxFit.cover,
                                                )),
                                              ),
                                            ])),
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
                                                  backgroundColor: Colors.blue,
                                                  radius: 20,
                                                  child: Icon(
                                                    Icons.person_4,
                                                    color: Colors.white,
                                                    size: 15,
                                                  )),
                                              const SizedBox(width: 10),
                                              SizedBox(
                                                width: 250,
                                                child: Text(
                                                    userValues[index][0]
                                                        ['profileName'],
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: SafeGoogleFont(
                                                        'Arial',
                                                        fontSize: 25,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              )
                                            ],
                                          ),
                                          const SizedBox(height: 15),
                                          Text(
                                              userValues[index][0]
                                                  ['profileDescription'],
                                              maxLines: 5,
                                              overflow: TextOverflow.ellipsis,
                                              style: SafeGoogleFont('Arial',
                                                  fontSize: 16)),
                                          const SizedBox(height: 13),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Icon(Icons.work,
                                                  color: Colors.grey),
                                              Text(userValues[index][0]
                                                  ['workExperience']),
                                              Icon(Icons.person,
                                                  color: Colors.grey),
                                              Text(userValues[index][0]
                                                  ['gender']),
                                              Icon(Icons.location_on,
                                                  color: Colors.grey),
                                              Text(userValues[index][0]
                                                  ['location'])
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        );
                      }),
                ],
              ),
            ),
            const SizedBox(height: 30),
            const Text('LABOURERS',
                style: TextStyle(color: Colors.blue, fontSize: 30)),
            Container(
                padding: const EdgeInsets.all(3),
                child: Column(
                  children: [
                    Column(
                      children: List.generate(display_list.length, (index) {
                        return Container(
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          padding: const EdgeInsets.fromLTRB(5, 15, 5, 15),
                          child: Row(children: [
                            // Image
                            Padding(
                              padding: const EdgeInsets.only(right: 14.0),
                              child: ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5)),
                                child: Image.asset(
                                  display_list[index].imagePath!,
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    display_list[index].name!,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(display_list[index].joinedTime!,
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey)),
                                      Text(display_list[index].location!,
                                          style: TextStyle(
                                              fontSize: 12, color: Colors.grey))
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    display_list[index].accountType!,
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 10),
                                  )
                                ],
                              ),
                            )
                          ]),
                        );
                      }),
                    ),
                  ],
                )),
            const SizedBox(height: 30),
            const Text('TECHNICIANS',
                style: TextStyle(
                    color: Color.fromARGB(255, 141, 194, 238), fontSize: 30)),
            Container(
                padding: const EdgeInsets.all(3),
                child: Column(
                  children: [
                    Column(
                      children: List.generate(display_list.length, (index) {
                        return Container(
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          padding: const EdgeInsets.fromLTRB(5, 15, 5, 15),
                          child: Row(children: [
                            // Image
                            Padding(
                              padding: const EdgeInsets.only(right: 14.0),
                              child: ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5)),
                                child: Image.asset(
                                  display_list[index].imagePath!,
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    display_list[index].name!,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(display_list[index].joinedTime!,
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey)),
                                      Text(display_list[index].location!,
                                          style: TextStyle(
                                              fontSize: 12, color: Colors.grey))
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    display_list[index].accountType!,
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 10),
                                  )
                                ],
                              ),
                            )
                          ]),
                        );
                      }),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
