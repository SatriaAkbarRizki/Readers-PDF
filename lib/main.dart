import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:simplereader/bloc/pdf/pdf_bloc.dart';
import 'package:simplereader/bloc/switch_mode/switch_mode_bloc.dart';
import 'package:simplereader/bloc/tools_pdf/cubit/channel_merge_cubit.dart';
import 'package:simplereader/cubit/file_cubit.dart';
import 'package:simplereader/cubit/splash.dart';
import 'package:simplereader/cubit/status_permission.dart';
import 'package:simplereader/cubit/theme_cubit.dart';
import 'package:simplereader/model/pdfmodel.dart';
import 'package:simplereader/model/thememodel.dart';
import 'package:simplereader/navigation/nav_observer.dart';
import 'package:simplereader/navigation/navbar.dart';
import 'package:simplereader/screens/error.dart';
import 'package:simplereader/screens/readingpdf.dart';
import 'package:simplereader/screens/search.dart';
import 'package:simplereader/screens/splashscreen.dart';
import 'package:simplereader/theme/mytheme.dart';
import 'cubit/navbar_cubit.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ThememodelAdapter());
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PdfBloc()),
        BlocProvider(create: (context) => ChannelMergeCubit()),
        BlocProvider(create: (context) => SwitchModeBloc()),
        BlocProvider(create: (context) => FileCubit()),
        BlocProvider(create: (context) => NavbarCubit()),
        BlocProvider(
            create: (context) => SplashDatabaseCubit()..getStatusSplash()),
        BlocProvider(create: (context) => ThemeCubit()..getCurretTheme()),
        BlocProvider(create: (context) => StatusPermissionCubit()),
      ],
      child: BlocConsumer<SplashDatabaseCubit, bool>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state == true) {
            return BlocBuilder<ThemeCubit, Thememodel>(
              builder: (context, state) {
                return MaterialApp.router(
                  debugShowCheckedModeBanner: false,
                  theme: MyTheme().lightTheme.copyWith(
                        appBarTheme:
                            AppBarTheme(backgroundColor: state.background),
                        scaffoldBackgroundColor: state.background,
                      ),
                  routerConfig: _route,
                );
              },
            );
          } else {
            return const MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Splashscreen(),
            );
          }
        },
      ),
    );
  }
}

final _route = GoRouter(
    initialLocation: '/',
    observers: [LoggerNavigatorObserver()],
    errorBuilder: (context, state) {
      if (state.uri.scheme == 'content') {
        final path = state.uri.path.toString();
        context
            .read<PdfBloc>()
            .add(OnPdfOpenFileIntent(path: path, context: context));
        return Navbar();
      }
      log(state.error?.message ?? "");
      return ErrorScreen(state.error?.message ?? "Unknown error", state.uri);
    },
    routes: [
      GoRoute(
        path: "/",
        builder: (context, state) => Navbar(),
      ),
      GoRoute(
        path: ReadPDFScreens.routeName,
        builder: (context, state) => ReadPDFScreens(
          pdf: state.extra as Pdfmodel,
        ),
      ),
      GoRoute(
        path: SearchScreen.routeName,
        builder: (context, state) => SearchScreen(state.extra as Thememodel),
      )
    ]);
