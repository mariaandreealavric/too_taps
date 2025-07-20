import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/Contatori/scroll_counter.dart';
import '../services/location_service.dart';

class DistanceCounterWidget extends StatefulWidget {
  const DistanceCounterWidget({super.key});

  @override
  State<DistanceCounterWidget> createState() => _DistanceCounterWidgetState();
}

class _DistanceCounterWidgetState extends State<DistanceCounterWidget> {
  final LocationService _locationService = LocationService();
  String _city = '';

  @override
  void initState() {
    super.initState();
    _initLocation();
  }

  Future<void> _initLocation() async {
    final position = await _locationService.getCurrentPosition();
    if (position != null) {
      final city = await _locationService.getCityFromPosition(position);
      if (mounted) {
        setState(() {
          _city = city;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final scrollCounter = Get.find<ScrollCounter>();
    return Obx(() {
      final distanceKm = scrollCounter.scrolls.value.toDouble();
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _city.isEmpty ? 'Unknown location' : 'City: $_city',
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          const SizedBox(height: 4),
          Text(
            'Distance from Earth: ${distanceKm.toStringAsFixed(0)} km',
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      );
    });
  }
}
