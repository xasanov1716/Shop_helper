import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:last_task/bloc/shop/shop_bloc.dart';
import 'package:last_task/cubit/connectivity_cubit/connectivity_cubit.dart';
import 'package:last_task/ui/app_route.dart';
import 'package:last_task/ui/shop_screen/shop_screen.dart';

import 'ui/shop_screen/subscreen/add_product_screen.dart';

Future<void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}


class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (context)=>ConnectivityCubit()),
      BlocProvider(create: (context)=>ShopBloc())
    ], child: const MainApp());
  }
}


class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRoutes.generateRoute,
      initialRoute: RouteNames.splash,
    );
  }
}
