import 'package:flutter/material.dart';
import 'package:provider/provider.dart';          // <-- подключаем провайдер
import '../providers/app_state.dart';            // <-- подключаем наше состояние
import '../models/place.dart';

class PlaceCard extends StatelessWidget {
  final Place place;
  final VoidCallback onTap;

  const PlaceCard({
    Key? key,
    required this.place,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final isFavorite = appState.favoritePlaces.contains(place);

    return GestureDetector(
      onTap: onTap, // всё ещё переходим к DestinationDetailScreen при тапе
      child: Container(
        width: 200,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [BoxShadow(blurRadius: 6, color: Colors.black12)],
        ),
        child: Stack(
          children: [
            // Основное содержимое карточки
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Image.network(
                    place.imageUrl,
                    height: 140,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        place.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        place.description,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Ставим иконку поверх (в правом верхнем углу)
            Positioned(
              top: 8,
              right: 8,
              child: InkWell(
                onTap: () {
                  appState.toggleFavorite(place);
                },
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  // никакой заливки и тени
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(6),
                  child: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
