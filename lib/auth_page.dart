import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:p3l/home_page.dart';
import 'package:p3l/pageKurir.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final PageController _pageController = PageController();
  final GlobalKey<FormState> _signInFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _signUpFormKey = GlobalKey<FormState>();

  // Login controllers
  final TextEditingController _loginEmailController = TextEditingController();
  final TextEditingController _loginPasswordController =
      TextEditingController();

  // Register controllers
  final TextEditingController _registerNameController = TextEditingController();
  final TextEditingController _registerEmailController =
      TextEditingController();
  final TextEditingController _registerPhoneController =
      TextEditingController();
  final TextEditingController _registerAddressController =
      TextEditingController();
  final TextEditingController _registerPasswordController =
      TextEditingController();
  final TextEditingController _registerConfirmPasswordController =
      TextEditingController();
  String? _selectedRole; // For Dropdown
  bool _isLoading = false;

  // Error messages
  String? _signInErrorMessage;
  String? _signUpErrorMessage;

  @override
  void dispose() {
    _pageController.dispose();
    _loginEmailController.dispose();
    _loginPasswordController.dispose();
    _registerNameController.dispose();
    _registerEmailController.dispose();
    _registerPhoneController.dispose();
    _registerAddressController.dispose();
    _registerPasswordController.dispose();
    _registerConfirmPasswordController.dispose();
    super.dispose();
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  Future<void> _handleLogin() async {
    if (!_signInFormKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
      _signInErrorMessage = null;
    });

    final String email = _loginEmailController.text;
    final String password = _loginPasswordController.text;

    try {
      // NOTE: Replace with your actual Laravel login API endpoint
      final response = await http.post(
        Uri.parse(
            'http://127.0.0.1:8000/api/login'), // For Android emulator, use 10.0.2.2. For iOS/physical device, use your machine's IP.
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          // You might need to retrieve CSRF token from a previous request or a meta tag
          // For Flutter, if your Laravel API uses Sanction/Passport/JWT, CSRF token might not be strictly needed for API calls.
          // If you really need CSRF, you'd fetch it first. For typical APIs, it's often handled via tokens.
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );

      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (responseData['success'] == true) {
          // Login successful
          print('Login successful: ${responseData['message']}');
          final String? token = responseData['data']['token'];
          final Map<String, dynamic>? user = responseData['data']['user'];
          final String? role = responseData['data']['role'];
          final String? userId = user?['ID_PEMBELI'] as String?;

          _showErrorSnackBar('Login berhasil! Selamat datang.');

          if (token != null && userId != null) {
            final SharedPreferences prefs =
                await SharedPreferences.getInstance();
            await prefs.setString('authToken', token); // Simpan token
            await prefs.setString(
                'currentUserId', userId); // Simpan ID pengguna

            print('✅ Token disimpan: $token');
            print('✅ ID Pengguna disimpan: $userId');
          } else {
            // Jika token atau ID pengguna tidak ada dalam respons, cetak peringatan
            print(
                '⚠️ Peringatan: Token atau ID Pengguna tidak ditemukan dalam respons login.');
            setState(() {
              _signInErrorMessage =
                  'Login berhasil, tapi data sesi tidak lengkap.';
            });
            _showErrorSnackBar(_signInErrorMessage!);
            _isLoading = false; // Pastikan loading dimatikan
            return; // Hentikan proses navigasi jika data tidak lengkap
          }

          if (role == 'pembeli' || role == 'penitip') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      const HomePage()), // Navigasi ke HomePage untuk pembeli
            );
            } else if (role == 'kurir') {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const PageKurir()), // Navigasi ke HomePage untuk pembeli
              );
          } else {
            // TODO: Handle navigation for other roles (e.g., organisasi, admin)
            // For now, if role is not 'pembeli', just show success message
            print(
                'Login successful for role: $role. Implement navigation for this role.');
          }
        } else {
          // Login failed based on backend logic
          setState(() {
            _signInErrorMessage = responseData['message'] ??
                'Login failed. Please check your credentials.';
          });
          _showErrorSnackBar(_signInErrorMessage!);
        }
      } else {
        // Handle HTTP error (e.g., 401 Unauthorized, 400 Bad Request)
        setState(() {
          _signInErrorMessage = responseData['message'] ??
              'Login failed. Status: ${response.statusCode}';
          if (responseData['errors'] != null) {
            // Flatten validation errors
            _signInErrorMessage =
                (responseData['errors'] as Map<String, dynamic>)
                    .values
                    .expand((e) => e)
                    .join('\n');
          }
        });
        _showErrorSnackBar(_signInErrorMessage!);
      }
    } catch (e) {
      print('Error during login: $e');
      setState(() {
        _signInErrorMessage = 'An error occurred. Please try again later.';
      });
      _showErrorSnackBar(_signInErrorMessage!);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _handleRegister() async {
    if (!_signUpFormKey.currentState!.validate()) {
      return;
    }

    if (_registerPasswordController.text !=
        _registerConfirmPasswordController.text) {
      setState(() {
        _signUpErrorMessage = 'Password and Confirm Password do not match.';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _signUpErrorMessage = null;
    });

    String apiUrl;
    Map<String, String> requestBody = {};

    // NOTE: Replace with your actual Laravel registration API endpoints
    if (_selectedRole == 'pembeli') {
      apiUrl = 'http://127.0.0.1:8000/api/pembeli/register'; // Example
      requestBody = {
        'NAMA_PEMBELI': _registerNameController.text,
        'EMAIL_PEMBELI': _registerEmailController.text,
        'PASSWORD_PEMBELI': _registerPasswordController.text,
        'PASSWORD_PEMBELI_CONFIRMATION':
            _registerConfirmPasswordController.text,
        'NO_PEMBELI': _registerPhoneController.text,
        'ALAMAT_PEMBELI': _registerAddressController.text,
        'POIN_PEMBELI': '0', // Default value
      };
    } else if (_selectedRole == 'organisasi') {
      apiUrl = 'http://127.0.0.1:8000/api/organisasi/register'; // Example
      requestBody = {
        'NAMA_ORGANISASI': _registerNameController
            .text, // Assuming 'Nama Lengkap' is org name here
        'EMAIL_ORGANISASI': _registerEmailController.text,
        'PASSWORD_ORGANISASI': _registerPasswordController.text,
        'PASSWORD_ORGANISASI_CONFIRMATION':
            _registerConfirmPasswordController.text,
        'NOTELP_ORGANISASI': _registerPhoneController.text,
        'ALAMAT_ORGANISASI': _registerAddressController.text,
        'SALDO_ORGANISASI': '0', // Default value
      };
    } else {
      setState(() {
        _signUpErrorMessage = 'Please select a role.';
      });
      _showErrorSnackBar(_signUpErrorMessage!);
      setState(() {
        _isLoading = false;
      });
      return;
    }

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (response.statusCode == 201 ||
          (response.statusCode == 200 && responseData['success'] != false)) {
        // Registration successful (201 Created is ideal for successful creation)
        print('Registration successful: ${responseData['message']}');
        _showErrorSnackBar('Registrasi berhasil! Silakan login.');
        // Switch back to login page
        _pageController.animateToPage(
          0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      } else {
        // Registration failed
        setState(() {
          _signUpErrorMessage = responseData['message'] ??
              'Registration failed. Status: ${response.statusCode}';
          if (responseData['errors'] != null) {
            _signUpErrorMessage =
                (responseData['errors'] as Map<String, dynamic>)
                    .values
                    .expand((e) => e)
                    .join('\n');
          }
        });
        _showErrorSnackBar(_signUpErrorMessage!);
      }
    } catch (e) {
      print('Error during registration: $e');
      setState(() {
        _signUpErrorMessage = 'An error occurred. Please try again later.';
      });
      _showErrorSnackBar(_signUpErrorMessage!);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background panels or animation like your web version
          // This simplified version focuses on the forms
          PageView(
            controller: _pageController,
            physics:
                const NeverScrollableScrollPhysics(), // Disable direct swiping
            children: [
              _buildSignInForm(),
              _buildSignUpForm(),
            ],
          ),
          if (_isLoading)
            const Opacity(
              opacity: 0.8,
              child: ModalBarrier(dismissible: false, color: Colors.black),
            ),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),
        ],
      ),
    );
  }

  Widget _buildSignInForm() {
    return Container(
      color: Colors.white, // Background color for sign-in page
      padding: const EdgeInsets.all(24.0),
      child: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _signInFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Sign in',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                if (_signInErrorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: Text(
                      _signInErrorMessage!,
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  ),
                const SizedBox(height: 20),
                _buildInputField(
                  controller: _loginEmailController,
                  hintText: 'Email',
                  icon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Enter a valid email address';
                    }
                    return null;
                  },
                ),
                _buildInputField(
                  controller: _loginPasswordController,
                  hintText: 'Password',
                  icon: Icons.lock,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _isLoading ? null : _handleLogin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    minimumSize: const Size(150, 50),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                              color: Colors.white, strokeWidth: 3),
                        )
                      : const Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: _isLoading
                      ? null
                      : () {
                          _pageController.animateToPage(
                            1,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        },
                  child: const Text(
                    "Don't have an account? Sign up",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
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

  Widget _buildSignUpForm() {
    return Container(
      color: Colors.white, // Background color for sign-up page
      padding: const EdgeInsets.all(24.0),
      child: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _signUpFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Sign up',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                if (_signUpErrorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: Text(
                      _signUpErrorMessage!,
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  ),
                const SizedBox(height: 20),
                _buildInputField(
                  controller: _registerNameController,
                  hintText: 'Nama Lengkap / Nama Organisasi',
                  icon: Icons.person,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name or organization name';
                    }
                    return null;
                  },
                ),
                _buildInputField(
                  controller: _registerEmailController,
                  hintText: 'Email',
                  icon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Enter a valid email address';
                    }
                    return null;
                  },
                ),
                _buildRoleDropdown(),
                _buildInputField(
                  controller: _registerPhoneController,
                  hintText: 'Nomor Telepon',
                  icon: Icons.phone,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                ),
                _buildInputField(
                  controller: _registerAddressController,
                  hintText: 'Alamat',
                  icon: Icons.location_on,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your address';
                    }
                    return null;
                  },
                ),
                _buildInputField(
                  controller: _registerPasswordController,
                  hintText: 'Password',
                  icon: Icons.lock,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
                ),
                _buildInputField(
                  controller: _registerConfirmPasswordController,
                  hintText: 'Confirm Password',
                  icon: Icons.lock_reset,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != _registerPasswordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _isLoading ? null : _handleRegister,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    minimumSize: const Size(150, 50),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                              color: Colors.white, strokeWidth: 3),
                        )
                      : const Text(
                          'Sign Up',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: _isLoading
                      ? null
                      : () {
                          _pageController.animateToPage(
                            0,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        },
                  child: const Text(
                    "Already have an account? Sign in",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
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

  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          icon: Icon(icon, color: Colors.grey[700]),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[700]),
          border: InputBorder.none,
        ),
        validator: validator,
      ),
    );
  }

  Widget _buildRoleDropdown() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: Colors.black, width: 2),
      ),
      child: DropdownButtonFormField<String>(
        value: _selectedRole,
        decoration: InputDecoration(
          icon: Icon(Icons.person_pin_outlined, color: Colors.grey[700]),
          hintText: 'Pilih Role',
          hintStyle: TextStyle(color: Colors.grey[700]),
          border: InputBorder.none,
        ),
        items: const [
          DropdownMenuItem(value: 'pembeli', child: Text('Pembeli')),
          DropdownMenuItem(value: 'organisasi', child: Text('Organisasi')),
        ],
        onChanged: (String? newValue) {
          setState(() {
            _selectedRole = newValue;
          });
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select a role';
          }
          return null;
        },
      ),
    );
  }
}
