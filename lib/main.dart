import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Study Cards App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const StudyCardsScreen(),
    );
  }
}

class StudyCardsScreen extends StatefulWidget {
  const StudyCardsScreen({Key? key}) : super(key: key);

  @override
  _StudyCardsScreenState createState() => _StudyCardsScreenState();
}

class _StudyCardsScreenState extends State<StudyCardsScreen> {
  final List<Map<String, String>> _cards = [
    {'front': 'Flutter', 'back': 'A UI toolkit for building natively compiled applications'},
    {'front': 'Dart', 'back': 'The programming language used for Flutter development'},
    {'front': 'Widget', 'back': 'The basic building block of Flutter UI'},
  ];

  int _currentIndex = 0;

  void _nextCard() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % _cards.length;
    });
  }

  void _previousCard() {
    setState(() {
      _currentIndex = (_currentIndex - 1 + _cards.length) % _cards.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Study Cards'),
      ),
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity! > 0) {
            _previousCard();
          } else if (details.primaryVelocity! < 0) {
            _nextCard();
          }
        },
        child: Center(
          child: FlipCard(
            front: _buildCardSide(_cards[_currentIndex]['front']!),
            back: _buildCardSide(_cards[_currentIndex]['back']!),
          ),
        ),
      ),
    );
  }

  Widget _buildCardSide(String content) {
    return Container(
      width: 300,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            content,
            style: const TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}