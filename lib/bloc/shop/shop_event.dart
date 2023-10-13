part of 'shop_bloc.dart';

@immutable
abstract class ShopEvent {}


class ProductAddEvent extends ShopEvent{
  final ShopModel shopModel;

  ProductAddEvent({required this.shopModel});
}

class DeleteAllProductEvent extends ShopEvent{}

class GetAllProductEvent extends ShopEvent{}

class UpdateProductEvent extends ShopEvent {
  final ShopModel shopModel;
  UpdateProductEvent({required this.shopModel});
}

class GetProductByAlphabet extends ShopEvent{
  final String query;

  GetProductByAlphabet({required this.query});
}

class DeleteProductEvent extends ShopEvent {
  final int id;

  DeleteProductEvent({required this.id});
}

class GetProductEvent extends ShopEvent {
  final String code;

  GetProductEvent({required this.code});
}