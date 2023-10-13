part of 'shop_bloc.dart';

@immutable
abstract class ShopState extends Equatable{}

class ShopInitial extends ShopState {
  @override
  List<Object?> get props => [];
}


class ShopLoadingState extends ShopState{
  @override
  List<Object?> get props => [];
}

class ShopErrorState extends ShopState{
  final String errorText;

  ShopErrorState({required this.errorText});

  @override
  List<Object?> get props => [errorText];
}

class ShopSuccesState extends ShopState{
final List<ShopModel> shopModel;

ShopSuccesState({required this.shopModel});

  @override
  List<Object?> get props => [shopModel];
}
