import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:simplereader/bloc/tools_pdf/cubit/channel_home.dart';
import 'package:simplereader/cubit/navbar_cubit.dart';
import 'package:simplereader/cubit/theme_cubit.dart';
import 'package:simplereader/model/thememodel.dart';
import 'package:simplereader/screens/home.dart';
import 'package:simplereader/screens/landscape/controller/profile_controller.dart';
import 'package:simplereader/widget/floating_pdf.dart';

class Navbar extends StatelessWidget {
  final List listtNavBar = [const HomeScreens(), const ProfileController()];
  Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    final navCubit = context.read<NavbarCubit>();
    return BlocProvider(
      create: (context) => ChannelHome(),
      child: Scaffold(
        body: BlocBuilder<NavbarCubit, int>(
          builder: (context, state) {
            return listtNavBar[state];
          },
        ),
        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(15)),
          child: BlocBuilder<ThemeCubit, Thememodel>(
            builder: (context, themes) {
              return Theme(
                data: Theme.of(context).copyWith(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                ),
                child: BottomNavigationBar(
                    currentIndex: navCubit.state,
                    onTap: (value) {
                      context
                          .read<ChannelHome>()
                          .isHome(value == 0 ? true : false);

                      navCubit.switchNavBar(value);
                    },
                    backgroundColor: themes.background,
                    selectedItemColor: themes.text,
                    unselectedItemColor: themes.widget,
                    items: [
                      BottomNavigationBarItem(
                          label: 'Home',
                          icon: SvgPicture.asset(
                            'assets/icons/open-book.svg',
                            colorFilter: ColorFilter.mode(
                                themes.widget, BlendMode.srcIn),
                          )),
                      BottomNavigationBarItem(
                          label: 'Profile',
                          icon: SvgPicture.asset(
                            'assets/icons/account.svg',
                            colorFilter: ColorFilter.mode(
                                themes.widget, BlendMode.srcIn),
                          ))
                    ]),
              );
            },
          ),
        ),
        floatingActionButton: context.watch<NavbarCubit>().state == 0
            ? const FloatingPdfAction()
            : null,
      ),
    );
  }
}
