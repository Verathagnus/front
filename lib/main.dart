import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/painting/box_decoration.dart';
import 'package:flutter/src/painting/border_radius.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const activeCardColour = Color(0xFF1D1E33);
const bottomContainerColour = Color(0xFFEB1555);

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drawer and Navigation',

      //   darkTheme: ThemeData.dark(),
      //   theme: ThemeData(
      //     primarySwatch: Colors.red,
      //     accentColor: Colors.red,
      //   ),
      theme: ThemeData.dark().copyWith(
        accentColor: Colors.red,
        primaryColor: Colors.red,
        scaffoldBackgroundColor: Color(0xFF0A0B21),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final List<Page> _pages = [
    Page('Photos', Icons.camera_alt_outlined),
    Page('News', Icons.home_outlined),
    Page('Videos', Icons.play_circle_outline),
  ];

  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentPageIndex = 1;

  void _openPage(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> drawerItemWidgets = widget._pages
        .asMap()
        .map((int index, Page page) => MapEntry<int, Widget>(
            index,
            ListTile(
              title: Text(page.title),
              leading: Icon(page.iconData),
              selected: _currentPageIndex == index,
              onTap: () {
                _openPage(index);
                Navigator.pop(context);
              },
            )))
        .values
        .toList();
    // drawerItemWidgets.insert(0, DrawerHeader(
    //   child: Text('Menu'),
    // //   decoration: BoxDecoration(
    // //     color: Colors.red,
    // //   ),
    // ),);
    return Scaffold(
      appBar: AppBar(
        title: Text("NewsAppName"),
      ),
      body: Column(
        children: <Widget>[

            ReusableCard(colour: activeCardColour, height: 300.0, width: double.infinity, 
            image: 'images/1.png'),

        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: drawerItemWidgets,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPageIndex,
        items: widget._pages
            .map((Page page) => BottomNavigationBarItem(
                  icon: Icon(page.iconData),
                  title: Text(page.title),
                ))
            .toList(),
        onTap: _openPage,
      ),
    );
  }
}

class Page {
  final String title;
  final IconData iconData;
  Page(this.title, this.iconData);
}

class ReusableCard extends StatelessWidget {
  ReusableCard({@required this.colour, this.cardChild, this.height, this.width, this.image});
  final Color colour;
  final Widget cardChild;
  final double height;
  final double width;
  final Image image;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: cardChild,
      height: height,
      width: width,
      margin: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: colour,
        borderRadius: BorderRadius.circular(10.0),
        image: DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.fill,
                ),
      ),
    );
  }
}



class NewsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
  length: 3,
  child: Scaffold(
    appBar: AppBar(
      bottom: TabBar(
        tabs: [
          Tab(text: 'TOP NEWS'),
          Tab(text: 'CORONA VIRUS'),
          Tab(text: 'LATEST NEWS'),
          Tab(text: 'INDIA'),
          Tab(text: 'WORLD'),
        ],
      ),
    ),
  ),
);
  }
}