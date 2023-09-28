import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView(this.controller, {super.key});
  final ScrollController controller;
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int defaultTabLength = 4;
  String _randomImage = "https://picsum.photos/200/300";
  String dummyTweet =
      "Hiçbir günün diğeriyle aynı olmasına izin vermemelisiniz. Bu her zaman hayatın farklı bir dinamiğini görmek ve kendinizi hazırlamak konusunda sizi destekleyecektir. Sosyal çevrenize bakış açınız yeni tecrübeler edinmenizi sağlayabilir.";
  bool isHeaderClose = false;
  double lastOffset = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: _fabButton,
        body: _listView);
  }

  Widget get _expandedListView => Expanded(child: _listView);

  Widget get _listView => ListView.builder(
      itemCount: 10,
      controller: widget.controller,
      itemBuilder: ((context, index) {
        return _listViewCard;
      }));
       Widget get _fabButton => FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      );

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
