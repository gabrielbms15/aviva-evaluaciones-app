import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prevalencias/new_evaluation_page.dart';
import 'package:prevalencias/core/app_colors.dart';
import 'dart:ui';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:async';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool? _isServerOnline;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkServerHealth();
  }

  Future<void> _checkServerHealth() async {
    print('iniciando health check');
    try {
      final supabase = Supabase.instance.client;
      print('cliente obtenido');

      final response = await supabase
          .from('sedes')
          .select()
          .timeout(const Duration(seconds: 10));

      print('Response: $response');
      print('Type: ${response.runtimeType}');

      bool hasExpectedData = false;
      if (response != null && response is List) {
        final names = response.map((e) => e['nombre'].toString()).toSet();
        print('Names: $names');
        if (names.contains('Lima Centro') && names.contains('Los Olivos')) {
          hasExpectedData = true;
        }
      }

      print('hasExpectedData: $hasExpectedData');

      if (mounted) {
        setState(() {
          _isServerOnline = hasExpectedData;
        });
      }
    } on TimeoutException catch (e) {
      print('Timeout: $e');
      if (mounted) setState(() => _isServerOnline = false);
    } catch (e) {
      print('Error: $e');
      if (mounted) setState(() => _isServerOnline = false);
    }
  }

  void _handleCancel() {
    _userController.clear();
    _passwordController.clear();
  }

  Future<void> _handleLogin() async {
    final email = _userController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, ingresa tu correo y contraseña')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await Supabase.instance.client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.session != null) {
        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const NewEvaluationPage()),
          );
        }
      }
    } on AuthException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error de conexión. Inténtalo de nuevo más tarde.'),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _userController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background with turquoise gradient for better glass effect contrast
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.main1.withOpacity(0.15),
                  AppColors.main2.withOpacity(0.1),
                  Colors.white,
                ],
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo
                  Image.asset(
                    'assets/logo.png',
                    height: MediaQuery.of(context).size.height * 0.09,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.health_and_safety,
                        size: MediaQuery.of(context).size.height * 0.1,
                        color: AppColors.main1,
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildServerStatus(),
                  const SizedBox(height: 30),

                  // Login Form with Enhanced Glassmorphism
                  ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 400),
                        padding: const EdgeInsets.all(32.0),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.4),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Usuario',
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: AppColors.main2,
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              controller: _userController,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.person_outline,
                                  size: 20,
                                  color: AppColors.main1,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            Text(
                              'Contraseña',
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: AppColors.main2,
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextField(
                              controller: _passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.lock_outline,
                                  size: 20,
                                  color: AppColors.main1,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                            const SizedBox(height: 40),

                            // Buttons
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: _isLoading ? null : _handleLogin,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.main1,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 18,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 0,
                                ),
                                child: _isLoading
                                    ? const SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                        ),
                                      )
                                    : Text(
                                        'Iniciar Sesión',
                                        style: GoogleFonts.inter(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: double.infinity,
                              child: TextButton(
                                onPressed: _handleCancel,
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                ),
                                child: Text(
                                  'Cancelar',
                                  style: GoogleFonts.inter(
                                    color: AppColors.main2,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServerStatus() {
    Color dotColor = Colors.grey;
    String statusText = 'Verificando servidor...';

    if (_isServerOnline == true) {
      dotColor = Colors.green;
      statusText = 'Servidor Encendido';
    } else if (_isServerOnline == false) {
      dotColor = Colors.red;
      statusText = 'Servidor Apagado';
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: dotColor,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: dotColor.withOpacity(0.5),
                blurRadius: 4,
                spreadRadius: 1,
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Text(
          statusText,
          style: GoogleFonts.inter(
            fontSize: 12,
            color: AppColors.primaryBrown,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
