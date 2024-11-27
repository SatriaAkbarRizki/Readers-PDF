import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:simplereader/bloc/pdf/pdf_bloc.dart';
import 'package:simplereader/bloc/switch_mode/switch_mode_bloc.dart';
import 'package:simplereader/bloc/tools_pdf/cubit/channel_merge_cubit.dart';
import 'package:simplereader/cubit/file_cubit.dart';
import 'package:simplereader/cubit/theme_cubit.dart';
import 'package:simplereader/model/pdfmodel.dart';
import 'package:simplereader/model/thememodel.dart';
import 'package:simplereader/navigation/navbar.dart';
import 'package:simplereader/pdfbloc_observer.dart';
import 'package:simplereader/screens/readingpdf.dart';
import 'package:simplereader/screens/tools/compress.dart';
import 'package:simplereader/screens/tools/delete.dart';
import 'package:simplereader/screens/tools/merge.dart';
import 'package:simplereader/screens/tools/watermark.dart';
import 'package:simplereader/theme/mytheme.dart';
import 'cubit/navbar_cubit.dart';

void main() {
  Bloc.observer = PdfBlocObserver();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PdfBloc()),
        BlocProvider(
          create: (context) => ChannelMergeCubit(),
        ),
        BlocProvider(
          create: (context) => SwitchModeBloc(),
        ),
        BlocProvider(
          create: (context) => FileCubit(),
        ),
        BlocProvider(
          create: (context) => NavbarCubit(),
        ),
        BlocProvider(
          create: (context) => ThemeCubit(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, Thememodel>(
        builder: (context, state) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: MyTheme().lightTheme.copyWith(
                  appBarTheme: AppBarTheme(
                    backgroundColor: state.background,
                  ),
                  scaffoldBackgroundColor: state.background,
                ),
            routerConfig: _route,
          );
        },
      ),
    );
  }
}

final _route = GoRouter(initialLocation: '/', routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => Navbar(),
  ),
  GoRoute(
    path: ReadPDFScreens.routeName,
    builder: (context, state) => ReadPDFScreens(
      pdf: state.extra as Pdfmodel,
    ),
  ),
  GoRoute(
    path: MergeScreen.routeName,
    builder: (context, state) => MergeScreen(),
  ),
  GoRoute(
    path: DeleteScreen.routeName,
    builder: (context, state) => DeleteScreen(),
  ),
  GoRoute(
    path: CompressScreen.routeName,
    builder: (context, state) => CompressScreen(),
  ),
  GoRoute(
    path: WatermarkScreen.routeName,
    builder: (context, state) => WatermarkScreen(),
  ),
]);
