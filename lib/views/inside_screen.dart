import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:olaapp/helper/divider_line.dart';

class InsideScreen extends StatefulWidget {
  const InsideScreen({Key? key}) : super(key: key);

  @override
  _InsideScreenState createState() => _InsideScreenState();
}

class _InsideScreenState extends State<InsideScreen> {
  Completer<GoogleMapController> _controllerGoogleMap = Completer();

  late GoogleMapController newGoogleMapController;

  double bottomPaddingOfMap = 0;

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  late Position
      currentPosition; //to find the current position(lang, lat) of the user
  var geoLocator =
      Geolocator(); //instance of geolocator // to find the current position

  void locatePosition() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy
            .high); //.high means to get the max(highest) accuracy of the user, accurate.
    currentPosition = position;

    LatLng latLangPosition = LatLng(
        position.latitude,
        position
            .longitude); //--> this var stores the value of lang, lat ofthe current users's current position

    //now when you move left and right your camera animates left and right, this is what i have written down below.
    CameraPosition cameraPosition = new CameraPosition(
        target: latLangPosition,
        zoom:
            14); //creating an instance of new cameraposition when you move left or right to animate
    newGoogleMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    //this was predefined when you apply google_image dependency to your application.
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: Container(
        color: Colors.white,
        width: 55,
        child: Drawer(
          child: ListView(
            children: <Widget>[
              Container(
                height: 165,
                child: DrawerHeader(
                  decoration: BoxDecoration(color: Colors.white),
                  child: Row(
                    children: [
                      Image.asset(
                        "images/user_icon.png",
                        height: 65,
                        width: 65,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Profile Name",
                            style: TextStyle(fontSize: 15),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text("Visit Profile"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              DividerLine(),
              SizedBox(
                height: 12,
              ),
              //Drawer Body Controllers
              ListTile(
                leading: Icon(Icons.history),
                title: Text(
                  "History",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text(
                  "Profile",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: Text(
                  "About",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ), //app drawer ends here
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
              padding: EdgeInsets.only(bottom: bottomPaddingOfMap),
              mapType: MapType.normal,
              myLocationButtonEnabled: true,
              initialCameraPosition: _kGooglePlex,
              myLocationEnabled:
                  true, //these three gives you the blue icon of above your current location
              zoomGesturesEnabled: true,
              zoomControlsEnabled: true,
              onMapCreated: (GoogleMapController controller) {
                //whenever the map is created
                _controllerGoogleMap.complete(controller);
                newGoogleMapController = controller;

                setState(() {
                  bottomPaddingOfMap = 300;
                });

                locatePosition(); //locatecurrent position var declared above
              }),

          //hamburger button for drawyer
          GestureDetector(
            onTap: () {
              scaffoldKey.currentState!.openDrawer();
            },
            child: Positioned(
              top: 45,
              left: 22,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 6,
                      spreadRadius: 0.5,
                      offset: Offset(0.7, 0.7),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.menu,
                    color: Colors.black,
                  ),
                  radius: 20,
                ),
              ),
            ),
          ),

          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                child: Container(
                  height: 320,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(18),
                      topRight: Radius.circular(18),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 1,
                        spreadRadius: 0.1,
                        offset: Offset(0.5, 0.5),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                          child: Text(
                            "Hi there",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        SizedBox(
                          height: 1,
                        ),
                        SizedBox(
                          height: 25,
                          child: Text(
                            "Your Destination. ",
                            style: TextStyle(fontSize: 25),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 50,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black54,
                                  blurRadius: 2,
                                  spreadRadius: 0.1,
                                  offset: Offset(0.7, 0.7),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.search, color: Colors.green),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Search Destination.",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          //first search button
                          height: 50,
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.home,
                                color: Colors.black54,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Add Home",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  SizedBox(
                                    height: 10,
                                    child: Text(
                                      "Home Address",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        DividerLine(),
                        SizedBox(
                          height: 16,
                        ),
                        SizedBox(
                          //second search button
                          height: 40,
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.work,
                                color: Colors.black54,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Add Work",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  SizedBox(
                                    height: 10,
                                    child: Text(
                                      "Office Address",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
