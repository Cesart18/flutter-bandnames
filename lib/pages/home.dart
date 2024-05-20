import 'dart:io';

import 'package:band_names/models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Band> bands = [
    Band(id: '1', name: 'Metalica', votes: 5),
    Band(id: '2', name: 'Viniloversus', votes: 4),
    Band(id: '3', name: 'Drake', votes: 2),
    Band(id: '4', name: 'La Vida Boheme', votes: 2),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('BandNames'),
        elevation: 2,
        shadowColor: Colors.grey,
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: ( _ , i ) => _bandTile(bands[i])
        ,),
        floatingActionButton: FloatingActionButton(
          onPressed: addNewBand,
          elevation: 2,
        child: const Icon(Icons.add),),
    );
  }




  Widget _bandTile(Band band) {
    return Dismissible(
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        // TODO: llamar el borrado en el server
      },
      background: Container(
        padding: const EdgeInsetsDirectional.only(start: 8),
        color: Colors.red,
        child: const Align(
          alignment: Alignment.centerLeft,
          child: Icon(Icons.delete, color: Colors.white,)),),
      key: Key(band.id),
      child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Text(_firstLetterToUpper(band.name.substring(0,2)),style: const TextStyle(color: Colors.white),),
            ),
            title: Text(band.name),
            trailing: Text('${band.votes}',
            style: const TextStyle(fontSize: 20),),
            onTap: () {
              print(band.name);
            },
          ),
    );
  }


  addNewBand(){

    final textController = TextEditingController();
    final isAndroid = Platform.isAndroid;

    isAndroid ? showDialog(context: context,
     builder: (context) {
        return AlertDialog(
          title: const Text('New Band name:'),
          content:  TextField(
            controller: textController,
          ),
          actions: [
            MaterialButton(
              textColor: Colors.blue,
              onPressed: () => addBandToList(textController.text),
              child: const Text('Add'))
          ],
        );
     },)
     : showCupertinoDialog(
      context: context,
       builder: (context) {
          return CupertinoAlertDialog(
            title: const Text('New Band name:'),
            content: CupertinoTextField(
            controller: textController,
          ),
          actions: [
            CupertinoDialogAction(
              isDestructiveAction: true,
              child: const Text('Dismiss'),
              onPressed: () => context.pop(),
              ),
            CupertinoDialogAction(
              isDefaultAction: true,
              child: const Text('Add'),
              onPressed: () => addBandToList(textController.text),
              ),
            
          ],
          );
       },);

     
  }

  void addBandToList( String name ){
    if( name.length > 1 ){
      bands.add( Band(id: DateTime.now().toString(), name: name, votes: 3) );
      setState(() {
      });
    }
    context.pop();
  }


  String _firstLetterToUpper( String value ){
    return value.substring(0,1).toUpperCase() + value.substring(1, value.length);
  }

}


