import 'package:flutter/material.dart';

class AdvicesScreen extends StatelessWidget {
  final String symptom;

  const AdvicesScreen({super.key, required this.symptom});

  // Symptom to condition mapping
  final Map<String, String> _symptomToConditionMap = const {
    'Abdominal pain': 'Mild abdominal pain',
    'Bloating or gas': 'Gas/bloating',
    'Nausea or vomiting': 'Nausea',
    'Diarrhea': 'Mild diarrhea',
    'Constipation': 'Constipation',
    'Acid reflux or heartburn': 'Mild acid reflux',
  };

  // Main advice data
  final List<Map<String, String>> _adviceData = const [
    {
      'condition': 'Mild acid reflux',
      'advice': 'Avoid spicy food, eat small meals',
      'medication': 'Omeprazole, Ranitidine',
    },
    {
      'condition': 'Gas/bloating',
      'advice': 'Avoid carbonated drinks; eat slowly',
      'medication': 'Simethicone (Gas-X)',
    },
    {
      'condition': 'Constipation',
      'advice': 'Increase fiber, water intake',
      'medication': 'Lactulose, Psyllium (Metamucil)',
    },
    {
      'condition': 'Mild diarrhea',
      'advice': 'BRAT diet (Banana, Rice, Apple, Toast)',
      'medication': 'Loperamide (Imodium)',
    },
    {
      'condition': 'Nausea',
      'advice': 'Small meals, rest',
      'medication': 'Domperidone, Ondansetron',
    },
    {
      'condition': 'Mild abdominal pain',
      'advice': 'Warm compress, hydration',
      'medication': 'Antacids or Buscopan',
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Use the map to get the proper condition name
    final mappedCondition = _symptomToConditionMap[symptom] ?? 'Unknown condition';

    // Match the condition with advice data
    final matchedAdvice = _adviceData.firstWhere(
      (item) => item['condition']!.toLowerCase() == mappedCondition.toLowerCase(),
      orElse: () => {
        'condition': 'Unknown condition',
        'advice': 'No specific advice available.',
        'medication': 'Consult a doctor.',
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Advice'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Card(
            elevation: 4,
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    matchedAdvice['condition']!,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildSectionTitle('Advice:'),
                  const SizedBox(height: 8),
                  Text(matchedAdvice['advice']!),
                  const SizedBox(height: 16),
                  _buildSectionTitle('Medication:'),
                  const SizedBox(height: 8),
                  Text(matchedAdvice['medication']!),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.blue,
      ),
    );
  }
}
