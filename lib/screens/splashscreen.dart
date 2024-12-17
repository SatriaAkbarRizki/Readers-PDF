import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:simplereader/cubit/splash.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      context.read<SplashDatabaseCubit>().changeStatus(true);
      context.pushReplacement("/");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1d1d1d),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Simple Reader',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize: 34,
                    fontStyle: FontStyle.italic,
                    color: const Color(0xffFDFCFA)))
          ],
        ),
      ),
    );
  }
}
