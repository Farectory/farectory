// ignore_for_file: non_constant_identifier_names

import 'package:farectory/Model/profile_search_model.dart';
import 'package:flutter/material.dart';

class ProfileSearchScreen extends StatefulWidget {
  const ProfileSearchScreen({super.key});

  @override
  State<ProfileSearchScreen> createState() => _ProfileSearchScreemState();
}

class _ProfileSearchScreemState extends State<ProfileSearchScreen> {
  static List<ProfileModel> featured_profile_list = [
    ProfileModel('Priscilia Magret', 'images/prof1.jpg', 'Lagos, Nigeria',
        '2 years', 'Labourer'),
    ProfileModel('Jessica Helen', 'images/prof2.jpg', 'Kano, Nigeria',
        '2 Months', 'Technician'),
    ProfileModel('Peter Harrison', 'images/prof4.png',
        'Delta, Nigeria', '2 years', 'Technician'),
    ProfileModel('Donald Cater', 'images/prof5.png',
        'FCT Abuja, Nigeria', '2 years', 'Labourer')
  ];

  List<ProfileModel> display_list = List.from(featured_profile_list);

  void updateList(String value) {
    setState(() {
      display_list = featured_profile_list
          .where((element) =>
              element.name!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(0),
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            const SizedBox(height: 25),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Colors.blue,
                    )),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 70,
                  height: 55,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.white),
                  child: TextFormField(
                    autofocus: true,
                    onChanged: (value) => updateList(value),
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Looking for someone?',
                        prefixIcon: Icon(Icons.search)),
                  ),
                )
              ],
            ),
            Expanded(
              child: display_list.isEmpty
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'images/farectory_trans_icon.png',
                            width: 100,
                            height: 100,
                            color: Colors.grey,
                          ),
                          const Text(
                            'User not found',
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                          const SizedBox(height: 150),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: display_list.length,
                      itemBuilder: (context, index) {
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  display_list[index].name!,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(display_list[index].joinedTime!,
                                        style: const TextStyle(
                                            fontSize: 12, color: Colors.grey)),
                                    SizedBox(width: 100),
                                    Text(display_list[index].location!,
                                        style: const TextStyle(
                                            fontSize: 12, color: Colors.grey))
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  display_list[index].accountType!,
                                  style: const TextStyle(
                                      color: Colors.red, fontSize: 10),
                                )
                              ],
                            )
                          ]),
                        );
                      }),
            )
          ],
        ),
      ),
    );
  }
}
