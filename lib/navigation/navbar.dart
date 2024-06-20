import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:simplereader/screens/Home.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const HomeScreens(),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(15)),
        child: BottomNavigationBar(
            backgroundColor: const Color(0xffF9F6EE),
            items: [
              BottomNavigationBarItem(
                  label: 'Home',
                  icon: SvgPicture.asset(
                    'assets/icons/open-book.svg',
                    colorFilter:
                        const ColorFilter.mode(Color(0xff1b5ed1), BlendMode.srcIn),
                  )),
              BottomNavigationBarItem(
                  label: 'Listen',
                  icon: SvgPicture.asset(
                    'assets/icons/listen.svg',
                    colorFilter:
                        const ColorFilter.mode(Color(0xff1b5ed1), BlendMode.srcIn),
                  )),
              BottomNavigationBarItem(
                  label: 'Listen',
                  icon: SvgPicture.asset(
                    'assets/icons/account.svg',
                    colorFilter:
                        const ColorFilter.mode(Color(0xff1b5ed1), BlendMode.srcIn),
                  ))
            ]),
      ),
    );
  }
}
