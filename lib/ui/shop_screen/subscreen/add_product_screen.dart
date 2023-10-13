import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:last_task/bloc/shop/shop_bloc.dart';
import 'package:last_task/data/models/shop/shop_model_sql.dart';
import 'package:last_task/ui/app_route.dart';
import 'package:last_task/ui/widgets/global_button.dart';
import 'package:last_task/ui/widgets/global_text_fields.dart';
import 'package:last_task/utils/colors/app_colors.dart';
import 'package:last_task/utils/ui_utils/error_message_dialog.dart';
import 'package:lottie/lottie.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
 
 
  final TextEditingController controller = TextEditingController();
 
  @override
  void initState() {
    if (widget.text.isEmpty) {
      scanQRCode();
    }else{
      controller.text = widget.text;
    }
    super.initState();
  }

  int count = 1;
  String name = '';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.c_0C1A30,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.passiveTextColor,
          ),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
                context, RouteNames.shop, (route) => false);
          },
        ),
        elevation: 0,
        backgroundColor: AppColors.c_0C1A30,
        title: const Text('Add Product'),
      ),
      body: BlocConsumer<ShopBloc, ShopState>(
        listener: (context, state) {
          if (state is ShopSuccesState) {
            Navigator.pushNamedAndRemoveUntil(
                context, RouteNames.shop, (route) => false);
          }
        },
        builder: (context, state) {
          if (state is ShopLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      Lottie.asset('assets/lottie/add_product.json'),
                      GlobalTextField(
                        caption: 'Product Name',
                          hintText: 'Enter Product Name',
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          textAlign: TextAlign.start,
                          onChanged: (v) {
                            name = v;
                          }),
                      const SizedBox(height: 24),
                      GlobalTextField(
                        caption: 'Product Count',
                          hintText: 'Enter  Product Count',
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          textAlign: TextAlign.start,
                          check: true,
                          onChanged: (v) {
                            count = int.parse(v);
                          }),
                          const SizedBox(height: 24),
                      GestureDetector(
                        onTap: (){
                          scanQRCode();
                        },
                        child: AbsorbPointer(
                          child: GlobalTextField(
                            caption: 'Enter QR ',
                              hintText: '',
                              suffixIcon: IconButton(
                                onPressed: () {
                                  scanQRCode();
                                },
                                icon: const Icon(Icons.qr_code_2,color: AppColors.passiveTextColor,),
                              ),
                              controller: controller,
                              read: true,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.done,
                              textAlign: TextAlign.start,
                              onChanged: (v) {}),
                        ),
                      ),
                      const SizedBox(height: 60),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                GlobalButton(
                    text: 'Add',
                    onTap: () {
                      if (controller.text.isNotEmpty && name.isNotEmpty) {
                        context.read<ShopBloc>().add(ProductAddEvent(
                            shopModel: ShopModel(
                                code: controller.text,
                                name: name,
                                count: count)));
                        context.read<ShopBloc>().add(GetAllProductEvent());
                        showSnackbar(context, "Mahsulot Muvafaqiyatli Qo'shildi");
                      } else {
                        showErrorMessage(
                            message: 'Maydonlar toliq emas', context: context);
                      }
                    }),
              ],
            ),
          );
        },
      ),
    );
  }

  void scanQRCode() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      if (!mounted) return;
      setState(() {
        controller.text = qrCode.toString();
        // controller.text = qrCode.toString().replaceAll('-', '');
        // controller.text = qrCode.toString().replaceAll('1', '');
      });
    } on PlatformException {
      showSnackbar(context, 'Skanerlash Xato !!!!!');
    }
  }
}
