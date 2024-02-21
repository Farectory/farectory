import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farectory/Screens/machineries_view_page.dart';
import 'package:farectory/Utils/safe_google_font.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MachineriesPage extends StatefulWidget {
  const MachineriesPage({super.key});

  @override
  State<MachineriesPage> createState() => _MachineriesPageState();
}

class _MachineriesPageState extends State<MachineriesPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        Stack(fit: StackFit.passthrough, children: [
          Lottie.asset('images/machine.json', height: 200),
        ]),
        FutureBuilder<QuerySnapshot>(
            future: FirebaseFirestore.instance.collection('Machineries').get(),
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
                final brand = element.get('Brand');
                final description = element.get('Description');
                final features = element.get('Details');
                final units = element.get('Units');

                List<Map<String, dynamic>> details = [
                  {
                    'name': name,
                    'imageURL': imageURL,
                    'price': price,
                    'brand': brand,
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
                                        builder: (_) => MachineriesViewPage(
                                              name: machineDetails[index][0]['name'],
                                              imageURL: machineDetails[index][0]['imageURL'],
                                              description: machineDetails[index][0]['description'],
                                              price: machineDetails[index][0]['price'],
                                              features: machineDetails[index][0]['features'],
                                              sliderImages: machineDetails[index][0]['sliderImages'],
                                              brand: machineDetails[index][0]['brand'],
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
                                    child: Text(machineDetails[index][0]['name'],
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
