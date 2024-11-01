import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:the_kaart/pages/edit_product_page.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key, required this.product});
  final Map<String, dynamic> product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: const Offset(0, 3))
                  ],
                  borderRadius: BorderRadius.circular(8)),
              child: const Icon(Icons.arrow_back),
            )),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(product['images'][0]),
              Text(
                '\$ ${product['price'].toString()}',
                style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 27,
                    color: Colors.blue),
              ),
              Text(
                product['title'],
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                'About item',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(product['description']),
              const SizedBox(
                height: 12,
              ),
              RatingBar.builder(
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.yellow,
                ),
                onRatingUpdate: (value) {},
                initialRating: product['rating'],
                allowHalfRating: true,
                minRating: 1,
                maxRating: 5,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Quantity: ${product['stock']}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>  EditProductPage(product: product,),
                            ));
                      },
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.deepPurple),
                      child: const Text('Edit product'))
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.deepPurple,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.deepPurple,
              // padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40)
            ),
            child: const SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart),
                  SizedBox(
                    width: 10,
                  ),
                  Text('ADD TO CART')
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
