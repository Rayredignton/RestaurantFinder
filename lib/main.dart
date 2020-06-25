
import 'package:RestFinder/Screens/Add_Restaurants.dart';
import 'package:RestFinder/Screens/SearchRes.dart';
import 'package:RestFinder/Screens/login.dart';
//import 'package:RestFinder/Screens/search.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';



import 'package:RestFinder/Services/geolocator_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:RestFinder/Services/placesService.dart';
import 'package:RestFinder/models/place.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  final locatorService = GeoLocatorService();
  final placesService = PlacesService();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        FutureProvider(create: (context) => locatorService.getLocation()),
        FutureProvider(create: (context) {
          ImageConfiguration configuration = createLocalImageConfiguration(context);
          return BitmapDescriptor.fromAssetImage(configuration, 'assets/images/parking-icon.png');
        }),
        ProxyProvider2<Position,BitmapDescriptor,Future<List<Place>>>( 
          update: (context,position,icon,places){
            return (position !=null) ? placesService.getPlaces(position.latitude, position.longitude,icon) :null;
          },
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
            initialRoute: '/',
           routes: {
             '/Search_page': (context) => AddRestaurant(),
             '/Search_Rest': (context) => SearchRes(),
           },
        title: 'Restaurant',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LoginScreen(),
      ),
    );
  }
}

