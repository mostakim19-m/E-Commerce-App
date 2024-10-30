import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Pbc extends StatefulWidget {
  final QueryDocumentSnapshot<Map<String, dynamic>> category;
  const Pbc({super.key, required this.category});

  @override
  State<Pbc> createState() => _PbcState();
}

class _PbcState extends State<Pbc> {
  final fireStore=FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category['name']),
      ),
      body: StreamBuilder(stream:fireStore.collection('categories').snapshots() ,
        builder: (context, snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }else{
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final data=snapshot.data!.docs[index];
              return Card(child: ListTile(
                title: Text(data['name']),
                subtitle: Text('\$${data['id']}'),
              ),);
            },);
          }
        },),
    );
  }
}
