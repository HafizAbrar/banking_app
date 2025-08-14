import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class SearchBranchScreen extends StatefulWidget {
  const SearchBranchScreen({super.key});

  @override
  State<SearchBranchScreen> createState() => _SearchBranchScreenState();
}

class _SearchBranchScreenState extends State<SearchBranchScreen> {
  LatLng? _currentLocation;
  List<Map<String, dynamic>> _banks = [];
  List<Map<String, dynamic>> _filteredBanks = [];
  bool _loading = false;
  bool _locationDenied = false;

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _checkPermissionAndLoad();
    _searchController.addListener(_filterBanks);
  }

  void _filterBanks() {
    final query = _searchController.text.trim();
    if (query.isEmpty) {
      setState(() {
        _filteredBanks = List.from(_banks);
      });
    } else {
      setState(() {
        _filteredBanks = _banks.where((bank) {
          final name = (bank['basicName'] as String).trim();
          return name.contains(query);
        }).toList();
      });
    }
  }

  Future<void> _checkPermissionAndLoad() async {
    setState(() {
      _loading = true;
    });
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _locationDenied = true;
        _loading = false;
      });
      return;
    }

    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      await _loadLocationAndBanks();
    } else {
      setState(() {
        _locationDenied = true;
        _loading = false;
      });
    }
  }

  Future<void> _loadLocationAndBanks() async {
    try {
      final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      final location = LatLng(position.latitude, position.longitude);
      final banks = await _fetchNearbyBanks(location);
      setState(() {
        _currentLocation = location;
        _banks = banks;
      });
      _filterBanks(); // apply filter based on current search text
    } catch (e) {
      print('Error: $e');
    }
    setState(() {
      _loading = false;
    });
  }

  Future<List<Map<String, dynamic>>> _fetchNearbyBanks(LatLng location) async {
    final lat = location.latitude;
    final lon = location.longitude;

    final overpassUrl = '''
https://overpass-api.de/api/interpreter?data=[out:json];
(
    node["amenity"="bank"](around:20000,$lat,$lon);
  way["amenity"="bank"](around:20000,$lat,$lon);
  relation["amenity"="bank"](around:20000,$lat,$lon);

);
out center;
''';

    final response = await http.get(Uri.parse(overpassUrl));

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    final data = json.decode(response.body);
    final banks = <Map<String, dynamic>>[];

    if (data['elements'] != null) {
      for (var el in data['elements']) {
        final bankLat = el['lat'] ?? el['center']?['lat'];
        final bankLon = el['lon'] ?? el['center']?['lon'];

        if (bankLat != null && bankLon != null) {
          final distance =
          Geolocator.distanceBetween(lat, lon, bankLat, bankLon);
          banks.add({
            'basicName': el['tags']?['name'] ?? 'Unnamed Bank',
            'lat': bankLat,
            'lon': bankLon,
            'distance': distance,
          });
        }
      }
    }

    banks.sort((a, b) => a['distance'].compareTo(b['distance']));
    return banks;
  }

  @override
  Widget build(BuildContext context) {
    print(_banks);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        title: const Text(
          'Branch',
          style:
          TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _locationDenied
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Location permission denied.',
                style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                Geolocator.openAppSettings();
              },
              child: const Text('Open App Settings'),
            ),
          ],
        ),
      )
          : _currentLocation == null
          ? const Center(child: Text('Could not get location'))
          : Stack(
        children: [
          // Map full screen
          FlutterMap(
            options: MapOptions(
             initialCenter : _currentLocation!,
              initialZoom: 14.0,
            ),
            children: [
              TileLayer(
                urlTemplate:
                'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: ['a', 'b', 'c'],
              ),
              MarkerLayer(
                markers: [
                  // user location
                  Marker(
                    width: 40,
                    height: 40,
                    point: _currentLocation!,
                    child: const Icon(
                      Icons.person_pin_circle,
                      color: Colors.blue,
                      size: 36,
                    ),
                  ),
                  // banks
                  ..._filteredBanks.map((bank) => Marker(
                    width: 40,
                    height: 40,
                    point: LatLng(bank['lat'], bank['lon']),
                    child: const Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 30,
                    ),
                  ))
                ],
              ),
            ],
          ),
          // Bottom container with rounded corners
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // search box
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        controller: _searchController,
                        decoration: const InputDecoration(
                          hintText: 'Search banks...',
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.search),
                        ),
                      ),
                    ),
                  ),
                  // List of banks
                  Expanded(
                    child: _searchController.text.isEmpty
                        ? const Center(
                      child: Text('Please enter a bank name to search'),
                    )
                        : _filteredBanks.isEmpty
                        ? const Center(child: Text('No results found'))
                        : ListView.builder(
                      itemCount: _filteredBanks.length,
                      itemBuilder: (context, index) {
                        final bank = _filteredBanks[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            leading: const Icon(Icons.account_balance_outlined),
                            title: Text(bank['basicName']),
                            trailing: Text(
                              '${(bank['distance'] / 1000).toStringAsFixed(2)} km',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
