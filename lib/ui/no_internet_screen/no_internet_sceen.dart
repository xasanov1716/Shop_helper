import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:last_task/cubit/connectivity_cubit/connectivity_cubit.dart';
import 'package:lottie/lottie.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({Key? key, required this.onTap}) : super(key: key);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocListener<ConnectivityCubit, ConnectivityState>(
        listener: (context, state) {
          if (state.connectivityResult == ConnectivityResult.ethernet ||
              state.connectivityResult == ConnectivityResult.wifi ||
              state.connectivityResult == ConnectivityResult.mobile) {
            onTap.call();
            Navigator.pop(context);
          }
        },
        child: Scaffold(
          body: Center(
            child: Lottie.asset('assets/lottie/no_internet.json'),
          ),
        ),
      ),
    );
  }
}
