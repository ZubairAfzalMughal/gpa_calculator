double unWeightedGrade(String grade) {
  if (grade == 'A') {
    return 3.5;
  }
  if (grade == 'A+') {
    return 4.0;
  }
  if (grade == 'B') {
    return 2.5;
  }
  if (grade == 'B+') {
    return 3.0;
  }
  if (grade == 'C') {
    return 1.5;
  }
  if (grade == 'C+') {
    return 2.0;
  }
  if (grade == 'D') {
    return 1.0;
  }
  if (grade == 'F') {
    return 0.0;
  }
  return 0.0;
}

double weightedGrade(String grade) {
  if (grade == 'A') {
    return 4.5;
  }
  if (grade == 'A+') {
    return 5.0;
  }
  if (grade == 'B') {
    return 3.5;
  }
  if (grade == 'B+') {
    return 4.0;
  }
  if (grade == 'C') {
    return 2.5;
  }
  if (grade == 'C+') {
    return 3.0;
  }
  if (grade == 'D') {
    return 2.0;
  }
  if (grade == 'F') {
    return 0.0;
  }
  return 0.0;
}
