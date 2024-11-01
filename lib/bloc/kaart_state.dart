part of 'kaart_bloc.dart';

@immutable
sealed class KaartState {}

final class KaartInitial extends KaartState {}

final class KaartLoading extends KaartState {}

final class KaartLoaded extends KaartState {
  final Map<String, List<dynamic>> categorizedProducts;
  KaartLoaded(this.categorizedProducts);
}

final class KaartError extends KaartState {
  final String message;
  KaartError(this.message);
}

final class UpdateProducts extends KaartEvent {
  final int productId;
  final Map<String, dynamic> updatedData;

  UpdateProducts(this.productId,this.updatedData);
}
