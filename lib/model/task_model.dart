class TaskModel {
  int? id = 0;
  String? title;
  String? note;
  int? isCompleted;
  String? date;
  String? startTime;
  String? endTime;
  int? color;
  int? remind;
  String? repeat;
  TaskModel(
      {this.id,
      this.title,
      this.note,
      this.isCompleted,
      this.date,
      this.startTime,
      this.endTime,
      this.color,
      this.remind,
      this.repeat});
  TaskModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    note = map['note'];
    isCompleted = map['isCompleted'];
    color = map['color'];
    startTime = map['startTime'];
    endTime = map['endTime'];
    remind = map['remind'];
    repeat = map['repeat'];
    date = map['date'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['title'] = title;
    data['note'] = note;
    data['isCompleted'] = isCompleted;
    data['color'] = color;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    data['remind'] = remind;
    data['repeat'] = repeat;
    data['date'] = date;
    return data;
  }
}
