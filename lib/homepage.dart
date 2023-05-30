import 'package:flutter/material.dart';
import 'package:note_making/input_page.dart';
import 'package:note_making/services.dart';

import 'class_model.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool isloading = true;
  List<Data> data = [];

  fetchdata() async {
    var notesSnapshot = await notesdb.get();
    for (var note in notesSnapshot.docs) {
      Data c = Data.fromJson(note.data());

      data.add(c);
    }
    setState(() {
      isloading = false;
    });
  }

  deletedata({required String uid, required Data node}) async {
    await notesdb.doc(uid).delete();
    data.remove(node);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchdata();
  }

  @override
  Widget build(BuildContext context) {
    return (isloading)
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.amberAccent,
              centerTitle: true,
              title: Text(" Your Notes"),
            ),
            body: ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.amberAccent,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Text("Tittle :"),
                              Text(data[index].title.toString())
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(" Description :"),
                              Text(data[index].description.toString())
                            ],
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              deletedata(
                                  uid: data[index].uid.toString(),
                                  node: data[index]);
                            },
                            icon: Icon(Icons.delete))
                      ],
                    ),
                  ),
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.red,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => InputPage(),
                      ));
                },
                child: Icon(Icons.add)),
          );
  }
}
