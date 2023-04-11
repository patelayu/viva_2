import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Helpers/db_helpers.dart';
import '../Model/models.dart';
import '../global.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  outOfStock() async {
    Future.delayed(const Duration(seconds: 30), () async {
      int a = Random().nextInt(Global.products.length);

      await DBHelper.dbHelper.updateRecord(quantity: 0, id: a);
    });
  }

  int second = 30;

  Duration? time() {
    Future.delayed(const Duration(seconds: 1), () {
      if (second > 0) {
        second--;

        print("==============");
        print("time: $second");
        print("==============");

        return time();
      } else {
        return null;
      }
    });
    return null;
  }

  Future? getData;

  @override
  void initState() {
    getData = DBHelper.dbHelper.fetchAllRecode();
    outOfStock();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar( backgroundColor: Color(0xffAF9B60),
        elevation: 1,
        title: const Text("Shopping App"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              CupertinoIcons.shopping_cart,
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder(
            future: getData,
            builder: (BuildContext context, AsyncSnapshot snapShot) {
              if (snapShot.hasError) {
                return Center(
                  child: Text(
                    "Error : ${snapShot.error}",
                  ),
                );
              } else if (snapShot.hasData) {
                List<ProductDB> data = snapShot.data;

                return Expanded(
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, i) => Padding(
                      padding: const EdgeInsets.all(10),
                      child: Card(
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(

                            height: h*0.12,
                            width: w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                const SizedBox(
                                  height: 2,
                                  width: 0,
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: SizedBox(
                                    height: 100,
                                    width: 90,
                                    child: Image(alignment: Alignment.bottomCenter,
                                      image: AssetImage(
                                        data[i].image!,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),SizedBox(width: 3,),
                                (data[i].quantity == 0)
                                    ? const Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Sold Out",
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red,
                                          ),
                                        ),
                                      )
                                    : Container(
                                ),
                                (Random().nextInt(
                                            (Global.products.length)) ==
                                        true)
                                    ? Align(
                                        alignment: Alignment.topRight,
                                        child: Text(
                                          "$second",
                                          style: const TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      )
                                    : Container(
                                ),
                                Text(
                                  "${data[i].name}",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(
                                  height: 0,
                                  width: 5,
                                ),
                                Text("Total items :"
                                  "${data[i].quantity}",
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width:10,),
                                ElevatedButton(
                                  onPressed: () {},
                                  child: Text(
                                    "Add to Cart",
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
      backgroundColor: Color(0xff483C32),
    );
  }
}
