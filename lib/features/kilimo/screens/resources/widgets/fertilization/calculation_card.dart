import 'package:flutter/material.dart';
import '../../../../models/fertilizer/fertilizer_calculation.dart';

class CalculationCard extends StatelessWidget {
  const CalculationCard({
    super.key, 
    required this.calculation
  });

  final FertilizerCalculation calculation;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Crop: ${calculation.cropType}', style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8), // Add spacing
            CalculationRow(
              label: 'MOP', 
              value: calculation.mop, 
              bags: calculation.mopBags
            ),
            CalculationRow(
              label: 'SSP', 
              value: calculation.ssp, 
              bags: calculation.sspBags
            ),
            CalculationRow(
              label: 'Urea', 
              value: calculation.urea, 
              bags: calculation.ureaBags
            ),
          ],
        ),
      ),
    );
  }
}

// Helper Widget for Fertilizer Row
class CalculationRow extends StatelessWidget {
  const CalculationRow({
    super.key, 
    required this.label, 
    required this.value, 
    required this.bags
  });

  final String label;
  final double value;
  final int bags;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('$label: ${value.toStringAsFixed(2)} kg'),
        Text('$bags bag(s)'),
      ],
    );
  }
}
