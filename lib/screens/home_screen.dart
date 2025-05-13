import 'package:flutter/material.dart';
import '../components/place_card.dart';
import '../models/place.dart';
import '../screens/destination_detail.dart';
import '../screens/enhanced_trips_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/map_screen.dart';
import '../screens/popular_destination_detail.dart';
import '../screens/cart_screen.dart';

class FriendActivity {
  final String friendName;
  final String description;
  final String avatarUrl;

  FriendActivity({
    required this.friendName,
    required this.description,
    required this.avatarUrl,
  });
}

class HomeScreen extends StatefulWidget {
  final VoidCallback onToggleTheme;
  final VoidCallback onChangeColor;

  const HomeScreen({
    Key? key,
    required this.onToggleTheme,
    required this.onChangeColor,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Destination> destinations = [
    Destination(
      name: 'Bali Resort',
      location: 'Bali, Indonesia',
      imageUrl: 'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
      description: 'Enjoy luxury & nature in Bali.',
      rating: 4.8,
    ),
    Destination(
      name: 'Santorini Escape',
      location: 'Santorini, Greece',
      imageUrl: 'https://plus.unsplash.com/premium_photo-1661964149725-fbf14eabd38c?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      description: 'Experience the best sunsets in Santorini.',
      rating: 4.7,
    ),
    Destination(
      name: 'Kyoto Getaway',
      location: 'Kyoto, Japan',
      imageUrl: 'https://images.unsplash.com/photo-1493976040374-85c8e12f0c0e?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      description: 'Discover traditional Japanese culture in Kyoto.',
      rating: 4.6,
    ),
  ];

  final List<Map<String, String>> categories = [
    {
      'title': 'Adventure',
      'imageUrl': 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e',
      'placesCount': '12 destinations'
    },
    {
      'title': 'Culture',
      'imageUrl': 'https://images.unsplash.com/photo-1526778548025-fa2f459cd5c1',
      'placesCount': '18 destinations'
    },
    {
      'title': 'Nature',
      'imageUrl': 'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee',
      'placesCount': '10 destinations'
    },
  ];

  final List<FriendActivity> friendsActivities = [
    FriendActivity(
      friendName: 'Alice',
      description: 'Visited Bali and loved it!',
      avatarUrl: 'https://images.unsplash.com/photo-1544005313-94ddf0286df2',
    ),
    FriendActivity(
      friendName: 'Bob',
      description: 'Checked in at Santorini, amazing views.',
      avatarUrl: 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d',
    ),
    FriendActivity(
      friendName: 'Charlie',
      description: 'Exploring Kyoto temples.',
      avatarUrl: 'https://images.unsplash.com/photo-1568605114967-8130f3a36994',
    ),
  ];

  Widget _buildPopularDestinations() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Popular Destinations',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 250,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: destinations.length,
              itemBuilder: (context, index) {
                final destination = destinations[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: AnimatedDestinationCard(
                    index: index,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PopularDestinationDetailScreen(
                              destination: destination,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        width: 200,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Image.network(
                              destination.imageUrl,
                              height: 135,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            Container(
                              height: 115,
                              padding: const EdgeInsets.all(12),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.surfaceVariant,
                                borderRadius: const BorderRadius.vertical(
                                  bottom: Radius.circular(16),
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    destination.name,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    destination.description,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context).textTheme.bodyMedium?.color,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Rating: ${destination.rating.toStringAsFixed(1)}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context).textTheme.bodyMedium?.color,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Categories',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 140,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return AnimatedCategoryCard(category: categories[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFriendsActivitySection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Friends Activity",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          ListView.separated(
            itemCount: friendsActivities.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) =>
                Divider(color: Colors.grey.withOpacity(0.3)),
            itemBuilder: (context, index) {
              final activity = friendsActivities[index];
              return ListTile(
                leading: CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(activity.avatarUrl),
                ),
                title: Text(
                  activity.friendName,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(activity.description),
                onTap: () {},
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildExplore() {
    return ListView(
      children: [
        _buildPopularDestinations(),
        _buildCategoriesSection(),
        _buildFriendsActivitySection(),
      ],
    );
  }

  late final List<Widget> _pages = [
    _buildExplore(),
    const EnhancedTripsScreen(),
    const ProfileScreen(),
    const MapScreen(),
    const CartScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.nightlight_round),
            onPressed: widget.onToggleTheme,
          ),
          IconButton(
            icon: const Icon(Icons.color_lens_outlined),
            onPressed: widget.onChangeColor,
          ),
          IconButton(
            icon: Icon(Icons.flight_takeoff),
            tooltip: 'Go to Trips',
            onPressed: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 500),
                  pageBuilder: (_, __, ___) => const EnhancedTripsScreen(),
                  transitionsBuilder: (_, animation, __, child) {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: Offset(1.0, 0.0),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    );
                  },
                ),
              );
            },
          ),

        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: "Explore",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: "Trips",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: "Map",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Cart",
          ),
        ],
      ),
    );
  }
}

class AnimatedDestinationCard extends StatefulWidget {
  final Widget child;
  final int index;
  const AnimatedDestinationCard({required this.child, required this.index});

  @override
  State<AnimatedDestinationCard> createState() => _AnimatedDestinationCardState();
}

class _AnimatedDestinationCardState extends State<AnimatedDestinationCard> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
  );

  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(0.2, 0),
    end: Offset.zero,
  ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

  late final Animation<double> _opacityAnimation = Tween<double>(
    begin: 0.0,
    end: 1.0,
  ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: widget.index * 150), () {
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

class AnimatedCategoryCard extends StatefulWidget {
  final Map<String, String> category;
  const AnimatedCategoryCard({required this.category});

  @override
  State<AnimatedCategoryCard> createState() => _AnimatedCategoryCardState();
}

class _AnimatedCategoryCardState extends State<AnimatedCategoryCard> {
  double _scale = 1.0;

  void _onTapDown(_) => setState(() => _scale = 0.95);
  void _onTapUp(_) => setState(() => _scale = 1.0);

  @override
  Widget build(BuildContext context) {
    final cat = widget.category;

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: () => setState(() => _scale = 1.0),
      onTap: () {},
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 150),
        child: Container(
          width: 140,
          margin: const EdgeInsets.only(right: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              image: NetworkImage(cat['imageUrl']!),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.25),
                BlendMode.darken,
              ),
            ),
          ),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cat['title']!,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    cat['placesCount']!,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
