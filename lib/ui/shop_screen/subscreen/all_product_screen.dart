import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:last_task/bloc/shop/shop_bloc.dart';
import 'package:last_task/data/models/shop/shop_model_sql.dart';
import 'package:last_task/utils/colors/app_colors.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class AllProductScreen extends StatefulWidget {
  const AllProductScreen({Key? key}) : super(key: key);

  @override
  State<AllProductScreen> createState() => _AllProductScreenState();
}

class _AllProductScreenState extends State<AllProductScreen> {
  @override
  void initState() {
    context.read<ShopBloc>().add(GetAllProductEvent());
    super.initState();
  }

  int selectedMenu = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.c_0C1A30,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(icon: Icon(Icons.arrow_back,color: AppColors.passiveTextColor,),onPressed: (){
          Navigator.pop(context);
      },),
        backgroundColor: AppColors.c_0C1A30,
        title: const Text('All Products',style: TextStyle(color: AppColors.passiveTextColor),),
      ),
      body: BlocConsumer<ShopBloc, ShopState>(
          builder: (context, state) {
            if (state is ShopSuccesState) {
              return state.shopModel.isNotEmpty
                  ? ListView(
                      children: [
                        ...List.generate(state.shopModel.length, (index) {
                          if (state.shopModel[index].count == 0) {
                            context.read<ShopBloc>().add(DeleteProductEvent(
                                id: state.shopModel[index].id!));
                            context.read<ShopBloc>().add(GetAllProductEvent());
                          } else{
                            const SizedBox();
                          }
                            ShopModel shop = state.shopModel[index];
                            return Dismissible(
                              background: Container(
                                  margin: const EdgeInsets.all(10),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(color: Colors.grey))),
                              onDismissed: (DismissDirection direction) {
                                context
                                    .read<ShopBloc>()
                                    .add(DeleteProductEvent(id: shop.id!));
                                context
                                    .read<ShopBloc>()
                                    .add(GetAllProductEvent());
                              },
                              key: ValueKey<int>(index),
                              child: Container(
                                margin: const EdgeInsets.all(10),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(color: Colors.grey)),
                                child: ListTile(
                                  title: Text(shop.name,
                                      style:const TextStyle(color: AppColors.passiveTextColor)),
                                  trailing: Text(shop.count.toString(),
                                      style: const TextStyle( color: AppColors.passiveTextColor)),
                                  subtitle: Linkify(
                                    onOpen: (link) async {
                                      if (!await launchUrl(Uri.parse(link.url))) {
                                        throw Exception('Could not launch ${link.url}');
                                      }
                                    },
                                    text: shop.code,
                                    style:const TextStyle(color: AppColors.passiveTextColor),
                                    linkStyle: TextStyle(color: AppColors.c_3669C9),
                                  ),
                                ),
                              ),
                            );
                          // }
                          // return const SizedBox();
                        })
                      ],
                    )
                  : Center(
                      child: Lottie.asset('assets/lottie/empty.json'),
                    );
            }
            return const Center(child: CircularProgressIndicator());
          },
          listener: (context, state) {}),
    );
  }
}
