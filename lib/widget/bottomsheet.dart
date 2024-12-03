import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/status_permission.dart';

Future showBottomSheetPermission(BuildContext context, themes) async =>
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      backgroundColor: themes.background,
      builder: (context) => SizedBox(
        height: 250,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Text(
                      'Permission Required',
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium
                          ?.copyWith(fontSize: 22),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Text.rich(
                        textAlign: TextAlign.justify,
                        style: Theme.of(context).textTheme.labelMedium,
                        const TextSpan(
                            text: "To read all document pdf on your device, ",
                            children: [
                              TextSpan(text: "please allow "),
                              TextSpan(
                                  text: "SimpleReader",
                                  style: TextStyle(
                                      color: Color(0xff1b5ed1),
                                      fontWeight: FontWeight.bold)),
                              TextSpan(text: " to access all your files")
                            ])),
                  )
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: () async {
                    context
                        .read<StatusPermissionCubit>()
                        .listenStatusPermission();
                  },
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(MediaQuery.of(context).size.width, 50)),
                  child: const Text('Allow'),
                ),
              )
            ],
          ),
        ),
      ),
    );
