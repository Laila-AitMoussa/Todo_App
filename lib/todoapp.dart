// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/createtask.dart';
import 'package:todo_app/provider.dart';
import 'package:todo_app/see_all.dart';

class ToDoApp extends StatefulWidget {
  const ToDoApp({super.key});

  @override
  State<ToDoApp> createState() => _ToDoAppState();
}

class _ToDoAppState extends State<ToDoApp> {
  bool isCheck = false;

  @override
  void initState() {
    Provider.of<Services>(context, listen: false).fetchDataProvider();
    //fetchData();
    super.initState();
  }

  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    List myData = Provider.of<Services>(context).myData;
    return Scaffold(
      key: _key,
      appBar: AppBar(
        backgroundColor: Color(0xff303444), // Colors.black87,
        elevation: 0.0,
        title: Column(
          children: [
            Text(
              'Welcome Back!',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            SizedBox(
              height: 5,
            ),
            Text('Laila Ait Moussa', style: TextStyle(color: Colors.white)),
          ],
        ),
        centerTitle: true,
      ),
      body: Container(
          padding: EdgeInsets.all(15.0),
          color: Color(0xff303444),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xFFff7564),
                          borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.all(16),
                      child: Text(
                        DateFormat.yMMMMEEEEd().format(DateTime.now()),
                        style: TextStyle(color: Colors.white, fontSize: 15.5),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xff3F4353),
                    ),
                    child: IconButton(
                        onPressed: () {
                          Provider.of<Services>(context, listen: false)
                              .fetchDataProvider();
                        },
                        icon: Icon(
                          Icons.refresh_rounded,
                          color: Colors.white,
                          size: 25,
                        )),
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Today\'s Tasks',
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xFFff7564),
                        ),
                        padding: EdgeInsets.all(10),
                        child: Text(
                          '${myData.length}',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SeeAll(),
                              ));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff3F4353),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text('See All',
                            style: TextStyle(color: Colors.white)),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: myData.length,
                  itemBuilder: (BuildContext context, int index) {
                    Map<String, dynamic> data = myData.reversed.toList()[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 14.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xff3F4353),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data['title'],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  decoration: data['is_completed']
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    data['description'],
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  DateFormat.yMMMEd().format(
                                      DateTime.parse(data['created_at'])),
                                  style: TextStyle(color: Colors.grey),
                                ),
                                SizedBox(
                                  width: 60,
                                ),
                                IconButton(
                                    onPressed: () {
                                      _key.currentState!.showBottomSheet(
                                          (context) => CreateTask(
                                                itemsData: data,
                                              ));
                                    },
                                    icon: Icon(
                                      Icons.edit,
                                      color: Color(0xff3C8686),
                                    )),
                                IconButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(13),
                                            ),
                                            backgroundColor: Color(0xff3F4353),
                                            icon: Icon(
                                              Icons.warning_amber,
                                              size: 35,
                                              color: Color(0xffCF1F24),
                                            ),
                                            title: Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                'Alert',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                            content: Text(
                                              'Are you Sure?',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            actions: [
                                              TextButton(
                                                  style: TextButton.styleFrom(
                                                    backgroundColor:
                                                        Color(0xffCF1F24),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              13),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    Provider.of<Services>(
                                                            context,
                                                            listen: false)
                                                        .delete(data['_id']);
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    'Yes',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )),
                                              TextButton(
                                                  style: TextButton.styleFrom(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(13),
                                                      ),
                                                      backgroundColor:
                                                          Color(0xff303444)),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    'No',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ))
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: Color(0xffCF1F24),
                                    )),
                                Checkbox(
                                  activeColor: Color(0xFFff7564),
                                  side: BorderSide(color: Colors.white),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  value: data['is_completed'],
                                  onChanged: (value) {
                                    Provider.of<Services>(context,
                                            listen: false)
                                        .check(value!, data['_id'],
                                            data['title'], data['description']);
                                  },
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _key.currentState!.showBottomSheet((context) => CreateTask());
          /* Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreateTask(),
              ));*/
        },
        backgroundColor: Color(0xFFff7564),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
