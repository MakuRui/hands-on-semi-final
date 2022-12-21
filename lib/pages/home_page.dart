import 'package:api_semi_final/models/todos_model.dart';
import 'package:api_semi_final/pages/details_page.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List todosList = <dynamic>[];
  List <TodosModel> todosModel = [];
  var baseUrl = 'https://jsonplaceholder.typicode.com/todos';

  @override
  void initState() {
    super.initState();
    todoConvert();
  }

  void todoConvert () async {
    await todosGet();
    for (int count = 1; count < todosList.length; count++){
      setState(() {
        todosModel.add(TodosModel.fromJson(todosList[count]));
      });
    }
  }

  //READ ALL
  Future todosGet () async {
    var response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      showSuccessMessage('Getting all task successfully');
      setState(() {
        todosList = convert.jsonDecode(response.body) as List <dynamic>;
      });
    } else {
      showErrorMessage('Getting all task failed successfully');
      throw Exception('Request failed with a status: ${response.statusCode}');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Todos Task', style: TextStyle(fontSize: 25),),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 40, right: 40),
        child: ListView.builder(
          itemCount: todosModel.length,
            itemBuilder: (context, index){
              var indexTodo = todosModel[index];
              return Card(
                elevation: 10,
                child: ListTile(
                  title: Text(indexTodo.title),
                  subtitle: Text(indexTodo.id.toString()),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => DetailsPage(idVal: indexTodo.id)));
                  },
                ),
              );
            }),
      ),
    );
  }
  void showSuccessMessage(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.green,

    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  void showErrorMessage(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
