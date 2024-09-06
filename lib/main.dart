import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:simplereader/bloc/pdf/pdf_bloc.dart';
import 'package:simplereader/bloc/switch_mode/switch_mode_bloc.dart';
import 'package:simplereader/cubit/file_cubit.dart';
import 'package:simplereader/model/pdfmodel.dart';
import 'package:simplereader/navigation/navbar.dart';
import 'package:simplereader/pdfbloc_observer.dart';
import 'package:simplereader/screens/readingpdf.dart';
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
          create: (context) => SwitchModeBloc(),
        ),
        BlocProvider(
          create: (context) => FileCubit(),
        ),
        BlocProvider(
          create: (context) => NavbarCubit(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: MyTheme().lightTheme,
        routerConfig: _route,
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
  )
]);
