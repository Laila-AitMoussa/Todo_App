// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/createtask.dart';
import 'package:todo_app/provider.dart';

class SeeAll extends StatefulWidget {
  const SeeAll({super.key});

  @override
  State<SeeAll> createState() => _SeeAllState();
}

class _SeeAllState extends State<SeeAll> {
  bool isCheck = false;
  List myData = [];
  @override
  void initState() {
    // fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List myData = Provider.of<Services>(context).allList;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff303444), // Colors.black87,
        elevation: 0.0,
        title: Text('All Tasks'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Provider.of<Services>(context, listen: false)
                    .fetchDataProvider();
              },
              icon: Icon(
                Icons.refresh_rounded,
                color: Colors.white,
                size: 25,
              )),
        ],
      ),
      body: Container(
          padding: EdgeInsets.all(15.0),
          color: Color(0xff303444),
          child: Column(
            children: [
              SizedBox(
                height: 30,
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
                                  width: 70,
                                ),
                                IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => CreateTask(
                                              itemsData: data,
                                            ),
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
                                            icon: Icon(Icons.warning_amber),
                                            title: Text('Alert'),
                                            content: Text('Are you Sure?'),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Provider.of<Services>(
                                                            context)
                                                        .delete(data['_id']);
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('Yes')),
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('No'))
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
                                  side: BorderSide(color: Colors.white),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  value: data['is_completed'],
                                  onChanged: (value) {
                                    Provider.of<Services>(context).check(
                                        value!,
                                        data['_id'],
                                        data['title'],
                                        data['description']);
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
          /* final snackBar = SnackBar(
            content: Column(
              children: [
                Text('Task Title'),
                TextFormField(),
                Text('Task Description'),
                TextFormField(),
                ElevatedButton(onPressed: () {}, child: Text('Create Task'))
              ],
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);*/
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreateTask(),
              ));
        },
        backgroundColor: Color(0xFFff7564),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}
