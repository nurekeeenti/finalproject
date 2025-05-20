import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({super.key});

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  LatLng _initialPosition = const LatLng(37.7749, -122.4194); // fallback
  Set<Marker> _markers = {};
  double _zoom = 4.0;

  @override
  void initState() {
    super.initState();
    _setDefaultMarkers();
    _locateUser();
  }

  void _setDefaultMarkers() {
    _markers.addAll([
      const Marker(
        markerId: MarkerId("bali"),
        position: LatLng(-8.4095, 115.1889), // Bali
        infoWindow: InfoWindow(title: "Bali Resort"),
      ),
      const Marker(
        markerId: MarkerId("santorini"),
        position: LatLng(36.3932, 25.4615), // Santorini
        infoWindow: InfoWindow(title: "Santorini Escape"),
      ),
      const Marker(
        markerId: MarkerId("kyoto"),
        position: LatLng(35.0116, 135.7681), // Kyoto
        infoWindow: InfoWindow(title: "Kyoto Getaway"),
      ),
    ]);
  }

  Future<void> _locateUser() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    LocationPermission permission = await Geolocator.requestPermission();

    if (serviceEnabled && permission != LocationPermission.denied) {
      Position position = await Geolocator.getCurrentPosition();
      LatLng userPosition = LatLng(position.latitude, position.longitude);
      setState(() {
        _initialPosition = userPosition;
        _markers.add(
          Marker(
            markerId: const MarkerId("user_location"),
            position: userPosition,
            infoWindow: const InfoWindow(title: "You are here"),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
          ),
        );
      });
      final controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newLatLngZoom(userPosition, 6));
    }
  }

  void _zoomIn() async {
    final controller = await _controller.future;
    _zoom += 1;
    controller.animateCamera(CameraUpdate.zoomTo(_zoom));
  }

  void _zoomOut() async {
    final controller = await _controller.future;
    _zoom -= 1;
    controller.animateCamera(CameraUpdate.zoomTo(_zoom));
  }

  void _recenter() async {
    final controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLngZoom(_initialPosition, _zoom));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Google Map")),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _initialPosition,
              zoom: _zoom,
            ),
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            markers: _markers,
            zoomGesturesEnabled: true,
            scrollGesturesEnabled: true,
            rotateGesturesEnabled: true,
            onMapCreated: (controller) => _controller.complete(controller),
          ),
          Positioned(
            right: 10,
            bottom: 30,
            child: Column(
              children: [
                FloatingActionButton(
                  heroTag: 'zoomIn',
                  mini: true,
                  onPressed: _zoomIn,
                  child: const Icon(Icons.zoom_in),
                ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  heroTag: 'zoomOut',
                  mini: true,
                  onPressed: _zoomOut,
                  child: const Icon(Icons.zoom_out),
                ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  heroTag: 'recenter',
                  mini: true,
                  onPressed: _recenter,
                  child: const Icon(Icons.my_location),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
