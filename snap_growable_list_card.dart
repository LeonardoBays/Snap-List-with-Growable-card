import 'package:flutter/material.dart';

main() => runApp(const MaterialApp(home: MyHomePage()));

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> _list = List.generate(99, (i) => 'Numero: $i');

  int _selectedItem = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Snap list with growable card'),
      ),
      body: SizedBox(
        height: 120,
        child: PageView.builder(
          itemCount: _list.length,
          controller: PageController(viewportFraction: 0.90),
          onPageChanged: (int index) => setState(() => _selectedItem = index),
          itemBuilder: (_, i) =>
              GrowableCard(text: _list[i], grow: _selectedItem == i),
        ),
      ),
    );
  }
}

class GrowableCard extends StatelessWidget {
  const GrowableCard({
    Key? key,
    required this.text,
    this.grow = true,
  }) : super(key: key);

  final String text;
  final bool grow;

  BorderRadius get _borderRadius => BorderRadius.circular(12);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(borderRadius: _borderRadius),
        transform:
            grow ? Matrix4.identity() : (Matrix4.identity()..scale(1.0, .90)),
        child: Material(
          color: Colors.white,
          elevation: 4,
          borderRadius: _borderRadius,
          child: InkWell(
            borderRadius: _borderRadius,
            onTap: grow ? () {} : null,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(text),
            ),
          ),
        ),
      ),
    );
  }
}
