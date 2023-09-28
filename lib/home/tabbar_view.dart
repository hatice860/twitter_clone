import 'package:flutter/material.dart';
import 'package:twitter_clone/home/home_view.dart';
import 'package:twitter_clone/home/search_view.dart';

class TwitterTabbarView extends StatefulWidget {
  const TwitterTabbarView({super.key});

  @override
  State<TwitterTabbarView> createState() => _TwitterTabbarViewState();
}

class _TwitterTabbarViewState extends State<TwitterTabbarView> {
  String _photoUrl =
      "https://listelist.com/wp-content/uploads/2019/02/thispersondoesnotexist.jpg";
  bool isHeaderClose = false;
  ScrollController? scrollController;
  double lastOffset = 0;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController!.addListener(() {
      if (scrollController!.offset <= 0) {
        isHeaderClose = false;
      } else if (scrollController!.offset >=
          scrollController!.position.maxScrollExtent) {
        isHeaderClose = true;
      } else {
        isHeaderClose = scrollController!.offset > lastOffset ? true : false;
      }
      setState(() {
        lastOffset = scrollController!.offset;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        bottomNavigationBar: _bottomAppBar,
        body: Column(
          children: [
            _containerAppbar,
            Expanded(
              child: TabBarView(children: [
                HomeView(scrollController!),
                SearchView(),
                Text("data"),
                Text("data")
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget get _bottomAppBar =>
      BottomAppBar(shape: CircularNotchedRectangle(), child: _tabbarItems);

  Widget get _containerAppbar => AnimatedContainer(
        duration: Duration(milliseconds: 400),
        height: isHeaderClose ? 0 : 60,
        child: _appBar,
      );

  Widget get _appBar => AppBar(
        elevation: 0,
        centerTitle: false,
        title: _appBarItems,
      );

  Widget get _appBarItems => Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 10,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(_photoUrl),
          ),
          Text(
            "Home",
            style: titleTextStyle,
          )
        ],
      );
  Widget get _tabbarItems => TabBar(tabs: [
        Tab(
          icon: Icon(Icons.home),
        ),
        Tab(
          icon: Icon(Icons.abc),
        ),
        Tab(
          icon: Icon(Icons.abc),
        ),
        Tab(
          icon: Icon(Icons.abc),
        )
      ]);
}

final titleTextStyle = TextStyle(
    letterSpacing: 1,
    fontSize: 20,
    fontWeight: FontWeight.w800,
    color: Colors.black);
