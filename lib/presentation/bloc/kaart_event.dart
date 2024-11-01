part of 'kaart_bloc.dart';

@immutable
sealed class KaartEvent {}

class LoadProducts extends KaartEvent {}

final class UpdateProduct extends KaartEvent {
  final int productId;
  final Map<String, dynamic> updatedData;

  UpdateProduct(this.productId,this.updatedData);
}
