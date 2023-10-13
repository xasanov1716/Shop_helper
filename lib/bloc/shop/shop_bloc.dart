import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:last_task/data/local/db/local_database.dart';
import 'package:last_task/data/models/shop/shop_model_sql.dart';
import 'package:meta/meta.dart';

part 'shop_event.dart';
part 'shop_state.dart';

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  ShopBloc() : super(ShopInitial()) {
  on<ProductAddEvent>(_addProduct);
  on<GetProductEvent>(_getProductByCode);
  on<UpdateProductEvent>(_updateProduct);
  on<GetAllProductEvent>(_getAllProduct);
  on<DeleteProductEvent>(_deleteProduct);
  on<DeleteAllProductEvent>(_deleteAllProduct);
  on<GetProductByAlphabet>(_getProductByAlphabet);
  }


  _addProduct(ProductAddEvent event, Emitter<ShopState> emit)async{
    emit(ShopLoadingState());
    try{
      await LocalDatabase.insertProduct(event.shopModel);
      emit(ShopSuccesState(shopModel: [ShopModel(name: '',code: '',count: 0)]));
    }
    catch(e){
      emit(ShopErrorState(errorText: e.toString()));
    }
  }


  _deleteProduct(DeleteProductEvent event, Emitter<ShopState> emit)async{
    emit(ShopLoadingState());
    try{
      await LocalDatabase.deleteProduct(event.id);
      emit(ShopSuccesState(shopModel: [ShopModel(name: '',code: '',count: 0)]));
      debugPrint('DELETE PRODUCT ISHLADI');
    }
    catch(e){
      emit(ShopErrorState(errorText: e.toString()));
    }
  }


  _updateProduct(UpdateProductEvent event, Emitter<ShopState> emit)async{
    emit(ShopLoadingState());
    try{
      await LocalDatabase.updateProduct(shopModel: event.shopModel);
      emit(ShopSuccesState(shopModel: [ShopModel(name: '',code: '',count: 0)]));
    }
    catch(e){
      emit(ShopErrorState(errorText: e.toString()));
    }
  }


  _getProductByAlphabet(GetProductByAlphabet event,Emitter<ShopState> emit)async{
    emit(ShopLoadingState());
    List<ShopModel> shop;
    try{
      shop =  await LocalDatabase.getProductByAlphabet(event.query);
      emit(ShopSuccesState(shopModel: shop));
    }
    catch(e){
      emit(ShopErrorState(errorText: e.toString()));
    }
  }

  _getAllProduct(GetAllProductEvent event,Emitter<ShopState> emit)async{
    emit(ShopLoadingState());
    List<ShopModel> shop;
    try{
      shop =  await LocalDatabase.getAllProduct();
      emit(ShopSuccesState(shopModel: shop));
    }
    catch(e){
      emit(ShopErrorState(errorText: e.toString()));
    }
  }


  _deleteAllProduct(DeleteAllProductEvent event, Emitter<ShopState> emit)async{
    emit(ShopLoadingState());
    try{
      await LocalDatabase.deleteTable();
      emit(ShopSuccesState(shopModel: [ShopModel(name: '',code: '',count: 0)]));
    }
    catch(e){
      emit(ShopErrorState(errorText: e.toString()));
    }
  }

  _getProductByCode(GetProductEvent event, Emitter<ShopState> emit)async{
    emit(ShopLoadingState());
    ShopModel? shopModel;
    try{
     shopModel =  await LocalDatabase.getSingleProduct(event.code);
      emit(ShopSuccesState(shopModel: [shopModel!]));
    }
    catch(e){
      emit(ShopErrorState(errorText: e.toString()));
    }
  }



}
