import 'package:flutter/material.dart';
import 'package:belanja/models/item.dart';
import 'package:go_router/go_router.dart';                     // Import GoRouter for navigation

class MyHomePage extends StatelessWidget {
  final List<Item> items = [
    Item(
      name: 'Indomie Goreng', 
      price: 4000,
      foto: 'images/Indomie_goreng.png',
      stok: 10,
      rating: 4.5
    ),
    Item(
      name: 'Indomie Rendang', 
      price: 3000,
      foto: 'images/Indomie_rendang.png',
      stok: 15,
      rating: 4.2
    ),
    Item(
      name: 'Indomie Laksa', 
      price: 3500,
      foto: 'images/Indomie_laksa.png',
      stok: 15,
      rating: 4.2
    ),
    Item(
      name: 'Indomie Soto', 
      price: 3500,
      foto: 'images/Indomie_soto.png',
      stok: 15,
      rating: 4.2
    ),
    Item(
      name: 'Indomie Banglades', 
      price: 3500,
      foto: 'images/Indomie_banglades.png',
      stok: 15,
      rating: 4.2
    ),
    Item(
      name: 'Indomie Cabe Ijo', 
      price: 3500,
      foto: 'images/Indomie_cabeijo.png',
      stok: 15,
      rating: 4.2
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nanda Ricco - 244107060058'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        margin: EdgeInsets.all(8),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          padding: EdgeInsets.all(8),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return InkWell(
              onTap: () {
                context.push('/item', extra: item);   // Navigasi dengan GoRouter
              },
              child: Card(
                child: Container(
                  margin: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Expanded(
                        flex : 3,                                // 60% untuk gambar
                        child: Hero(                             // Hero Anmation
                          tag: 'product_${item.name}',          // Tag unik
                          child: Container(
                            width: double.infinity,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8),
                              ),
                              child: Image.asset(               // Gambar produk
                                item.foto,                      // Foto
                                fit: BoxFit.cover,
                              ),
                            )
                          ),
                        )
                      ),
                      Expanded(
                        flex: 2,                                  // 40% untuk info
                        child: Padding(
                          padding : EdgeInsets.only(left: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(item.name,),                    // ← nama produk
                              Text('Rp ${item.price}',),          // ← harga produk
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.star, color: Colors.orange, size: 14),
                                  SizedBox(width: 2),
                                  Text(item.rating.toString()),   //rating produk
                                ],
                              ),
                              Text('Stok: ${item.stok}'),         // ← STOK
                            ],
                          ),
                        )
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

