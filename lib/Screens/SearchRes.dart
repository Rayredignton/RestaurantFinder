import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:RestFinder/Services/searchService.dart';

class SearchRes extends StatefulWidget {
  @override
  _SearchResState createState() => _SearchResState();
}

class _SearchResState extends State<SearchRes> {
  var queryResultSet = [];
  var tempSearchStore = [];
  initiateSearch(value){
    if(value.lenght == 0){
      
    
  setState(() {
        queryResultSet = [];
        tempSearchStore = [];
    });

  }
  var capitalizedValue = 
  value.subString(0,1).toUpperCase() + value.substring(1);

  if(queryResultSet.length == 0 && value.length == 1) {
     SearchService().searchByName(value).then((QuerySnapshot docs){
      for(int i = 0; i< docs.documents.length; ++i ){
        queryResultSet.add(docs.documents[i].data);
      }
    });
  }
  else{
    tempSearchStore = [];
    queryResultSet.forEach((element) {
      if(element['RestaurantName'].startsWith(capitalizedValue)){
        setState(() {
          tempSearchStore.add(element);
        });
      }
    });
  }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurant Search'),
      ),
      body: ListView(
        children: [
          Padding(padding: const EdgeInsets.all(10.0),
          child: TextField(
            onChanged: (val){
              initiateSearch(val);
            },
            decoration: InputDecoration(
              prefixIcon: IconButton(
                color: Colors.black,
                icon: Icon(Icons.arrow_back),
                iconSize: 20.0,
                onPressed: (){
                  Navigator.of(context).pop();
                },
                ),
                contentPadding: EdgeInsets.only(left: 25.0),
                hintText: 'Search Restaurants',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0))),
                ),
            ),
            SizedBox(height: 10.0),
            GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0,
              primary: false,
              shrinkWrap: true,
              children: tempSearchStore.map((element){
                return buildResultCard(element);
              }).toList())
               ]));
  }
}
  Widget buildResultCard(data){
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 2.0,
      child: Container(
        child: Center(
          child: Text(data['Restaurant Name'],
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          fontSize: 20.0,
        )
        ),)
      ),
    );
 
}