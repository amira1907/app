import 'package:ShopApp/models/DetielsModel.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatelessWidget {

  final DataDetails details;

  const ProductDetails({super.key, required this.details});




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Card(
              shadowColor: Colors.deepOrange,
              elevation: 5.0,
              child: Image(image: NetworkImage('${details.image}',),
                width: double.infinity,
                height: 200,
              ),
            ),
            SizedBox(height: 20.0,),
            Row(children: [
              Text('${details.name}',maxLines: 2,),
              Spacer(),
              Text('${details.price}'),
            ],),

            Spacer(),
            Container(
                width: 200.0,
                height: 50.0,
                color: Colors.orangeAccent,
                child: TextButton(onPressed: () {}, child: Text('Add To Card',style: TextStyle(color: Colors.white),),)),
          ],
        ),
      ),
    );
  }}