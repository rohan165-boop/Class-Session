import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:p_1/login/screen_1.dart';
import 'package:p_1/login/showcaseview.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';

import 'model.dart';

class ScreenTwo extends StatefulWidget {
  final Model model;
  const ScreenTwo({super.key, required this.model});

  @override
  State<ScreenTwo> createState() => _ScreenTwoState();
}

class _ScreenTwoState extends State<ScreenTwo> {
  late SharedPreferences pref;
  List<ScreenOneModel> getDataList = [];
  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    pref = await SharedPreferences.getInstance();

    String getresp = pref.getString("key1") ?? '';

    if (getresp.isNotEmpty || getresp != "") {
      List<ScreenOneModel> mapData = (json.decode(getresp) as List<dynamic>)
          .map((e) => ScreenOneModel.fromMap(e))
          .toList();
      if (mapData.isNotEmpty) {
        for (var i in mapData) {
          setState(() {
            getDataList.add(i);
          });
        }
      }
    }
  }

  void _deleteItem({required String name}) async {
    pref = await SharedPreferences.getInstance();

    // pref.clear();

    String getresp = pref.getString("key1") ?? '';

    if (getresp.isNotEmpty || getresp != "") {
      List<ScreenOneModel> mapData = (json.decode(getresp) as List<dynamic>)
          .map((e) => ScreenOneModel.fromMap(e))
          .toList();
      if (mapData.isNotEmpty) {
        for (var i in mapData) {
          setState(() {
            getDataList.add(i);
          });
        }
      }
    }
    for (var i in getDataList) {
      if (i.one == name) {
        getDataList.remove(i);
      }
    }

    String setData =
        json.encode(getDataList.map((item) => item.toMap()).toList());

    pref.setString("key1", setData);
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Screen Two"),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const ScreenOne())),
            icon: const Icon(Icons.add),
          ),
          SizedBox(
            width: 20,
          ),
          IconButton(
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ShowCaseWidget(
                      builder: Builder(builder: (context) {
                        return ShowcaseWidget(
                          items: items,
                        );
                      }),
                    ))),
            icon: const Icon(Icons.car_crash),
          ),
          const SizedBox(
            height: 40,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),

        child: Column(
          children: [
            Text(widget.model.firstName ?? ""),
            Text(widget.model.email ?? ""),
            Text(widget.model.gender ?? ""),
            Text(widget.model.lastName ?? ""),
            Text(widget.model.username ?? ""),
            Text(widget.model.token ?? ""),
            ElevatedButton(
                onPressed: () async {
                  final dio = Dio();
                  var resp = await dio
                      .get("https://dummyjson.com/products", queryParameters: {
                    "limit": 10,
                    "skip": 10,
                    "select": "title",
                  });

                  if (resp.statusCode == 200) {
                    log(resp.data.toString());
                  }
                },
                child: Text("getDtaat"))
          ],
        ),
        //   child: ListView.builder(
        //     itemCount: getDataList.length,
        //     itemBuilder: (context, index) {
        //       return getDataList.isNotEmpty
        //           ? Row(
        //               children: [
        //                 Column(
        //                   children: [
        //                     Text("data 1 : ${getDataList[index].one}"),
        //                     Text("data 2 : ${getDataList[index].two}"),
        //                     SizedBox(
        //                       height: 30,
        //                     )
        //                   ],
        //                 ),
        //                 IconButton(
        //                     onPressed: () {
        //                       _deleteItem(name: getDataList[index].one!);
        //                     },
        //                     icon: Icon(Icons.cancel))
        //               ],
        //             )
        //           : const Center(
        //               child: Text("No Data"),
        //             );
        //     },
        //   ),
      ),
    );
  }
}

class Item {
  final String name;
  final bool show;

  Item({required this.name, required this.show});
}

final List<Item> items = [
  Item(name: "Item 1", show: true),
  Item(name: "Item 2", show: false),
  Item(name: "Item 3", show: true),
  Item(name: "Item 4", show: false),
  Item(name: "Item 5", show: true),
];
