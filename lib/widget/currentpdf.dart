import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:simplereader/widget/dialog_doc.dart';

class CurrentPDF extends StatelessWidget {
  const CurrentPDF({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 2,
            childAspectRatio: 0.7,
            mainAxisSpacing: 2),
        itemCount: 10,
        itemBuilder: (context, index) => GestureDetector(
          onLongPress: () => showDialog(
            useSafeArea: true,
            context: context,
            builder: (context) => const DialogDoc(),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    height: 250,
                    width: 250,
                    decoration: BoxDecoration(
                        image: const DecorationImage(
                            image: AssetImage('assets/image/sample-book.jpg'),
                            fit: BoxFit.contain),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black38,
                              offset: Offset(0, 12.0),
                              blurRadius: 10),
                        ],
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Text(
                    'The book of people San francisco',
                    style: Theme.of(context).textTheme.labelSmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
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
