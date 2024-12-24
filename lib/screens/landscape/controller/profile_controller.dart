import 'package:flutter/material.dart';
import 'package:simplereader/screens/landscape/profile.dart';
import 'package:simplereader/screens/profile.dart';

class ProfileController extends StatelessWidget {
  const ProfileController({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return ProfileScreenLandScape();
        } else {
          return ProfileScreen();
        }
      },
    );
  }
}
