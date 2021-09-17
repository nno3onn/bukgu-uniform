getRankingSchool(schools) {
  var list = [];
  schools.forEach(
      (k, v) => list.add({"school": k, "rank": 1, "total": v["totalDonate"]}));

  list.sort((f, s) => f["total"] > s["total"]
      ? -1
      : f["total"] == s["total"]
          ? 0
          : 1);

  var drank = 1;
  var accum = 1;
  var targetValue = list[0]["total"];
  var maxValue = list[0]["total"];

  for (int i = 0; i < list.length; i++) {
    if (list[i]["total"] == targetValue) {
      list[i]["rank"] = drank;
    }
    if (list[i]["total"] < targetValue) {
      drank += accum;
      accum = 1;
      targetValue = list[i]["total"];
      list[i]["rank"] = drank;
    }
    list[i]["maxValue"] = maxValue;
  }

  return list;
}
