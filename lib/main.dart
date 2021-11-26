import "package:flutter/material.dart";

void main() => runApp(App());

class App extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.teal),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController todoController = TextEditingController();

  final _todoList = [];

  void _addTodoToTheListHandler() {
    if (todoController.text.isEmpty) return;
    String title = todoController.text;
    setState(() {
      _todoList.add({
        "title": title,
        "id": DateTime.now().toString(),
        "isChecked": false
      });
      todoController.text = "";
    });

    Navigator.of(context).pop();
  }

  void _deleteTodo(String id) {
    setState(() {
      _todoList.removeWhere((element) => element["id"] == id);
    });
  }

  void _addTodoHandler() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 400,
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Column(
              children: [
                TextField(
                  controller: todoController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "To Do",
                      alignLabelWithHint: true,
                      hintText: "Finish Remaining Projects"),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: ElevatedButton(
                    onPressed: _addTodoToTheListHandler,
                    child: Text("Add"),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Todos"),
        actions: [
          IconButton(onPressed: _addTodoHandler, icon: Icon(Icons.add))
        ],
      ),
      body: Column(
        children: [
          _todoList.length > 0
              ? Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  height: 600,
                  child: ListView(
                      children: _todoList.map((list) {
                    String title = list["title"] as String;
                    return Card(
                      child: ListTile(
                        leading: Checkbox(
                          onChanged: (value) {
                            setState(() {
                              list["isChecked"] = value as bool;
                            });
                          },
                          value: list["isChecked"] as bool,
                        ),
                        title: Text(
                          title,
                          style: TextStyle(
                              decoration: list["isChecked"]
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                              fontWeight: FontWeight.w300,
                              fontSize: 20),
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            _deleteTodo(list["id"] as String);
                          },
                        ),
                      ),
                    );
                  }).toList()),
                )
              : Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "You do not have any todos!",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTodoHandler,
        child: Icon(Icons.add),
      ),
    );
  }
}
