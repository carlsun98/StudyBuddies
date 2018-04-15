export class ClassModel {
  constructor(classJsonData) {
    this.classID = classJsonData["id"]
    this.classTitle = classJsonData["course_title"]
    this.classNum = classJsonData["course_number"]
    this.classAbbr = classJsonData["course_abbreviation"]
  }
}
