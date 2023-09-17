import 'package:dayagram/core/common/routes.dart';
import 'package:dayagram/features/home/bloc/home_bloc.dart';
import 'package:dayagram/core/managers/route_manager.dart' as router;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Dayagram',
        initialRoute: Routes.ROOT,
        onGenerateRoute: router.generateRoute,
      ),
    );
  }
}
