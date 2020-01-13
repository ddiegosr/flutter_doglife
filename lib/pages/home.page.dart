import 'package:doglife/pages/controller.dart';
import 'package:doglife/pages/post.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final Controller controller = Controller();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
          child: SizedBox(
            width: 100,
            child: Image.asset("assets/app-logo.png"),
          ),
        ),
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/user-picture.png"),
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
        actions: <Widget>[
          Container(
            width: 60,
            child: FlatButton(
              child: Icon(
                Icons.search,
                color: Color(0xFFBABABA),
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: Container(
        color: Color(0xFFF2F3F6),
        child: StreamBuilder(
          stream: widget.controller.output,
          builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
            if (!snapshot.hasData) {
              return Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: Text(
                      'Nenhum dado a ser mostrado, clique abaixo para popular a lista.',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  RaisedButton(
                    child: Text('Popular'),
                    color: Color(0xFFF58624),
                    textColor: Colors.white,
                    onPressed: widget.controller.populate,
                  ),
                ],
              );
            }
            return ListView(
              children: snapshot.data
                  .map((item) => cardItem(item, widget.controller.like))
                  .toList(),
            );
          },
        ),
      ),
    );
  }
}

Widget cardItem(Post post, Function onLike) {
  return Card(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(
              "https://user-images.githubusercontent.com/11250/39013954-f5091c3a-43e6-11e8-9cac-37cf8e8c8e4e.jpg",
            ),
          ),
          title: Text('Bruce Wayne'),
          subtitle: Text('09/05/2019 18:37'),
          trailing: Icon(Icons.more_vert),
        ),
        Container(
          child: Image.asset(
            "assets/post-picture-001.png",
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: Text(post.text),
        ),
        ButtonBar(
          children: <Widget>[
            FlatButton(
              child: Icon(post.liked ? Icons.favorite : Icons.favorite_border),
              onPressed: () {
                onLike(post.id);
              },
            ),
            FlatButton(
              child: Icon(Icons.share),
              onPressed: () {},
            ),
          ],
        ),
      ],
    ),
  );
}
