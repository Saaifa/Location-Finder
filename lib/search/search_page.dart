import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();
  bool showSuggestedPlaces = true;
  List<dynamic> predictionResponse = [];
  Map<String, dynamic> placeDetailsResponse = {};

  final client = Dio();

  Future<dynamic> searchLocation(String query) async {
    final url = 'https://maps.googleapis.com/maps/api/place/'
        'queryautocomplete/json?input=$query'
        '&key=AIzaSyAh1fXPanw5wRfFfU1gmnh0z1jGDRHm76M&region='
        'in';

    try {
      final response = await client.get(url);
      Map<String, dynamic> jsonMap = jsonDecode(response.toString());
      predictionResponse = jsonMap['predictions'];
      print("bbbbb ${predictionResponse.toList().length}");
      if (response.statusCode == 200) {
        AlertDialog(
          title: Text("Successfully called"),
        );
        return;
      }
    } catch (error) {
      print(error);
    }
  }

  Future<dynamic> getPlaceDetails(String place_id) async {
    final url = "https://maps.googleapis.com/maps/api/place/details/json"
        "?place_id=$place_id&key=AIzaSyAh1fXPanw5wRfFfU1gmnh0z1jGDRHm76M"
        "&fields=address_component,formatted_address";

    try {
      final response = await client.get(url);
      Map<String, dynamic> jsonMap = jsonDecode(response.toString());
      placeDetailsResponse = jsonMap['result'];
      print('placeDetail $placeDetailsResponse');
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Search Page",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.brown,
      ),
      body: SafeArea(
        child: Container(
          height: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage("assets/images/maps.png"),
            fit: BoxFit.cover,
          )),
          padding: EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.grey[200],
                  ),
                  padding:
                      const EdgeInsets.only(left: 5.0, right: 2.0, top: 10.0),
                  child: TextField(
                    style: TextStyle(
                        // color: Colors.lime
                        ),
                    controller: _searchController,
                    onChanged: (value) {
                      setState(() {
                        if (value.isNotEmpty) {
                          showSuggestedPlaces = true;
                          print("object $value");
                          searchLocation(value);
                        } else {
                          showSuggestedPlaces = false;
                          predictionResponse = [];
                        }
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      prefixIcon: Icon(Icons.search),
                      labelText: "Search here",
                      labelStyle: TextStyle(color: Colors.black),
                      // filled: true,
                      // fillColor: Colors.transparent,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                if (predictionResponse.isNotEmpty && showSuggestedPlaces)
                  Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15.0, top: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: predictionResponse.map(
                          (location) {
                            return Container(
                              padding: EdgeInsets.only(bottom: 15.0),
                              child: TextButton(
                                onPressed: () {
                                  getPlaceDetails(location["place_id"]);
                                  setState(() {
                                    showSuggestedPlaces = false;
                                  });
                                },
                                child: Text(
                                  "${location["description"]}",
                                  style: TextStyle(
                                      fontSize: 12.0, color: Colors.black),
                                ),
                              ),
                            );
                          },
                        ).toList(),
                        // children: [
                        //   Text("ggggg"),
                        // ],
                      )),
                SizedBox(
                  height: 10.0,
                ),
                if (_searchController.text.isNotEmpty)
                  Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      "${placeDetailsResponse["formatted_address"]}",
                      style: TextStyle(
                        fontSize: 12.0,
                      ),
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
