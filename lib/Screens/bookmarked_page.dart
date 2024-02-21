import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BookmarkHistory extends StatefulWidget {
  const BookmarkHistory({super.key});

  @override
  State<BookmarkHistory> createState() => _BookmarkHistoryState();
}

class _BookmarkHistoryState extends State<BookmarkHistory> {
  @override
  Widget build(BuildContext context) {
    final bookmark = FirebaseFirestore.instance
        .collection('Bookmark')
        .doc(FirebaseAuth.instance.currentUser!.email).collection('Bookmarked').snapshots();

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          title: const Text(
            'Bookmark History',
          ),
          leading: null,
        ),
        body: bookmark.isEmpty == true ? const Empty() : const DocumentList());
  }
}

class DocumentList extends StatefulWidget {
  const DocumentList({super.key});

  @override
  State<DocumentList> createState() => _DocumentListState();
}

class _DocumentListState extends State<DocumentList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance
          .collection('Bookmark')
          .doc(FirebaseAuth.instance.currentUser?.email)
          .collection('Bookmarked')
          .get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          // Extract and save fields from each document into strings
          List documentFields = [];
          snapshot.data!.docs.forEach((element) {
            final profileName = element.get('Name');
            final imageURL = element.get('ImageURL');
            final location = element.get('Location');
            final workExperience = element.get('WorkExperience');
            // Add more fields as needed

            List<Map<String, dynamic>> details = [
              {
                'profileName': profileName,
                'imageURL': imageURL,
                'location': location,
                'workExperience': workExperience,
              }
            ];
            documentFields.add(details);
          });
          final myValues = documentFields.asMap();

          // Display the list of strings
          return ListView.builder(
              itemCount: myValues.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  padding: const EdgeInsets.fromLTRB(5, 15, 5, 15),
                  child: Row(children: [
                    // Image
                    Padding(
                      padding: const EdgeInsets.only(right: 14.0),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        child: Image.network(
                          '${myValues[index][0]['imageURL']}',
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
                            '${myValues[index][0]['profileName']}',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(Icons.work, color: Colors.grey),
                              Text(myValues[index][0]['workExperience']),
                              Icon(Icons.location_on, color: Colors.grey),
                              Text(myValues[index][0]['location'])
                            ],
                          ),
                        ],
                      ),
                    )
                  ]),
                );
              });
        }
      },
    );
  }
}

class Empty extends StatelessWidget {
  const Empty({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'images/farectory_trans_icon.png',
            height: 150,
            width: 150,
            color: Colors.grey,
          ),
          const SizedBox(height: 30),
          const Text(
            'No bookmarks yet',
            style: TextStyle(color: Colors.grey, fontSize: 14),
          )
        ],
      ),
    );
  }
}
