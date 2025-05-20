import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart_item.dart';
import '../providers/app_state.dart';
import '../db/db_helper.dart';
import 'profile_screen.dart';
import 'package:travel_app/generated/l10n.dart';

class Trip {
  final String title;
  final String imageUrl;
  final String date;
  final String description;
  final int guests;

  Trip({
    required this.title,
    required this.imageUrl,
    required this.date,
    required this.description,
    required this.guests,
  });
}

class EnhancedTripsScreen extends StatefulWidget {
  const EnhancedTripsScreen({Key? key}) : super(key: key);

  @override
  State<EnhancedTripsScreen> createState() => _EnhancedTripsScreenState();
}



class _EnhancedTripsScreenState extends State<EnhancedTripsScreen> {
  late List<Trip> trips;

  @override
  void initState() {
    super.initState();
    final s = S.current;
    trips = [
      Trip(
        title: s.tripToBali,
        imageUrl: 'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
        date: '20/09/2025',
        description: s.descBali,
        guests: 2,
      ),
      Trip(
        title: s.tripToSantorini,
        imageUrl: 'https://plus.unsplash.com/premium_photo-1661964149725-fbf14eabd38c',
        date: '15/10/2025',
        description: s.descSantorini,
        guests: 3,
      ),
      Trip(
        title: s.tripToKyoto,
        imageUrl: 'https://images.unsplash.com/photo-1493976040374-85c8e12f0c0e',
        date: '05/11/2025',
        description: s.descKyoto,
        guests: 1,
      ),
    ];
  }

  String searchQuery = '';
  String sortOption = 'Alphabetical';

  List<Trip> get filteredTrips {
    final filtered = trips
        .where((trip) => trip.title.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    if (sortOption == 'Alphabetical') {
      filtered.sort((a, b) => a.title.compareTo(b.title));
    } else if (sortOption == 'Date') {
      filtered.sort((a, b) => _parseDate(a.date).compareTo(_parseDate(b.date)));
    }

    return filtered;
  }

  DateTime _parseDate(String date) {
    final parts = date.split('/');
    return DateTime(int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]));
  }

  final _formKey = GlobalKey<FormState>();
  String? _newTitle;
  DateTime? _newDate;
  double _newGuests = 1;
  final String _newImageUrl = 'https://images.unsplash.com/photo-1677842296338-eeb8c866d22c?q=80';

  Future<void> _showAddTripModal() async {
    _newTitle = null;
    _newDate = null;
    _newGuests = 1;

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        final s = S.of(context);
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Wrap(
                children: [
                  Center(
                    child: Text(
                      s.addNewTrip,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: s.tripTitle,
                      border: const OutlineInputBorder(),
                    ),
                    validator: (value) =>
                    value == null || value.trim().isEmpty ? s.enterTripTitle : null,
                    onSaved: (value) => _newTitle = value,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          _newDate == null
                              ? s.noDateSelected
                              : '${s.date}: ${_newDate!.day}/${_newDate!.month}/${_newDate!.year}',
                        ),
                      ),
                      ElevatedButton(
                        onPressed: _pickDate,
                        child: Text(s.pickDate),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${s.numGuests} ${_newGuests.toInt()}'),
                      Slider(
                        value: _newGuests,
                        min: 1,
                        max: 10,
                        divisions: 9,
                        label: _newGuests.toInt().toString(),
                        onChanged: (value) => setState(() => _newGuests = value),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: ElevatedButton(
                      onPressed: _saveTrip,
                      child: Text(s.addTrip),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final selected = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 5),
    );
    if (selected != null) {
      setState(() => _newDate = selected);
    }
  }

  void _saveTrip() async {
    final s = S.of(context);
    if (_formKey.currentState!.validate() && _newDate != null) {
      _formKey.currentState!.save();

      final newTrip = Trip(
        title: _newTitle!,
        imageUrl: _newImageUrl,
        date: '${_newDate!.day}/${_newDate!.month}/${_newDate!.year}',
        description: s.newTripDesc,
        guests: _newGuests.toInt(),
      );

      setState(() => trips.add(newTrip));

      await DBHelper.instance.insertTrip({
        'title': newTrip.title,
        'imageUrl': newTrip.imageUrl,
        'date': newTrip.date,
        'description': newTrip.description,
        'guests': newTrip.guests,
      });

      Provider.of<AppState>(context, listen: false).addToCart(
        CartItem(
          title: newTrip.title,
          subtitle: '${newTrip.date} - ${newTrip.guests} guests',
        ),
      );

      Navigator.pop(context);
    } else if (_newDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(s.pleasePickDate)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(s.tripsTitle),
        actions: [
          DropdownButton<String>(
            value: sortOption,
            onChanged: (value) => setState(() => sortOption = value!),
            items: [
              DropdownMenuItem(value: 'Alphabetical', child: Text(s.sortAZ)),
              DropdownMenuItem(value: 'Date', child: Text(s.sortDate)),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.person),
            tooltip: s.profile,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => const ProfileScreen(),
              ));
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              decoration: InputDecoration(
                labelText: s.searchTrips,
                prefixIcon: const Icon(Icons.search),
                border: const OutlineInputBorder(),
              ),
              onChanged: (value) => setState(() => searchQuery = value),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredTrips.length,
              itemBuilder: (context, index) {
                final trip = filteredTrips[index];
                return Dismissible(
                  key: ValueKey(trip.title),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    setState(() => trips.remove(trip));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${trip.title} ${s.removed}')),
                    );
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  child: TripCard(trip: trip, index: index),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTripModal,
        tooltip: s.addTrip,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TripCard extends StatelessWidget {
  final Trip trip;
  final int index;

  const TripCard({required this.trip, required this.index});

  @override
  Widget build(BuildContext context) {
    return AnimatedTripCard(
      index: index,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                trip.imageUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(trip.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(trip.date, style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 8),
                  Text(trip.description),
                  const SizedBox(height: 8),
                  Text(S.of(context).guestsCount(trip.guests)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AnimatedTripCard extends StatefulWidget {
  final Widget child;
  final int index;

  const AnimatedTripCard({required this.child, required this.index});

  @override
  State<AnimatedTripCard> createState() => _AnimatedTripCardState();
}

class _AnimatedTripCardState extends State<AnimatedTripCard> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
  );

  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(0, 0.1),
    end: Offset.zero,
  ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

  late final Animation<double> _opacityAnimation = Tween<double>(
    begin: 0.0,
    end: 1.0,
  ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: widget.index * 100), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacityAnimation,
      child: SlideTransition(
        position: _offsetAnimation,
        child: widget.child,
      ),
    );
  }
}
