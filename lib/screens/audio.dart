import 'package:flutter/material.dart';
import 'package:simplereader/screens/empty.dart';

import '../type/empty_type.dart';

class AudioScreens extends StatelessWidget {
  const AudioScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffFDFCFA),
        forceMaterialTransparency: true,
        title: Text(
          'Simple Reader',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: EmptyScreens(
        type: TypeEmpty.emptyAudio,
      ),
    );
  }
}
