import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_kaart/bloc/kaart_bloc.dart';

class EditProductPage extends StatefulWidget {
  EditProductPage({super.key, required this.product});
  final Map<String, dynamic> product;

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  late final TextEditingController nameController;
  late final TextEditingController descriptionController;
  late final TextEditingController priceController;
  late final TextEditingController stockController;

  @override
  void initState() {
    nameController = TextEditingController(text: widget.product['title']);
    descriptionController =
        TextEditingController(text: widget.product['description']);
    priceController =
        TextEditingController(text: widget.product['price'].toString());
    stockController =
        TextEditingController(text: widget.product['stock'].toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                  hintText: 'Title', border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                  hintText: 'Description', border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: stockController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  hintText: 'Stocks', border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Price',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  final updatedData = {
                    'title': nameController.text,
                    'description': descriptionController.text,
                    'price': double.parse(priceController.text),
                    'stock': int.parse(stockController.text)
                  };

                  context
                      .read<KaartBloc>()
                      .add(UpdateProduct(widget.product['id'], updatedData));
                  Navigator.pop(context);
                  _showSuccessDialog(context);
                },
                child: const Text('Update'))
          ],
        ),
      ),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Success'),
        content: const Text('The product has been updated successfully.'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'))
        ],
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    stockController.dispose();
    priceController.dispose();
    super.dispose();
  }
}
