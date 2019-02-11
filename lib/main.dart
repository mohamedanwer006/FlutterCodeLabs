import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
void main (){
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'codelab',
      home:RandomWords(),
      theme:ThemeData.dark()
    )
  );
}

//class Home extends StatelessWidget{
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar:AppBar(
//        centerTitle: true,
//        title: Text('codelab'),
//      ),
//      body: Center(
//        child:RandomWords(),
//      )
//    );
//  }
//}


class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final wordPair = new WordPair.random();
  final Set<WordPair> _saved = new Set<WordPair>();
  final List<WordPair> _suggestions = <WordPair>[];
  final TextStyle _biggerFont = const TextStyle(fontSize: 20.5);

  void _pushSaved() {

    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (BuildContext context) {
          final Iterable<ListTile> tiles = _saved.map(
                (WordPair pair) {
              return new ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.orange,
                  child: Text(pair.asPascalCase.substring(0,1),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Colors.white
                    ),),
                ),
                title: new Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final List<Widget> divided = ListTile
              .divideTiles(
            context: context,
            tiles: tiles,
          )
              .toList();
          return Scaffold(
            appBar: AppBar(
              title: Text('Favorite Suggestions'),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold (
      appBar: new AppBar(
        title: new Text('Code labe App',
          style: TextStyle(
            color: Colors.redAccent,
            fontWeight: FontWeight.bold,
            letterSpacing: 8,
          ),),
        centerTitle: true,
        actions: <Widget>[
          new IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),

      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    return new ListView.builder(
        padding: EdgeInsets.all(5),
        itemBuilder: (BuildContext context, int i) {
          if (i.isOdd) {
            return new Divider();
          }

          final int index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        }
    );
  }
  Widget _buildRow(WordPair pair) {
    final bool alreadySaved = _saved.contains(pair);
    return new ListTile(
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ?Colors.redAccent:null,
      ),
      leading: CircleAvatar(

        child: Text(pair.asPascalCase.substring(0,1),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.white
        ),),
        backgroundColor: Colors.orange,
      ),
      title: new Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      subtitle:new Text(
        pair.asPascalCase,
        style: TextStyle(
         fontSize: 15,
        ),
      ),
      onTap: (){
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      }
    );
  }
}
