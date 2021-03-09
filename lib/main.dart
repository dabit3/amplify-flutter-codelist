import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_api/amplify_api.dart';
import 'models/ModelProvider.dart';
import 'amplifyconfiguration.dart';
import 'package:url_launcher/url_launcher.dart';

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
      home: MyHomePage()
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  initState() {
    super.initState(); 
    _configureAmplify();
  }

  void _configureAmplify() async {
    AmplifyDataStore datastorePlugin =
    AmplifyDataStore(modelProvider: ModelProvider.instance);
    Amplify.addPlugin(datastorePlugin);
    Amplify.addPlugin(AmplifyAPI());
    try {
      await Amplify.configure(amplifyconfig);
    } on AmplifyAlreadyConfiguredException {
      print("Tried to reconfigure Amplify; this can occur when your app restarts on Android.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.create)),
                Tab(icon: Icon(Icons.list)),
              ],
            ),
            title: Text("Code List"),
          ),
          body: TabBarView(
            children: [
              CreateCodeItem(),
              ViewCodeItems()
            ],
          ),
        ),
      );
  }

}

class CreateCodeItem extends StatefulWidget {
  CreateCodeItem({Key key}) : super(key: key);

  @override
  _CreateCodeItemState createState() => _CreateCodeItemState();
}

class _CreateCodeItemState extends State<CreateCodeItem> {
  TextEditingController _titleController;
  TextEditingController _descriptionController;
  TextEditingController _linkController;

  @override
  initState() {
    super.initState(); 
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _linkController = TextEditingController();
  }

  void _submit() async {
    CodeListItem newItem = CodeListItem(
      title: _titleController.text,
      description: _descriptionController.text,
      link: _linkController.text
    );
    await Amplify.DataStore.save(newItem);
    _titleController.clear();
    _descriptionController.clear();
    _linkController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 30, right: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: "Name"
              )
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: "Description"
              )
            ),
            TextField(
              controller: _linkController,
              decoration: InputDecoration(
                labelText: "Link"
              )
            ),
            ElevatedButton(onPressed: _submit, child: Text("Create CodeList Item"),)
          ],
        ),
      )
    );
  }
}

class ViewCodeItems extends StatefulWidget {
  ViewCodeItems({Key key}) : super(key: key);

  @override
  _ViewCodeItemsState createState() => _ViewCodeItemsState();
}

class _ViewCodeItemsState extends State <ViewCodeItems> {
  List _codeListItems = [];
  Stream stream;

  @override
  initState() {
    super.initState();
    _fetchItems();

    stream = Amplify.DataStore.observe(CodeListItem.classType);
    stream.listen((event) {
      if (this.mounted) {
        _fetchItems();
      }
    });
  }
  
  void _fetchItems() async {
    try {
      List<CodeListItem> data = await Amplify.DataStore.query(CodeListItem.classType);
      setState(() {
        _codeListItems = data;
      });
      print("data $data");
    } on Exception catch (e) {
      print('Query failed: $e');
    }
  }

  void _deleteItem(itemId) async {
    try {
     CodeListItem item = (await Amplify.DataStore.query(CodeListItem.classType, where: CodeListItem.ID.eq(itemId)))[0];
     await Amplify.DataStore.delete(item);
    } on Exception catch(e) {
       print('Delete failed: $e');
    }
  }

  @override 
  Widget build(BuildContext context) {
    return ListView(children: [
      Column(
        children: [
          ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            padding: EdgeInsets.all(8),
            itemCount: _codeListItems.length,
            itemBuilder: (_, index) {
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Center(child: Text(
                      _codeListItems[index].title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22.0
                      ),
                    )),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 14),
                    child: Center(child: Text(
                      _codeListItems[index].description,
                      style: TextStyle(
                        fontSize: 18.0
                      ),
                    )),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 14),
                    child: GestureDetector(
                      onTap: () async {
                        await launch(_codeListItems[index].link);
                      },
                      child: new Text(_codeListItems[index].link)
                    )
                  ),
                  ElevatedButton(
                    child: Text("Delete Item"),
                    onPressed: () =>
                      _deleteItem(_codeListItems[index].id),
                  )
                ]
              );
            }
          )
        ],
      )
    ]);
  }
}