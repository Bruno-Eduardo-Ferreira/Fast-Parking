import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ConsultaCliente extends StatefulWidget {
  const ConsultaCliente({ Key? key }) : super(key: key);

  @override
  State<ConsultaCliente> createState() => _ConsultaClienteState();
}

class _ConsultaClienteState extends State<ConsultaCliente> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> _getList(){
    return _firestore.collection('clientes').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child:
      StreamBuilder<QuerySnapshot>(
        stream: _getList(),
        builder: ( context, snapshot){ 
          switch(snapshot.connectionState){
            case ConnectionState.none:

            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator(),
              );
  
            case ConnectionState.active:

            case ConnectionState.done:

              if(snapshot.data!.docs.isEmpty){
                return const Center(
                  child: Text('Não possui cliente'),
                );
              }

              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) { 
                  final DocumentSnapshot doc = snapshot.data!.docs[index];
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(28, 12, 28, 12),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration( 
                                border: Border.all(width: 0.5, color: Colors.black38),
                                borderRadius: const BorderRadius.all(Radius.circular(6.0)),
                                color: Colors.white,
                              ),
                      child: ListTile(
                        title: Text(
                          doc['nome'], style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
                          ),
                      ),
                    ),
                  );
                
              }
              );
          }
        }
      )
      ),
      
    );
  }
}