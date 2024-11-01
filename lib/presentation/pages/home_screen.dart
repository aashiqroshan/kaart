import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_kaart/presentation/bloc/kaart_bloc.dart';
import 'package:the_kaart/presentation/components/product_grid.dart';
import 'package:the_kaart/domain/services/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Services serv = Services();
  bool _isLoading = true;

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  void fetchData() async {
    await serv.getData();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(Icons.menu)),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.shopping_cart))
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Discover our exclusive products',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                    ),
                    const Text(
                      'In this marketplace, you will find various\n technics in the cheapest price',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    if (_isLoading)
                      const Center(
                        child: CircularProgressIndicator(),
                      )
                    else
                      BlocProvider(
                        create: (_) => KaartBloc(services: serv)..add(LoadProducts()),
                        child: BlocBuilder<KaartBloc, KaartState>(
                          builder: (context, state) {
                            if (state is KaartLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (state is KaartLoaded) {
                              return Column(
                                children: state.categorizedProducts.entries.map(
                                  (entry) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          entry.key,
                                          style: const TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                          height: 250,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: entry.value.length,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                child: ProductGrid(
                                                  product: entry.value[index],
                                                ),
                                              );
                                            },
                                          ),
                                        )
                                      ],
                                    );
                                  },
                                ).toList(),
                              );
                            } else if (state is KaartError) {
                              return Center(
                                child: Text('Error: ${state.message}'),
                              );
                            }
                            return Container();
                          },
                        ),
                      )
                  ])),
        ));
  }
}
