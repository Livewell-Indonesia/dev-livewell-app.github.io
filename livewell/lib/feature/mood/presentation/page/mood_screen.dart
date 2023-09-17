import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:livewell/widgets/scaffold/livewell_scaffold.dart';

class MoodScreen extends StatefulWidget {
  const MoodScreen({super.key});

  @override
  State<MoodScreen> createState() => _MoodScreenState();
}

class _MoodScreenState extends State<MoodScreen> {
  @override
  Widget build(BuildContext context) {
    return LiveWellScaffold(
        title: 'Mood',
        body: Expanded(
          child: RefreshIndicator(
              onRefresh: () async {
                await Future.delayed(Duration(seconds: 1));
              },
              child: ListView(
                children: [
                  Container(
                    height: 100,
                    child: Center(
                      child: Text('Mood'),
                    ),
                  ),
                ],
              )),
        ));
  }
}
