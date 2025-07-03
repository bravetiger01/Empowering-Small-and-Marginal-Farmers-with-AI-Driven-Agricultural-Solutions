import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:solutionchallenge/models/language_model.dart';
import '../../main.dart';
import 'package:firebase_auth/firebase_auth.dart';


class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {

  final Map<String, dynamic> _profileData = {
    'name': 'Farmer John',
    'email': 'farmer.john@example.com',
    'phone': '+91 9876543210',
    'location': 'Balamrampur, India',
    'farmSize': '5 acres',
  };

  final AuthService _authService = AuthService();

  

  // Settings
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;

  // Edit profile controllers
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _locationController;


  @override
  void initState() {
    super.initState();
    final User? user = _authService.getCurrentUser();
    _nameController = TextEditingController(text: user?.displayName ?? 'Not set');
    _emailController = TextEditingController(text: user?.email ?? 'Not set');
    _phoneController = TextEditingController(text: '+91 9876543210'); // Static or fetch from elsewhere
    _locationController = TextEditingController(text: 'Balamrampur, India');
    
  }

  // Create light theme
  final ThemeData _lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.green,
    scaffoldBackgroundColor: Color.fromARGB(255, 99, 194, 104),
    appBarTheme: AppBarTheme(
      backgroundColor: Color.fromARGB(255, 99, 194, 104),
      foregroundColor: Colors.white,
    ),
    cardTheme: CardThemeData(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
  );

  // Create dark theme
  final ThemeData _darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.green,
    scaffoldBackgroundColor: Colors.grey[900],
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.green.shade900,
      foregroundColor: Colors.white,
    ),
    cardTheme: CardThemeData(
      elevation: 4,
      color: Colors.grey[850],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white70),
    ),
    iconTheme: IconThemeData(
      color: Colors.green.shade300,
    ),
  );

  void _showEditProfileBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          top: 20,
          left: 20,
          right: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Edit Profile',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _locationController,
              decoration: const InputDecoration(
                labelText: 'Location',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Save profile changes
                setState(() {
                  _profileData['name'] = _nameController.text;
                  _profileData['email'] = _emailController.text;
                  _profileData['phone'] = _phoneController.text;
                  _profileData['location'] = _locationController.text;
                });
                Navigator.pop(context);
              },
              child: const Text('Save Changes'),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _showChangePasswordBottomSheet() {
    final TextEditingController currentPasswordController = TextEditingController();
    final TextEditingController newPasswordController = TextEditingController();
    final TextEditingController confirmPasswordController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          top: 20,
          left: 20,
          right: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Change Password',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: currentPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Current Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: newPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'New Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: confirmPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Confirm New Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Validate and change password logic would go here
                if (newPasswordController.text == confirmPasswordController.text) {
                  // Implement password change logic
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Password changed successfully')),
                  );
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Passwords do not match')),
                  );
                }
              },
              child: const Text('Change Password'),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Determine the current theme brightness
    bool isDarkMode = _darkModeEnabled;
    final User? user = _authService.currentUser;
    final languageProvider = Provider.of<LanguageProvider>(context);

    return MaterialApp(
      theme: _lightTheme,
      darkTheme: _darkTheme,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage('/api/placeholder/400/320'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                isDarkMode ? Colors.black54 : Colors.transparent,
                BlendMode.darken,
              ),
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Text(
                  'Profile & Settings',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: isDarkMode ? Colors.grey[850] : Colors.white,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: ListView(
                      padding: const EdgeInsets.all(16),
                      children: [
                        // Profile Overview
                        Card(
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.green,
                              child: Icon(Icons.person)
                            ),
                            title: Text(
                              user?.displayName ?? 'Not set',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(user?.email ?? 'Not set'),
                            trailing: IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: _showEditProfileBottomSheet,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Settings Section
                        Text(
                          'Settings',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Change Password
                        Card(
                          child: ListTile(
                            leading: const Icon(Icons.lock_outline),
                            title: const Text('Change Password'),
                            trailing: const Icon(Icons.chevron_right),
                            onTap: _showChangePasswordBottomSheet,
                          ),
                        ),

                        // Notifications Toggle
                        Card(
                          child: SwitchListTile(
                            secondary: const Icon(Icons.notifications_outlined),
                            title: const Text('Notifications'),
                            subtitle: const Text('Receive app updates and alerts'),
                            value: _notificationsEnabled,
                            onChanged: (bool value) {
                              setState(() {
                                _notificationsEnabled = value;
                              });
                            },
                          ),
                        ),

                        // Theme Mode Toggle
                        Card(
                          child: SwitchListTile(
                            secondary: const Icon(Icons.dark_mode_outlined),
                            title: const Text('Dark Mode'),
                            subtitle: const Text('Switch between light and dark themes'),
                            value: _darkModeEnabled,
                            onChanged: (bool value) {
                              setState(() {
                                _darkModeEnabled = value;
                              });
                            },
                          ),
                        ),

                        // In your profile.dart file, replace the existing language selection with this:

// Language Selection
                        Card(
                          child: ListTile(
                            leading: const Icon(Icons.language),
                            title: const Text('Language'),
                            subtitle: Text(languageProvider.currentLanguage.name),
                            trailing: const Icon(Icons.chevron_right),
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) => Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Select Language',
                                        style: Theme.of(context).textTheme.headlineSmall,
                                      ),
                                      const SizedBox(height: 16),
                                      Expanded(
                                        child: ListView.builder(
                                          itemCount: languageProvider.availableLanguages.length,
                                          itemBuilder: (context, index) {
                                            final language = languageProvider.availableLanguages[index];
                                            final isSelected = language.code == languageProvider.currentLanguage.code;

                                            return Card(
                                              color: isSelected ? Colors.green.shade50 : null,
                                              child: ListTile(
                                                title: Text(language.name),
                                                subtitle: Text(language.nativeName),
                                                trailing: isSelected
                                                    ? const Icon(Icons.check_circle, color: Colors.green)
                                                    : null,
                                                onTap: () {
                                                  languageProvider.setLanguage(language);
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        // Logout Button
                        const SizedBox(height: 20),
                        ElevatedButton.icon(
                          icon: const Icon(Icons.logout),
                          label: const Text('Logout'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Logout'),
                                content: const Text('Are you sure you want to logout?'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Cancel'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const LoginScreen(),
                                        ),
                                      );
                                    },
                                    child: const Text('Logout'),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}