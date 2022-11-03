import 'package:flutter/material.dart';

class CuteImagesClass extends StatefulWidget {
  @override
  State<CuteImagesClass> createState() => _CuteImagesClassState();
}

class _CuteImagesClassState extends State<CuteImagesClass> {
  static const int _count = 16;
  final List<bool> _checks = List.generate(_count, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: [
            const Text(
              'Cute Images',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'SourceSans',
                fontSize: 35.0,
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.zero,
                itemCount: _count,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (_, i) {
                  return Image.asset('assets/animals/${i + 1}.jpeg');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
