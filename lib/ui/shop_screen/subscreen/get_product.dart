
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

class GetProductScreen extends StatefulWidget {
  const GetProductScreen({Key? key}) : super(key: key);

  @override
  State<GetProductScreen> createState() => _GetProductScreenState();
}

class _GetProductScreenState extends State<GetProductScreen> {
  @override
  void initState() {
    scanQRCode();
    super.initState();
  }

  String code = '';
  int count = 1;
  int productCount = 0;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.c_0C1A30,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(icon: Icon(Icons.arrow_back,color: AppColors.passiveTextColor,),onPressed: (){
          Navigator.pop(context);
        },),
        backgroundColor: AppColors.c_0C1A30,
      ),
      body: BlocConsumer<ShopBloc, ShopState>(
        listener: (context, state) {
          if (state is ShopErrorState) {
            Navigator.pushNamedAndRemoveUntil(context, RouteNames.addProduct, (route) => false,arguments: code);
          }
        },
        builder: (context, state) {
          if(state is ShopSuccesState){
            return Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                children: [
                  GlobalTextField(
                    caption: 'Product Count',
                    check: true,
                      hintText: 'Enter Product Count',
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      textAlign: TextAlign.start,
                      onChanged: (v) {
                        count = int.parse(v);
                      }),
                  const Spacer(),
                  GlobalButton(text: 'Buy', onTap: (){
                    try{
                      if(state.shopModel.first.count > 0){
                          productCount = state.shopModel.first.count - count;
                      context.read<ShopBloc>().add(UpdateProductEvent(shopModel: ShopModel(code: code, name: state.shopModel.first.name, count: productCount,id: state.shopModel.first.id)));
                       if(state.shopModel.first.count == 0){
                        context.read<ShopBloc>().add(DeleteProductEvent(id: state.shopModel.first.id!));
                      context.read<ShopBloc>().add(GetAllProductEvent());
                      }
                      context.read<ShopBloc>().add(GetAllProductEvent());
                      Navigator.pop(context);
                      showSnackbar(context, 'Mahsulot Muvafaqiyatli Sotildi');
                     
                      }else{
                        context.read<ShopBloc>().add(DeleteProductEvent(id: state.shopModel.first.id!));
                        Navigator.pushNamedAndRemoveUntil(context, RouteNames.addProduct, (route) => false,arguments: code);
                        showSnackbar(context, 'Mahsulot Qolmadi');
                      }
                      
                    }
                    catch(e){
                      debugPrint(e.toString());
                      
                    }
                  }),
                 const SizedBox(height: 24,),
                ],
              ),
            );
          }
          return const Center(child:  CircularProgressIndicator());
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
        code = qrCode.toString();
        context.read<ShopBloc>().add(GetProductEvent(code: code));
      });
    } on PlatformException {
      // code = 'Failed to scan QR Code.';
    }
  }
}
