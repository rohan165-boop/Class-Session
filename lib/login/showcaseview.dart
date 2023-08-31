// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:p_1/login/sceen_two.dart';
import 'package:showcaseview/showcaseview.dart';

class ShowcaseWidget extends StatefulWidget {
  final List<Item> items;
  const ShowcaseWidget({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  State<ShowcaseWidget> createState() => _ShowcaseWidgetState();
}

class _ShowcaseWidgetState extends State<ShowcaseWidget> {
  List<GlobalKey> showcaseKeys = [];

  @override
  void initState() {
    super.initState();
    showcaseKeys = widget.items
        .where((item) => item.show == true)
        .map((_) => GlobalKey())
        .toList();

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      // showListOfEnrolledCourse(context);
      ShowCaseWidget.of(showcaseKeys[0].currentState!.context)
          .startShowCase(showcaseKeys);
    });
  }

  int showcasedIndex = 0;

  void _showNextItem() {
    if (showcasedIndex < showcaseKeys.length - 1) {
      setState(() {
        showcasedIndex++;
      });
    } else {
      // All items have been showcased, reset the index
      setState(() {
        showcasedIndex = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Show Case Widget"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: List.generate(
              widget.items.length,
              (index) => Showcase(
                    key: showcaseKeys[showcasedIndex],
                    child: ListTile(
                      title: Text(widget.items[index].name),
                    ),
                    description: "Click Here Message",
                    disposeOnTap: false,
                    onTargetClick: () {
                      // Perform any actions you want when the showcased item is clicked.
                      _showNextItem();
                    },
                  )),
        ),
      ),
    );
  }
}
