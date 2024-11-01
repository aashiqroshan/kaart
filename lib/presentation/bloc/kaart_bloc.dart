import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:the_kaart/domain/services/services.dart';

part 'kaart_event.dart';
part 'kaart_state.dart';

class KaartBloc extends Bloc<KaartEvent, KaartState> {
  final Services services;

  KaartBloc({required this.services}) : super(KaartInitial()) {
    on<LoadProducts>(_onLoadProducts);
    on<UpdateProduct>(_onUpdateProducts);
  }

  Future<void> _onLoadProducts(
      LoadProducts event, Emitter<KaartState> emit) async {
    emit(KaartLoading());
    try {
      final categorizedProducts = await fetchCategorizedProducts();
      emit(KaartLoaded(categorizedProducts));
    } catch (e) {
      emit(KaartError(e.toString()));
    }
  }

  Future<Map<String, List<dynamic>>> fetchCategorizedProducts() async {
    final url = Uri.parse('https://dummyjson.com/products');

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final Map<String, List<dynamic>> categorizedProducts = {};
      for (var product in data['products']) {
        final category = product['category'];
        if (categorizedProducts[category] == null) {
          categorizedProducts[category] = [];
        }
        categorizedProducts[category]!.add(product);
      }
      return categorizedProducts;
    } else {
      print('Failed to load data. Status code == ${response.statusCode}');
      throw Exception('failed to load products');
    }
  }

  Future<void> _onUpdateProducts(
      UpdateProduct event, Emitter<KaartState> emit) async {
    emit(KaartLoading());
    try {
      await services.updateProduct(event.productId, event.updatedData);
    } catch (e) {
      emit(KaartError(e.toString()));
    }
  }
}
