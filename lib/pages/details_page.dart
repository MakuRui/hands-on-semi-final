import 'package:api_semi_final/custom_widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class DetailsPage extends StatefulWidget {
  final int idVal;
  const DetailsPage({Key? key, required this.idVal}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {

  dynamic todosData = {};
  var baseUrl = 'https://jsonplaceholder.typicode.com/todos';

  @override
  void initState() {
    super.initState();
    todoGet(widget.idVal);
  }

  //READ ONE
  Future todoGet (int id) async {
    var response = await http.get(
        Uri.parse('$baseUrl/$id'));
    if (response.statusCode == 200) {
      showSuccessMessage('Getting one task successfully');
      setState(() {
        todosData = convert.jsonDecode(response.body);
      });
    } else {
      showErrorMessage('Getting one task failed successfully');
      throw Exception('Request failed with a status: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Details'),
      ),
      body: ListView(
        children: [
          TextWidget(
              textTitle: 'UserId',
              textDetails: todosData['userId'].toString()
          ),
          TextWidget(
              textTitle: 'Id',
              textDetails: todosData['id'].toString()
          ),
          TextWidget(
              textTitle: 'Title',
              textDetails: todosData['title'].toString()
          ),
          TextWidget(
              textTitle: 'Completed',
              textDetails: todosData['completed'].toString()
          ),
        ],
      )
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
