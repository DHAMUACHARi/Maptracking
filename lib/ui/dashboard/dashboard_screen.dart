import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart' as loc;
import 'package:real_time_maps/resources/color_resources.dart';

class DashboardScreen extends StatefulWidget {
  final String email;

  const DashboardScreen({Key? key, required this.email}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late GoogleMapController _mapControllerA;
  GoogleMapController? _mapControllerB;

  loc.LocationData? _userALocation;
  loc.LocationData? _userBLocation;

  final loc.Location _location = loc.Location();

  final DatabaseReference userALocationRef = FirebaseDatabase.instanceFor(
    app: Firebase.app(),
    databaseURL: 'https://real-time-maps-b5cd0-default-rtdb.firebaseio.com/',
  ).ref("users/userA_id/location");

  final DatabaseReference userBLocationRef = FirebaseDatabase.instanceFor(
    app: Firebase.app(),
    databaseURL: 'https://real-time-maps-b5cd0-default-rtdb.firebaseio.com/',
  ).ref("users/userB_id/location");

  bool _isUserALocationFetched = false;
  bool _isUserBLocationFetched = false;

  @override
  void initState() {
    super.initState();
    _initializeLocationService();
    _listenToUserLocations();
  }

  void _initializeLocationService() async {
    bool serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) return;
    }

    loc.PermissionStatus permissionStatus = await _location.hasPermission();
    if (permissionStatus != loc.PermissionStatus.granted) {
      permissionStatus = await _location.requestPermission();
      if (permissionStatus != loc.PermissionStatus.granted) return;
    }

    _location.onLocationChanged.listen((locationData) {
      setState(() {
        _isUserALocationFetched = true;
      });
    });
  }

  void _listenToUserLocations() {
    userALocationRef.once().then((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;
      if (data != null) {
        final latitude = data['latitude'];
        final longitude = data['longitude'];

        double? lat = latitude is double ? latitude : double.tryParse(latitude.toString());
        double? lng = longitude is double ? longitude : double.tryParse(longitude.toString());

        if (lat != null && lng != null) {
          setState(() {
            _userALocation = loc.LocationData.fromMap({
              'latitude': lat,
              'longitude': lng,
            });
            _isUserALocationFetched = true;
          });
        }
      }
    });

    // Listen to User B's location in Firebase
    userBLocationRef.onValue.listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;
      if (data != null) {
        final latitude = data['latitude'];
        final longitude = data['longitude'];

        double? lat = latitude is double ? latitude : double.tryParse(latitude.toString());
        double? lng = longitude is double ? longitude : double.tryParse(longitude.toString());

        if (lat != null && lng != null) {
          setState(() {
            _userBLocation = loc.LocationData.fromMap({
              'latitude': lat,
              'longitude': lng,
            });
            _isUserBLocationFetched = true;
          });

          if (_mapControllerB != null) {
            _mapControllerB!.animateCamera(
              CameraUpdate.newLatLng(LatLng(lat, lng)),
            );
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.grey.shade100,
      appBar: AppBar(
        title: Text(
          "Dashboard - ${widget.email}",
          style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == "signout") {
                _signOut();
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<String>(
                  value: "signout",
                  child: Text('Sign out'),
                ),
              ];
            },
          )
        ],
      ),
      body: _isUserALocationFetched && _isUserBLocationFetched
          ? SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "User A Map",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: buttonColor1,
                ),
              ),
            ),
            _buildGoogleMap(_userALocation, "User A", true),
             Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "User B Map",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: buttonColor1,
                ),
              ),
            ),
            _buildGoogleMap(_userBLocation, "User B", false),
          ],
        ),
      )
          :  Center(
        child: CircularProgressIndicator(
          color: buttonColor1,
          strokeWidth: 2,
        ),
      ),
    );
  }

  Widget _buildGoogleMap(loc.LocationData? location, String markerId, bool isUserBMap) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Container(
        height: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 8,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(location?.latitude ?? 0.0, location?.longitude ?? 0.0),
            zoom: 14.0,
          ),
          markers: {
            Marker(
              markerId: MarkerId(markerId),
              position: LatLng(location?.latitude ?? 0.0, location?.longitude ?? 0.0),
              infoWindow: InfoWindow(title: markerId),
            ),
          },
          onMapCreated: isUserBMap
              ? (controller) {
            _mapControllerB = controller;
          }
              : (controller) {
            _mapControllerA = controller;
          },
        ),
      ),
    );
  }

  void _signOut() {
    context.push('/sign_out', extra: widget.email);
  }
}
