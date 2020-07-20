import 'package:flutter/material.dart';
import 'package:union_tabs/union_tabs.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Nest tabs Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  final List<String> tabsText = ['一', '二', '三'];
  final List<String> secondTabsText = ['one', 'two', 'three'];
  TabController _controller;
  TabController _childController;

  @override
  void initState() {
    super.initState();
    _controller = TabController(
      length: tabsText.length,
      vsync: this,
      initialIndex: tabsText.length - 1,
    );
    _childController = TabController(
      length: secondTabsText.length,
      vsync: this,
      initialIndex: secondTabsText.length - 1,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _childController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        bottom: TabBar(
          labelColor: Colors.red,
          unselectedLabelColor: Colors.black,
          controller: _controller,
          tabs: tabsText.map((d) => Tab(text: d)).toList(),
        ),
      ),
      body: UnionOuterTabBarView(
        controller: _controller,
        children: <Widget>[
          Center(child: Text(tabsText[0])),
          Center(child: Text(tabsText[1])),
          Column(
            children: <Widget>[
              TabBar(
                labelColor: Colors.red,
                unselectedLabelColor: Colors.black,
                controller: _childController,
                tabs: secondTabsText.map((it) => Tab(text: it)).toList(),
              ),
              Expanded(
                child: UnionInnerTabBarView(
                  controller: _childController,
                  children: secondTabsText
                      .map((d) => Center(child: Text(d)))
                      .toList(),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
