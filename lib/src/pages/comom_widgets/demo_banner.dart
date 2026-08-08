import 'package:flutter/material.dart';
import 'package:greengrocery/src/config/demo_mode.dart';

/// Shows a warning banner when the app is running in demo mode.
class DemoBanner extends StatelessWidget {
  const DemoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    if (!kDemoMode) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      color: Colors.orange.shade700,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.info_outline, color: Colors.white, size: 16),
          SizedBox(width: 8),
          Text(
            'MODO DEMO — dados simulados, sem conexão com o servidor',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 8),
          Icon(Icons.info_outline, color: Colors.white, size: 16),
        ],
      ),
    );
  }
}
