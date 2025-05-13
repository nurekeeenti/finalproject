import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/place.dart';
import '../providers/app_state.dart';

class DestinationDetailScreen extends StatelessWidget {
  final Place place;

  const DestinationDetailScreen({Key? key, required this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final isFavorite = appState.favoritePlaces.contains(place);

    return Scaffold(
      appBar: AppBar(
        title: Text(place.name),
      ),
      body: ListView(
        children: [
          Stack(
            children: [
              Image.network(
                place.imageUrl,
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 16,
                right: 16,
                child: GestureDetector(
                  onTap: () {
                    appState.toggleFavorite(place);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black45, // Полупрозрачный фон для контраста
                    ),
                    padding: const EdgeInsets.all(4),
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Colors.white,
                      size: 32,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  place.name,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  place.description,
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
