// ignore_for_file: prefer_const_constructors, avoid_print, use_build_context_synchronously, prefer_const_declarations, must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/provider.dart';

class CreateTask extends StatefulWidget {
  Map? itemsData;
  CreateTask({super.key, this.itemsData});

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  TextEditingController titleCon = TextEditingController();
  TextEditingController descriptionCon = TextEditingController();
  bool isEdit = false;
  @override
  void initState() {
    var data = widget.itemsData;
    if (data != null) {
      isEdit = true;
      titleCon.text = data['title'];
      descriptionCon.text = data['description'];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xff3F4353),
          border: Border(top: BorderSide(width: 5, color: Color(0xFFff7564)))),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Task Title',
                style: TextStyle(color: Colors.white, fontSize: 17.0),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                style: TextStyle(color: Colors.white),
                controller: titleCon,
                decoration: InputDecoration(
                  hintText: 'Type your Title...',
                  hintStyle:
                      TextStyle(color: Color.fromARGB(255, 139, 144, 165)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0xFFff7564)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Task Description',
                style: TextStyle(color: Colors.white, fontSize: 17.0),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                maxLines: 5,
                style: TextStyle(color: Colors.white),
                controller: descriptionCon,
                decoration: InputDecoration(
                    hintText: 'Type your Description...',
                    hintStyle:
                        TextStyle(color: Color.fromARGB(255, 139, 144, 165)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Color(0xFFff7564)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(12),
                              backgroundColor: Color(0xFFff7564),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          onPressed: () {
                            isEdit
                                ? Provider.of<Services>(context, listen: false)
                                    .updateData(
                                        id: widget.itemsData!['_id'],
                                        title: titleCon.text,
                                        desc: descriptionCon.text,
                                        context: context)
                                : Provider.of<Services>(context, listen: false)
                                    .postData(
                                        title: titleCon.text,
                                        desc: descriptionCon.text,
                                        context: context);
                          },
                          child: Text(
                            isEdit ? 'Update Task' : 'Create Task',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ))),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
