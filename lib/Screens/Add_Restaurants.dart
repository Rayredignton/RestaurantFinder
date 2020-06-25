import 'dart:async';



import 'package:RestFinder/Services/crud.dart';
import 'package:flutter/material.dart';

//import 'package:cloud_firestore/cloud_firestore.dart';



class AddRestaurant extends StatefulWidget {
  @override
  _AddRestaurantState createState() => _AddRestaurantState();
}

class _AddRestaurantState extends State<AddRestaurant> {
  String resName;
  String resLocation;

  var cars;

  CrudMedthods crudObj = new CrudMedthods();

  Future<bool> addDialog(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Add Data', style: TextStyle(fontSize: 15.0)),
            content: Container(
                height: 125.0,
                width: 150.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(hintText: 'Enter Restaurant name'),
                    onChanged: (value) {
                      this.resName = value;
                    },
                  ),
                  SizedBox(height: 5.0),
                  TextField(
                    decoration: InputDecoration(hintText: 'Enter Restaurant location'),
                    onChanged: (value) {
                      this.resLocation = value;
                    },
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Add'),
                textColor: Colors.blue,
                onPressed: () {
                  Navigator.of(context).pop();
                  crudObj.addData({
                    'resName': this.resName,
                    'resLocation': this.resLocation
                  }).then((result) {
                    dialogTrigger(context);
                  }).catchError((e) {
                    print(e);
                  });
                },
              )
            ],
          );
        });
  }

  Future<bool> updateDialog(BuildContext context, selectedDoc) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Update Data', style: TextStyle(fontSize: 15.0)),
            content: Container(
              height: 125.0,
              width: 150.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(hintText: 'Enter Restaurant Name'),
                    onChanged: (value) {
                      this.resName = value;
                    },
                  ),
                  SizedBox(height: 5.0),
                  TextField(
                    decoration: InputDecoration(hintText: 'Enter Restaurant Name'),
                    onChanged: (value) {
                      this.resLocation = value;
                    },
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Update'),
                textColor: Colors.blue,
                onPressed: () {
                  Navigator.of(context).pop();
                  crudObj.updateData(selectedDoc, {
                    'resName': this.resName,
                    'resLocation': this.resLocation
                  }).then((result) {
                    // dialogTrigger(context);
                  }).catchError((e) {
                    print(e);
                  });
                },
              )
            ],
          );
        });
  }

  Future<bool> dialogTrigger(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Job Done', style: TextStyle(fontSize: 15.0)),
            content: Text('Added'),
            actions: <Widget>[
              FlatButton(
                child: Text('Restaurant Successfully Registered'),
                textColor: Colors.blue,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  @override
  void initState() {
    crudObj.getData().then((results) {
      setState(() {
        cars = results;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text('Add Restaurants'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                addDialog(context);
              },
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.pushNamed(context, "/Search_Rest");
              },
            ),
          ],
        ),
        body: Center());
  }
}
//   Widget _carList() {
//     if (cars != null) {
//       return StreamBuilder(
//         stream: cars,
//         builder: (context, snapshot) {
//           if (snapshot.data != null) {
//             return ListView.builder(
//               itemCount: snapshot.data.documents.length,
//               padding: EdgeInsets.all(5.0),
//               itemBuilder: (context, i) {
//                 return new ListTile(
//                   title: Text(snapshot.data.documents[i].data['carName']),
//                   subtitle: Text(snapshot.data.documents[i].data['color']),
//                   onTap: () {
//                     updateDialog(
//                         context, snapshot.data.documents[i].documentID);
//                   },
//                   onLongPress: () {
//                     crudObj.deleteData(snapshot.data.documents[i].documentID);
//                   },
//                 );
//               },
//             );
//           } 
//         },
//       );
//     } else {
//       return Text('Loading, Please wait..');
//     }
//   }
// }