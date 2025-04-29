import 'package:flutter/material.dart';

class AnimatedCategories extends StatefulWidget {
  final List<dynamic> categories;

  const AnimatedCategories({Key? key, required this.categories})
      : super(key: key);

  @override
  State<AnimatedCategories> createState() => _AnimatedCategoriesState();
}

class _AnimatedCategoriesState extends State<AnimatedCategories>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _animation;

  late List<dynamic> extendedCategories;

  @override
  void initState() {
    super.initState();

    // Ensure there are at least 10 categories by duplicating the list
    extendedCategories = widget.categories;
    if (widget.categories.length < 10) {
      extendedCategories = List.generate(
        10,
        (index) => widget.categories[index % widget.categories.length],
      );
    }

    // Slow down the animation speed
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20), // Slower animation (20 seconds)
    )..repeat(reverse: false);

    _animation = Tween<Offset>(
      begin: const Offset(1.0, 0.0), // Start off-screen to the right
      end: const Offset(-1.0, 0.0), // Move off-screen to the left
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: SlideTransition(
        position: _animation,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: extendedCategories.length,
          itemBuilder: (context, index) {
            final category = extendedCategories[index];
            return GestureDetector(
              onTap: () {
                // Navigate to category-specific products
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(
                        category['image']?['src'] ?? '',
                      ),
                      backgroundColor: Colors.grey[200],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      category['name'] ?? '',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
