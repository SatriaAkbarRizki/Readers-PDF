import 'package:flutter/material.dart';

class TitleTools extends StatelessWidget {
  final String title, path;
  const TitleTools(this.title, this.path ,{super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      
      decoration: BoxDecoration(
          color: const Color(0xff1b5ed1),
          borderRadius: BorderRadius.circular(25)),
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Colors.white),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Image.asset(
                path,
              ),
            )
          ],
        ),
      ),
    );
  }
}
