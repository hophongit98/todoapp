class ToDo {
  String id;
  String todoText;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<ToDo> todoList() {
    return [
      ToDo(id: '01', todoText: 'Morning exercise 1', isDone: true),
      ToDo(id: '02', todoText: 'Morning exercise 2', isDone: false),
      ToDo(id: '03', todoText: 'Morning exercise 3', isDone: false),
      ToDo(id: '04', todoText: 'Morning exercise 4', isDone: true),
      ToDo(id: '05', todoText: 'Morning exercise 5', isDone: false),
      ToDo(id: '06', todoText: 'Morning exercise 6', isDone: false),
      ToDo(id: '07', todoText: 'Morning exercise 7', isDone: false),
      ToDo(id: '08', todoText: 'Morning exercise 8', isDone: false),
      ToDo(id: '09', todoText: 'Morning exercise 9', isDone: false),
      ToDo(id: '010', todoText: 'Morning exercise 10', isDone: false),
      ToDo(id: '011', todoText: 'Morning exercise 11', isDone: false),
    ];
  }
}