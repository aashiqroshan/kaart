import 'package:flutter/material.dart';
import 'package:the_kaart/pages/product_page.dart';

class ProductGrid extends StatelessWidget {
  ProductGrid({required this.product, super.key});
  final Map<String, dynamic> product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductPage(product: product,),
            ));
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(10)),
        height: 250,
        width: 180,
        padding: EdgeInsets.all(8),
        child: Stack(children: [
          Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  product['thumbnail'],
                  height: 140,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                product['title'],
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                product['description'],
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                '\$${product['price']}',
                style: const TextStyle(
                    color: Colors.green,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
          Positioned(
              top: 4,
              right: 4,
              child: Container(
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                  child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.favorite_border,
                        size: 20,
                      ))))
        ]),
      ),
    );
  }
}
