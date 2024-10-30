import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_projects/custom_widgets/custom_appbar.dart';
import 'package:new_projects/pages/categories/pbc.dart';
import 'package:new_projects/pages/login_screen.dart';
import 'package:new_projects/pages/products_details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final fireStore=FirebaseFirestore.instance;

  List fireStoreSlider=[];

  getSlider ()async{
  final data= await fireStore.collection('banners').get();

  setState(() {
    fireStoreSlider=data.docs;
  });
  }

  @override
  void initState() {
    super.initState();
    getSlider();
  }


  
  List<Map<String,String>> categories=[
    {
      'icon': 'images/images1.png'
    },
    {
      'icon': 'images/images2.png'
    },
    {
      'icon': 'images/images1.png'
    },
    {
      'icon': 'images/images2.png'
    },
    {
      'icon': 'images/images1.png'
    },
  ];

  List<Map<String,String>> products=[
    {
      'image':'https://i.pinimg.com/736x/10/8e/3d/108e3d05fbd07fcde04edfa14f540cac.jpg',
      'name':'Apple Watch',
    },
    {
      'image':'https://icon2.cleanpng.com/20180523/sfw/avqcoevdl.webp',
      'price':'480'
    },
    {

      'image':'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWOomfndQzrIWjFfXeLjFOScduUiYW4PmptA&s',
      'name':'Redmi Watch',
      'price':'180'
    },
    {

      'image':'https://img.freepik.com/premium-photo/hanging-colorful-sweater-clothes_1034016-19822.jpg',
      'name':'Samsung Watch',
      'price':'780'
    },
    {

      'image':'https://img.freepik.com/premium-photo/hanging-colorful-sweater-clothes_1034016-19822.jpg',
      'name':'Brand Watch',
      'price':'380'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        leadingIcon: IconButton(onPressed: () {
          FirebaseAuth.instance.signOut();
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen(),), (route) => false,);
        }, icon: Icon(Icons.menu)),
        action: [Icon(Icons.search_rounded)],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello Foll  👋',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo,
                        fontSize: 20),
                  ),
                  Text('Hello How are?'),
                ],
              ),
            ),
            SizedBox(height: 10,),
            CarouselSlider.builder(
              itemCount: fireStoreSlider.length,
              itemBuilder: (context, index, realIndex) {
                return fireStoreSlider.isEmpty?Center(child: CircularProgressIndicator(),):
                Container(
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(image: NetworkImage(fireStoreSlider [index] ['image']),fit: BoxFit.cover)
                  ),
                );
              },
              options:CarouselOptions(
                height: 150,
                enableInfiniteScroll: true,
                reverse: false,
                // autoPlay: true,
                autoPlayInterval: Duration(seconds: 2),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
              ),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Top Categories',style: TextStyle(
                  color:Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),),
                Text('See all',style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.indigo
                ),)
              ],
            ),
            SizedBox(height: 10,),
            StreamBuilder(stream: fireStore.collection('categories').snapshots(), builder: (context, snapshot) {
              if(snapshot.connectionState==ConnectionState.waiting){
                return Center(child: CircularProgressIndicator(),);
              }else{
                return SizedBox(
                  height:90,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.docs.length,
                    shrinkWrap: true,
                    primary: false,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>
                              Pbc(category: snapshot.data!.docs[index],),));
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 10),
                          width: 66,
                          decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: Colors.indigo,
                                  width: 2
                              )
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(child:
                              Image.network(snapshot.data!.docs[index]['icon']!),),
                              Text(snapshot.data!.docs[index]['name'],style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.bold
                              ),)
                            ],
                          ),
                        ),
                      );
                    },),
                ) ;
              }
            },),


            SizedBox(height: 20,),
            Expanded(
              child: StreamBuilder(stream: fireStore.collection('products').snapshots(),
                builder: (context, snapshot) {
                if(snapshot.connectionState==ConnectionState.waiting){
                  return Center(child: CircularProgressIndicator(),);
                }else{
                  return GridView.builder(
                    shrinkWrap: true,
                    primary: true,
                    itemCount: snapshot.data!.docs.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 15,
                        childAspectRatio: .8,
                        mainAxisSpacing: 15,
                        crossAxisCount: 2 ),
                    itemBuilder: (context, index) {
                      final data=snapshot.data!.docs[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder:
                              (context) => ProductsDetails(product: data,),));
                        },
                        child: Container(
                          width: 400,
                          height: 400,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black,
                                  width: 2
                              ),
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 150,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(image: NetworkImage(
                                        data['image']!),
                                        fit: BoxFit.cover)
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    IconButton(onPressed: (){}, icon: Icon(Icons.favorite_border)),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(data['name']?? 'Default Title',style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold
                                ),),
                              ),
                              Row(
                                children: [
                                  Text('  \$ ${data['price']?? 'No Price'}',style: TextStyle(
                                      color:Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16
                                  ),),
                                  SizedBox(width: 20,),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },);
                }
              },),
            )
          ],
        ),
      ),
    );
  }
}

