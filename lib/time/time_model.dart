class TimeModel {
  final int? timetableId, id;
  final String week,
      starttime,
      endtime,
      building,
      classNum,
      lectureNum,
      lectureName;

  TimeModel.fromJson(Map<String, dynamic> json)
      : timetableId = json['timetableId'],
        id = null,
        week = json['week'],
        starttime = json['starttime'],
        endtime = json['endtime'],
        building = json['building'],
        classNum = json['classNum'],
        lectureNum = json['lectureNum'],
        lectureName = json['lectureName'];

  TimeModel.fromJsonMyTimeTable(Map<String, dynamic> json)
      : timetableId = null,
        id = json['id'],
        week = json['week'],
        starttime = json['starttime'],
        endtime = json['endtime'],
        classNum = json['classNum'],
        building = json['building'],
        lectureName = json['lectureName'],
        lectureNum = json['lectureNum'];
}
