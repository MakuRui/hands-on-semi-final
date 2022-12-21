class TodosModel {
  final int id;
  final int userId;
  String title;
  bool completed;

  TodosModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.completed
  });

  factory TodosModel.fromJson(Map<String, dynamic> json){
    return TodosModel(
        id: json['id'],
        userId: json['userId'],
        title: json['title'],
        completed: json['completed']
    );
  }
}