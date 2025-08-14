import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:simplereader/cubit/status_date.dart';
import 'package:simplereader/widget/title_profile.dart';
import 'package:simplereader/widget/title_tools.dart';

import '../cubit/theme_cubit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themes = context.watch<ThemeCubit>();
    return BlocProvider(
      create: (context) => StatusDate(),
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocBuilder<StatusDate, String>(
                    builder: (context, state) {
                      context.read<StatusDate>().checkStatus();
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TitleProfile(
                            title: 'Hello',
                            sizeFont: 40,
                          ),
                          TitleProfile(
                            title: state,
                            sizeFont: 40,
                          ),
                        ],
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Text(
                      "Welcome let's view your pdf with simple, minimalist and customization",
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: themes.state.text,
                          fontWeight: FontWeight.w900),
                    ) ,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: TitleProfile(
                      title: 'Color themes',
                      sizeFont: null,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Container(
                      height: 80,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border:
                              Border.all(color: themes.state.widget, width: 2)),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: themes.listColorTheme.length,
                          itemBuilder: (context, index) => Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () => themes
                                    .chanetTheme(themes.listColorTheme[index]),
                                overlayColor: const WidgetStatePropertyAll(
                                    Colors.transparent),
                                child: Container(
                                  height: 35,
                                  width: 35,
                                  margin: const EdgeInsets.only(right: 15),
                                  decoration: BoxDecoration(
                                      color: themes
                                          .listColorTheme[index].background,
                                      borderRadius: BorderRadius.circular(50)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
