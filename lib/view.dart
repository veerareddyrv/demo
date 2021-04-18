import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class View extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ViewState();
  }
}

List data = [];
List searchdata = [];
Map<dynamic, dynamic> map;
bool search = false;
TextEditingController searchbox = TextEditingController();

class ViewState extends State {
  void initState() {
    super.initState();
    data.clear();
    searchdata.clear();
    fetch();
  }

  Future<void> fetch() async {
    await FirebaseDatabase.instance
        .reference()
        .child("data")
        .once()
        .then((DataSnapshot snapshot) => {
              map = snapshot.value,
              map.forEach((key, value) {
                data.add(value);
                this.setState(() {});
              })
            });
    searchdata = List.from(data);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: search == false
            ? AppBar(
                title: Text("View Policy"),
                actions: [
                  IconButton(
                      icon: Icon(Icons.search_sharp),
                      onPressed: () {
                        this.setState(() {
                          search = true;
                        });
                      })
                ],
              )
            : AppBar(
                leading: IconButton(
                  icon: Icon(Icons.cancel),
                  onPressed: () {
                    this.setState(() {
                      search = false;
                      searchbox.clear();
                      searchdata = data
                          .where((string) => string["Policy Number"]
                              .toLowerCase()
                              .contains("".toLowerCase()))
                          .toList();
                    });
                  },
                ),
                title: TextField(
                  controller: searchbox,
                  onChanged: (value) {
                    this.setState(() {
                      searchdata = data
                          .where((string) => string["Policy Number"]
                              .toLowerCase()
                              .contains(value.toLowerCase()))
                          .toList();
                    });
                  },
                  decoration: InputDecoration(hintText: "Enter Policy Number"),
                ),
              ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            for (int i = 0; i < searchdata.length; i++)
              (Padding(
                padding: EdgeInsets.all(20),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                      borderOnForeground: true,
                      color: Colors.purple[100],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(3),
                            child: Text("Customer Name : " +
                                searchdata[i]["Customer Name"]),
                          ),
                          Padding(
                            padding: EdgeInsets.all(3),
                            child: Text("Insurance Type : " +
                                searchdata[i]["Insurance Type"]),
                          ),
                          Padding(
                            padding: EdgeInsets.all(3),
                            child: Text("Policy Number : " +
                                searchdata[i]["Policy Number"]),
                          ),
                          Padding(
                            padding: EdgeInsets.all(3),
                            child:
                                Text("Due Date : " + searchdata[i]["Due Date"]),
                          ),
                          Padding(
                            padding: EdgeInsets.all(3),
                            child: Text("Due : " + searchdata[i]["Due"]),
                          ),
                          Padding(
                            padding: EdgeInsets.all(3),
                            child: Text("Mature Date : " +
                                searchdata[i]["Mature Date"]),
                          ),
                          Padding(
                            padding: EdgeInsets.all(3),
                            child: Text("Total Coverage : " +
                                searchdata[i]["Total Coverage"]),
                          ),
                          Padding(
                            padding: EdgeInsets.all(3),
                            child: Text("Total Premium : " +
                                searchdata[i]["Total Premium"]),
                          ),
                        ],
                      )),
                ),
              ))
          ],
        )),
      ),
    );
  }
}
