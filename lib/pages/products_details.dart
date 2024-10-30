import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:new_projects/custom_widgets/custom_appbar.dart';
import 'package:new_projects/custom_widgets/custom_button.dart';

class ProductsDetails extends StatefulWidget {
  final QueryDocumentSnapshot<Map<String, dynamic>> product;
  const ProductsDetails({super.key, required this.product});

  @override
  State<ProductsDetails> createState() => _ProductsDetailsState();
}

class _ProductsDetailsState extends State<ProductsDetails> {
  final user = FirebaseAuth.instance.currentUser;
  final List variable = [
    '20',
    '30',
    '40',
    '45',
    '50',
    '60',
    '33',
  ];
  int selectedIndex = 0;

  String? selectedVariant;

  void changeSelectedValue() {
    setState(() {
      selectedVariant = widget.product['variant'].isEmpty? 'null':widget.product['variant'][0];   });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    changeSelectedValue();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: customAppBar(
          backgroundColor: Colors.transparent,
          leadingIcon: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back))),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: size.height * .3,
                width: double.infinity,
                color: Colors.black26,
                child: Center(
                  child: Image.network(widget.product['image']!),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.product['name'] ?? 'Default Title',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 30,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 30,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 30,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 30,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 30,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                '\$${widget.product['price'] ?? 'Not Available Price'}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                          Text(
                            'Available in Stock',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.indigo),
                          ),
                        ]),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'About',
                      style: TextStyle(
                          color: Colors.indigo,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    Text(
                      widget.product['description'],
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 170,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 60,
              child: ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount: widget.product['variant'].length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                        selectedVariant = widget.product['variant'][index];
                      });
                    },
                    child: Container(
                      width: 70,
                      margin: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: selectedIndex == index ? Colors.indigo : null,
                        border: Border.all(color: Colors.indigo, width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                          child: Text(
                        widget.product['variant'][index],
                        style: TextStyle(
                          color: selectedIndex == index
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      )),
                    ),
                  );
                },
              ),
            ),
            CustomButton(
              title: 'Add To Cart',
              onTap: () async {
                await FirebaseFirestore.instance
                    .collection('Users')
                    .doc(user!.email)
                    .collection('card')
                    .add({
                  'Name': widget.product['name'],
                  'Id':widget.product['id'],
                  'Price': widget.product['price'],
                  'Image': widget.product['image'],
                  'Variant': selectedVariant,
                  'Quantity': 1
                }).then(
                  (value) => Fluttertoast.showToast(
                      msg: 'Card To Add Successfully',
                      backgroundColor: Colors.indigo,
                      textColor: Colors.white),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
