import 'package:flutter/material.dart';
import 'package:simplereader/widget/currentpdf.dart';

class HomeScreens extends StatelessWidget {
  const HomeScreens({super.key});

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
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: CircleAvatar(),
            )
          ]),
      body: CurrentPDF(),
    );
  }
}



// body: NestedScrollView(
//           headerSliverBuilder: (context, innerBoxIsScrolled) => [
//                 SliverAppBar(
//                   forceMaterialTransparency: true,
//                   title: Text(
//                     'Good Morning 🌄',
//                     style: Theme.of(context).textTheme.labelMedium,
//                   ),
//                 )
//               ],
//           body: const CurrentPDF())