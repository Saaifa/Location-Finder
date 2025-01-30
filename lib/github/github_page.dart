import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class GithubPage extends StatefulWidget {
  const GithubPage({super.key});

  @override
  State<GithubPage> createState() => _GithubPageState();
}

class _GithubPageState extends State<GithubPage> {

  final client = Dio();
  List<Map<String, dynamic>> jsonUsersData = [];

  Future<List<dynamic>> fetchUsersFromJson() async {
    final url = 'https://jsonplaceholder.typicode.com/todos';
    try{
      final response = await client.get(url);
      final List<dynamic> jsonMap = response.data;
      setState(() {
        jsonUsersData = jsonMap.cast<Map<String, dynamic>>();
      });
      print(response);
    } catch(e) {
      print("Error: $e");
    }
    return [];
  }

  @override
  void initState() {
    super.initState();
    fetchUsersFromJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Github Users',
        style: TextStyle(
          color: Colors.white
        ),),
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.all(10.0),
          child: Material(
            child: ListView.builder(
              itemCount: jsonUsersData.length,
                itemBuilder: (context, index){
                  final user = jsonUsersData[index];
                return Container(
                  padding: EdgeInsets.all(10.0),
                  child: Material(
                    elevation: 2,
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.deepPurple[100],
                      child: Text("${user["title"]}")),
                );
                }
            ),
          ),
        ),
      ),
    );
  }
}
