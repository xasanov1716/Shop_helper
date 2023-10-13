import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:last_task/cubit/connectivity_cubit/connectivity_cubit.dart';
import 'package:last_task/ui/app_route.dart';
import 'package:last_task/ui/no_internet_screen/no_internet_sceen.dart';
import 'package:last_task/ui/widgets/global_button.dart';
import 'package:last_task/utils/colors/app_colors.dart';
import 'package:lottie/lottie.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({Key? key}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.c_0C1A30,
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, RouteNames.all);
              },
              child: const Text('All Product')),
             const SizedBox(width: 10,),
        ],
        elevation: 0,
        backgroundColor: AppColors.c_0C1A30,
      ),
      body: BlocListener<ConnectivityCubit, ConnectivityState>(
        listener: (context, state) {
          if (state.connectivityResult == ConnectivityResult.ethernet ||
              state.connectivityResult == ConnectivityResult.bluetooth ||
              state.connectivityResult == ConnectivityResult.other ||
              state.connectivityResult == ConnectivityResult.none) {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>NoInternetScreen(onTap: (){})));
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('assets/lottie/shop.json'),
              GlobalButton(
                  text: 'Add Product',
                  onTap: () {
                    Navigator.pushNamed(context, RouteNames.addProduct,arguments: '');
                  }),
              const SizedBox(height: 20),
              GlobalButton(
                  text: 'SELL',
                  color: Colors.red,
                  onTap: () {
                    Navigator.pushNamed(context, RouteNames.getProduct);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
