import 'package:feed_cat/model/note.dart';
import 'package:feed_cat/page/result_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

class CatPage extends StatefulWidget {
  const CatPage({Key? key}) : super(key: key);

  @override
  _CatPageState createState() => _CatPageState();
}

class _CatPageState extends State<CatPage> with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final List<Note> _notes;
  late Animation<double> _animation;

  int _satiety = 0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 700,
      ),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      }
    });

    _updateScale(1);

    _notes = <Note>[];
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updateScale(double scale) =>
      _animation = Tween<double>(begin: 1, end: scale).animate(_controller);

  void _updateSatiety() {
    setState(() {
      _satiety += 1;
      if (_satiety % 15 == 0) {
        _updateScale(2);
        _controller.forward(from: 0);
        _notes.add(
          Note(
            satiety: _satiety,
            time: DateFormat.Hms().format(DateTime.now()),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _satietyLabel(),
            _catPicture(),
            _feedButton(),
          ],
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: Colors.deepOrangeAccent,
      elevation: 0,
      title: const Text('FeedTheCat'),
      actions: [
        IconButton(
          onPressed: () => Share.share('Satiety of your cat $_satiety'),
          icon: const Icon(Icons.share),
        ),
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ResultPage(notes: _notes),
              ),
            );
          },
          icon: const Icon(Icons.notes),
        ),
        IconButton(
          onPressed: _developDialog,
          icon: const Icon(Icons.info),
        ),
      ],
    );
  }

  Widget _satietyLabel() {
    return Container(
      padding: const EdgeInsets.only(right: 32, top: 12),
      alignment: Alignment.topRight,
      child: Text(
        'Satiety   $_satiety',
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _catPicture() {
    return AnimatedBuilder(
      animation: _animation,
      child: const Image(
        height: 150,
        width: 150,
        image: AssetImage('asset/image/cat.png'),
      ),
      builder: (context, child) => Transform.scale(
        scale: _animation.value,
        child: child,
      ),
    );
  }

  Widget _feedButton() {
    return GestureDetector(
      onTap: _updateSatiety,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.red[800],
          borderRadius: BorderRadius.circular(4),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 2.0,
              spreadRadius: 0.0,
              offset: Offset(2.0, 2.0),
            )
          ],
        ),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: const Text(
          'FEED',
          style: TextStyle(
            fontSize: 14,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void _developDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const SimpleDialog(
          title: Text('About the developer'),
          children: <Widget>[
            SimpleDialogOption(
              child: Text('Group number: 951008'),
            ),
            SimpleDialogOption(
              child: Text('Student\'s last name: Mihalkov'),
            ),
            SimpleDialogOption(
              child: Text('Laboratory work number: 1'),
            ),
          ],
        );
      },
    );
  }
}
