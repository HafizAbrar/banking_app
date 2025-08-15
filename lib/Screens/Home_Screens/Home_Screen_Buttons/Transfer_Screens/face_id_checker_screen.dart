import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class FaceScanScreen extends StatefulWidget {
  const FaceScanScreen({super.key});

  @override
  State<FaceScanScreen> createState() => _FaceScanScreenState();
}

class _FaceScanScreenState extends State<FaceScanScreen> {
  final LocalAuthentication auth = LocalAuthentication();
  bool isAuthenticating = false;

  Future<void> _authenticateWithFace() async {
    try {
      final available = await auth.getAvailableBiometrics();
      if (!available.contains(BiometricType.face)) {
        _showMessage("Face authentication is not supported on this device.");
        return;
      }

      setState(() => isAuthenticating = true);
      final authenticated = await auth.authenticate(
        localizedReason: "Please authenticate using Face ID",
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );
      setState(() => isAuthenticating = false);

      if (authenticated) {
        _showMessage("Authentication successful!");
      } else {
        _showMessage("Authentication failed. Please try again.");
      }
    } catch (e) {
      setState(() => isAuthenticating = false);
      _showMessage("Error during face authentication: $e");
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Face Scan Only"),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton.icon(
          icon: const Icon(Icons.face, size: 28),
          label: Text(
            isAuthenticating ? "Scanning..." : "Scan Face",
            style: const TextStyle(fontSize: 18),
          ),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          ),
          onPressed: isAuthenticating ? null : _authenticateWithFace,
        ),
      ),
    );
  }
}
