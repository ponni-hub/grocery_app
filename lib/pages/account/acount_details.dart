import 'package:flutter/material.dart';

class AcountDetails extends StatelessWidget {
  final String name;
  final String email;

  const AcountDetails({super.key, required this.name, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Details',
            style: TextStyle(
              color: Colors.white,
            )),
        backgroundColor: const Color(0xFF0A1736),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Profile Picture
            Stack(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      const AssetImage('assets/images/male_avatar.png'),
                  backgroundColor: Colors.grey[300],
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.blue,
                    child: IconButton(
                      icon:
                          const Icon(Icons.edit, size: 16, color: Colors.white),
                      onPressed: () {
                        // Handle profile picture edit
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),

            // Name Field
            TextField(
              decoration: InputDecoration(
                labelText: 'Name',
                prefixIcon: const Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              controller: TextEditingController(text: name),
            ),
            const SizedBox(height: 16.0),

            // Email Field
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: const Icon(Icons.email),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              controller: TextEditingController(text: email),
            ),
            const SizedBox(height: 16.0),

            // Password Field
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: const Icon(Icons.lock),
                suffixText: 'Change',
                suffixStyle: const TextStyle(color: Colors.blue),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 30.0),

            // Save Changes Button
            ElevatedButton(
              onPressed: () {
                // Handle save changes
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E4CAF),
                padding: const EdgeInsets.symmetric(
                    horizontal: 32.0, vertical: 12.0),
              ),
              child: const Text('Save Changes',
                  style: TextStyle(
                    color: Colors.white,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
