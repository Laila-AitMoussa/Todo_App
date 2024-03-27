// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Services with ChangeNotifier {
  List myData = [];
  List allList = [];
  Future<void> fetchDataProvider() async {
    var url = Uri.https('api.nstack.in', 'v1/todos');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      myData = json['items'];
      final filterList = myData
          .where(
            (element) =>
                (DateFormat.yMMMEd()
                    .format(DateTime.parse(element['created_at']))) ==
                DateFormat.yMMMEd().format(DateTime.now()),
          )
          .toList();

      myData = filterList;
      allList = json['items'];
      notifyListeners();
    }
  }

  Future<void> postData(
      {required String title,
      required String desc,
      required BuildContext context}) async {
    final body = {"title": title, "description": desc, "is_completed": 'false'};
    var url = Uri.https('api.nstack.in', 'v1/todos');
    var response = await http.post(url, body: body);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Task Created'),
        backgroundColor: Colors.green,
      ));
      fetchDataProvider();
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error'),
        backgroundColor: Colors.red,
      ));
    }
  }

  Future<void> updateData(
      {required id,
      required String title,
      required String desc,
      required BuildContext context}) async {
    // final id = widget.itemsData!['_id'];
    final body = {"title": title, "description": desc, "is_completed": 'false'};
    var url = Uri.https('api.nstack.in', 'v1/todos/$id');
    var response = await http.put(url, body: body);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Task Updated'),
        backgroundColor: Colors.green,
      ));
      fetchDataProvider();
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error'),
        backgroundColor: Colors.red,
      ));
    }
  }

  Future<void> check(
      bool check, String _id, String title, String description) async {
    final id = _id;
    final body = {
      "title": title,
      "description": description,
      "is_completed": check.toString()
    };
    var url = Uri.https('api.nstack.in', 'v1/todos/$id');
    await http.put(url, body: body);
    fetchDataProvider();
  }

  Future<void> delete(String _id) async {
    final id = _id;
    var url = Uri.https('api.nstack.in', 'v1/todos/$id');
    await http.delete(url);
    fetchDataProvider();
  }
}
