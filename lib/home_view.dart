import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String _photoUrl =
      "https://listelist.com/wp-content/uploads/2019/02/thispersondoesnotexist.jpg";
  int defaultTabLength = 4;
  String _randomImage = "https://picsum.photos/200/300";
  String dummyTweet =
      "Hiçbir günün diğeriyle aynı olmasına izin vermemelisiniz. Bu her zaman hayatın farklı bir dinamiğini görmek ve kendinizi hazırlamak konusunda sizi destekleyecektir. Sosyal çevrenize bakış açınız yeni tecrübeler edinmenizi sağlayabilir.";
  bool isHeaderClose = false;
  double lastOffset = 0;

  ScrollController? scrollController;

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
    scrollController!.dispose();  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _fabButton,
      body: SafeArea(
        child: DefaultTabController(
          length: defaultTabLength,
          child: Column(
            children: [_containerAppbar, _tabbarItems, _expandedListView],
          ),
        ),
      ),
    );
  }

  Widget get _fabButton => FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      );

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
  Widget get _expandedListView => Expanded(child: _listView);

  Widget get _listView => ListView.builder(
      itemCount: 10,
      controller: scrollController,
      itemBuilder: ((context, index) {
        return _listViewCard;
      }));

  Widget get _listViewCard => Card(
        child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(_randomImage),
            ),
            title: Wrap(
              runSpacing: 10,
              children: [
                _listCardTitle("text"),
                Text(
                  dummyTweet,
                ),
                _placeHolderField,
                _footerButtonList
              ],
            )),
      );

  Widget _listCardTitle(String text) => Text(
        text,
        style: titleTextStyle,
      );

  Widget get _placeHolderField => Container(
        height: 100,
        child: Placeholder(),
      );

  Widget get _footerButtonList => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _iconLabelButton,
          _iconLabelButton,
          _iconLabelButton,
          _iconLabelButton,
        ],
      );

  Widget _iconLabel(String text) => Wrap(
        spacing: 5,
        children: [
          Icon(
            Icons.comment,
            color: CupertinoColors.inactiveGray,
          ),
          Text(text)
        ],
      );

  Widget get _iconLabelButton => InkWell(
        child: _iconLabel("1"),
        onTap: () {},
      );
}

final titleTextStyle = TextStyle(
    letterSpacing: 1,
    fontSize: 20,
    fontWeight: FontWeight.w800,
    color: Colors.black);
