class Uniform {
  Uniform({this.school, this.gender, this.season, this.clothType, this.size});

  final String school;
  final String gender;
  final String season;
  final String clothType;
  final String size;

  Map<String, dynamic> toJSON() => {
        "school": school,
        "gender": gender,
        "season": season,
        "clothType": clothType,
        "size": size,
      };
}
