Map getMostDonateSchool(middle, high) {
  List schools = [];
  middle.forEach((k, v) => schools.add({"school": k, ...v}));
  high.forEach((k, v) => schools.add({"school": k, ...v}));

  String school = "";
  int v = 0;
  for (int i = 0; i < schools.length; i++) {
    if (schools[i]["totalDonate"] >= v) {
      v = schools[i]["totalDonate"];
      school = schools[i]["school"];
    }
  }

  return {
    "school": school,
    "totalDonate": v,
  };
}
