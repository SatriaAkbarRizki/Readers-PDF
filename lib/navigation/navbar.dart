import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:simplereader/cubit/navbar_cubit.dart';
import 'package:simplereader/screens/Home.dart';
import 'package:simplereader/screens/audio.dart';
import 'package:simplereader/screens/profile.dart';
import 'package:simplereader/widget/floating_pdf.dart';

class Navbar extends StatelessWidget {
  final List listtNavBar = [
    const HomeScreens(),
    // const AudioScreens(),
    const ProfileScreen()
  ];
  Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    final navCubit = context.read<NavbarCubit>();
    return Scaffold(
      body: BlocBuilder<NavbarCubit, int>(
        builder: (context, state) {
          return listtNavBar[state];
        },
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(15)),
        child: BottomNavigationBar(
            currentIndex: navCubit.state,
            onTap: (value) => navCubit.switchNavBar(value),
            backgroundColor: const Color(0xffF9F6EE),
            items: [
              BottomNavigationBarItem(
                  label: 'Home',
                  icon: SvgPicture.asset(
                    'assets/icons/open-book.svg',
                    colorFilter: const ColorFilter.mode(
                        Color(0xff1b5ed1), BlendMode.srcIn),
                  )),
              // BottomNavigationBarItem(
              //     label: 'Listen',
              //     icon: SvgPicture.asset(
              //       'assets/icons/listen.svg',
              //       colorFilter: const ColorFilter.mode(
              //           Color(0xff1b5ed1), BlendMode.srcIn),
              //     )),
              BottomNavigationBarItem(
                  label: 'Profile',
                  icon: SvgPicture.asset(
                    'assets/icons/account.svg',
                    colorFilter: const ColorFilter.mode(
                        Color(0xff1b5ed1), BlendMode.srcIn),
                  ))
            ]),
      ),
      floatingActionButton: context.watch<NavbarCubit>().state == 0
          ? const FloatingPdfAction()
          : null,
    );
  }
}
