import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:random_string/random_string.dart';
import 'package:toast/toast.dart';

class Add extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddState();
  }
}

int it = 0, due = 0;
TextEditingController policy = TextEditingController(
    text: randomAlpha(3).toUpperCase() + randomNumeric(9));
TextEditingController name = TextEditingController();
String nameerror;
TextEditingController total = TextEditingController();
String totalerror;
TextEditingController pamount = TextEditingController();
String pamounterror;
TextEditingController ddate = TextEditingController();
String ddateerror;
TextEditingController mdate = TextEditingController();
String mdateerror;
String policynumber,
    customername,
    insurancetype,
    totalcoverage,
    premiumamount,
    duedate,
    maturedate,
    duepaid;
String error = "", error1 = "";

class AddState extends State {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Add Policy"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: policy,
                    enabled: false,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Policy Number',
                        hintText: 'Enter a Policy Number'),
                  )),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: name,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        errorText: nameerror,
                        labelText: 'Customer Name',
                        hintText: 'Enter a Customer Name'),
                  )),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.grey)),
                      child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                              dropdownColor: Colors.white,
                              isExpanded: true,
                              value: it,
                              items: [
                                DropdownMenuItem(
                                  child: Text("Select insurance policy type",
                                      style: TextStyle()),
                                  value: 0,
                                ),
                                DropdownMenuItem(
                                  child: Text("Vehical Insurance"),
                                  value: 1,
                                ),
                                DropdownMenuItem(
                                  child: Text("Life Insurance"),
                                  value: 2,
                                ),
                                DropdownMenuItem(
                                  child: Text("Gold Insurance"),
                                  value: 3,
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  it = value;
                                });
                              })))),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  error,
                  style: TextStyle(color: Colors.red),
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: total,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        errorText: totalerror,
                        labelText: 'Total Coverage Amount',
                        hintText: 'Enter a Coverage Amount'),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ], // Only numbers can be entered
                  )),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: pamount,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        errorText: pamounterror,
                        labelText: 'Total Premium Amount',
                        hintText: 'Enter a Premium Amount'),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ], // Only numbers can be entered
                  )),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.grey)),
                      child: TextField(
                        readOnly: true,
                        controller: ddate,
                        decoration: InputDecoration(
                            hintText: 'Pick Due Date',
                            errorText: ddateerror,
                            labelText: "Due Date"),
                        onTap: () async {
                          var date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2100));
                          ddate.text = date.toString().substring(0, 10);
                        },
                      ))),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.grey)),
                      child: TextField(
                        readOnly: true,
                        controller: mdate,
                        decoration: InputDecoration(
                            hintText: 'Pick Mature Date',
                            errorText: mdateerror,
                            labelText: "Mature Date"),
                        onTap: () async {
                          var date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2100));
                          mdate.text = date.toString().substring(0, 10);
                        },
                      ))),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.grey)),
                      child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                              dropdownColor: Colors.white,
                              isExpanded: true,
                              value: due,
                              items: [
                                DropdownMenuItem(
                                  child: Text("Select Due Paid/Not Paid",
                                      style: TextStyle()),
                                  value: 0,
                                ),
                                DropdownMenuItem(
                                  child: Text("Due Paid"),
                                  value: 1,
                                ),
                                DropdownMenuItem(
                                  child: Text("Due Not Paid"),
                                  value: 2,
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  due = value;
                                });
                              })))),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  error1,
                  style: TextStyle(color: Colors.red),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: ElevatedButton(
                  child: Text("Add Policy"),
                  onPressed: () {
                    this.setState(() {
                      policynumber = policy.text;
                      if (name.text.trim().isEmpty) {
                        nameerror = "Enter Name";
                        return;
                      } else {
                        nameerror = null;
                        customername = name.text;
                      }

                      if (it == 1) {
                        insurancetype = "Vehical Insurance";
                        error = "";
                      } else if (it == 2) {
                        insurancetype = "Life Insurance";
                        error = "";
                      } else if (it == 3) {
                        insurancetype = "Gold Insurance";
                        error = "";
                      } else {
                        error = "select valid option";
                        return;
                      }

                      if (total.text.trim().isEmpty) {
                        totalerror = "Enter coverage amount";
                        return;
                      } else {
                        totalerror = null;
                        totalcoverage = total.text;
                      }

                      if (pamount.text.trim().isEmpty) {
                        pamounterror = "Enter Premium Amount";
                        return;
                      } else {
                        premiumamount = pamount.text;
                        pamounterror = null;
                      }

                      if (ddate.text.trim().isEmpty) {
                        ddateerror = "Pick date";
                        return;
                      } else {
                        duedate = ddate.text;
                        ddateerror = null;
                      }

                      if (mdate.text.trim().isEmpty) {
                        mdateerror = "Pick date";
                        return;
                      } else {
                        maturedate = mdate.text;
                        mdateerror = null;
                      }

                      if (due == 1) {
                        duepaid = "Due Paid";
                        error1 = "";
                      } else if (due == 2) {
                        duepaid = "Due Not Paid";
                        error1 = "";
                      } else {
                        error1 = "select due paid/not paid";
                        return;
                      }

                      FirebaseDatabase.instance
                          .reference()
                          .child("data")
                          .child(policynumber)
                          .once()
                          .then((DataSnapshot snapshot) => {
                                if (snapshot.value == null)
                                  {
                                    FirebaseDatabase.instance
                                        .reference()
                                        .child("data")
                                        .child(policynumber)
                                        .set({
                                          "Policy Number": policynumber,
                                          "Customer Name": customername,
                                          "Insurance Type": insurancetype,
                                          "Total Coverage": totalcoverage,
                                          "Total Premium": premiumamount,
                                          "Due Date": duedate,
                                          "Mature Date": maturedate,
                                          "Due": duepaid
                                        })
                                        .then((value) => {
                                              Toast.show(
                                                  "Policy Added Successfully",
                                                  context,
                                                  duration: Toast.LENGTH_LONG,
                                                  gravity: Toast.BOTTOM,
                                                  backgroundColor: Colors.green,
                                                  textColor: Colors.white),
                                            })
                                        .catchError((e) => {
                                              Toast.show(e, context,
                                                  duration: Toast.LENGTH_LONG,
                                                  gravity: Toast.BOTTOM,
                                                  backgroundColor: Colors.red,
                                                  textColor: Colors.white)
                                            })
                                  }
                                else
                                  {
                                    Toast.show("Policy Already Exists", context,
                                        duration: Toast.LENGTH_LONG,
                                        gravity: Toast.BOTTOM,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white)
                                  }
                              });
                    });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
