import 'package:feed_cat/model/note.dart';
import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final List<Note> notes;

  const ResultPage({
    Key? key,
    required this.notes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.center,
        child: notes.isEmpty
            ? const Text('Table is Empty')
            : Table(
                border: TableBorder.all(),
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: <TableRow>[
                  _headerTable(),
                  ...notes.map(_tableRow).toList(),
                ],
              ),
      ),
    );
  }

  TableRow _headerTable() {
    return TableRow(
      children: <Widget>[
        _ceil('Satiety'),
        _ceil('Date'),
      ],
    );
  }

  TableRow _tableRow(Note note) {
    return TableRow(
      children: <Widget>[
        _ceil('${note.satiety}'),
        _ceil(note.time),
      ],
    );
  }

  Widget _ceil(String data) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(4),
      child: Text(data),
    );
  }
}
