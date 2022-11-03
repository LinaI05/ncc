import 'package:flutter/material.dart';

class achievePage extends StatelessWidget {
  static const int _count = 6;
  final List<bool> _checks = List.generate(_count, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0),
      child: Column(
        children: [
          const Text(
            'Achievements',
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
                  crossAxisCount: 3),
              itemBuilder: (_, i) {
                return IconButton(
                  onPressed: () {},
                  icon: Image.asset('assets/achievements/${i + 1}.png'),
                  iconSize: 100.0,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
