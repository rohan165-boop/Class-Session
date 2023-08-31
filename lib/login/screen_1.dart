// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:p_1/login/model.dart';
import 'package:p_1/login/sceen_two.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenOne extends StatefulWidget {
  const ScreenOne({super.key});

  @override
  State<ScreenOne> createState() => _ScreenOneState();
}

class _ScreenOneState extends State<ScreenOne> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _castController = TextEditingController();

  @override
  void initState() {
    _nameController.text = "";
    _castController.text = "";
    super.initState();
  }

  void _setData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<ScreenOneModel> listData = [];
    final model = ScreenOneModel(
      one: _nameController.text.trim(),
      two: _castController.text.trim(),
    );

    String prefData = pref.getString("key1") ?? "";
    log(prefData);
    if (prefData.isNotEmpty || prefData != "") {
      List<ScreenOneModel> mapData = (json.decode(prefData) as List<dynamic>)
          .map((e) => ScreenOneModel.fromMap(e))
          .toList();
      if (mapData.isNotEmpty) {
        for (var i in mapData) {
          listData.add(i);
        }
      }
    }

    listData.add(model);
    log(" json Data Data: ${json.encode(listData.map((item) => item.toMap()).toList())}");

    String setData = json.encode(listData.map((item) => item.toMap()).toList());
    log(" Set Data: $setData");

    await pref.setString("key1", setData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Screen Set"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const Text("data"),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: "Name"),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _castController,
              decoration: const InputDecoration(labelText: "Cast"),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                _setData();
                // Navigator.pop(context)
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ScreenTwo(
                          model: Model(),
                        )));
              },
              child: const Text("Submit"),
            )
          ],
        ),
      ),
    );
  }
}

class ModelL {
  List<ScreenOneModel>? list;
  ModelL({
    this.list,
  });

  Map<String, dynamic> toMap() {
    final data = <String, dynamic>{};
    if (list != null) {
      data['list'] = list!.map((e) => e);
    }

    return data;
  }

  ModelL.fromMap(Map<String, dynamic> map) {
    if (map['list'] != null) {
      list = map['list'] != null
          ? map['list'].forEach((v) => ScreenOneModel.fromMap(v))
          : <ScreenOneModel>[];
    }
  }
}

class ScreenOneModel {
  String? one;
  String? two;
  ScreenOneModel({
    this.one,
    this.two,
  });

  Map<String, dynamic> toMap() {
    final data = <String, dynamic>{};

    data['one'] = one;
    data['two'] = two;

    return data;
  }

  ScreenOneModel.fromMap(Map<String, dynamic> map) {
    one = map['one'] != null ? map['one'] as String : null;
    two = map['two'] != null ? map['two'] as String : null;
  }
}
