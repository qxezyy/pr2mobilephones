import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Screen(),
    );
  }
}

class Screen extends StatefulWidget {
  const Screen({super.key});

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _notes = [];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _addNote() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _notes.add(text);
    });
    _controller.clear();
  }
  void _deleteNote(int index) {
    setState(() {
      _notes.removeAt(index);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('заметкке'),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'введите то, что хотели бы сохранитб',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addNote,
              child: Text('сохранить')),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _notes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: TextFormField(
                      initialValue: _notes[index],
                      onChanged: (value) {
                        _notes[index] = value;
                      },
                    ),
                    trailing: IconButton(
                      onPressed: () => _deleteNote(index),
                      icon: const Icon(Icons.delete),
                    ),
                  );
                }
              ),
            )  
          ],
        ),

        ),
    );
  }
}