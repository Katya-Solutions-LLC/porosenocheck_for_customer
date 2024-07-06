String formatTimeInGreek(int timestamp) {
  int difference = DateTime.now().millisecondsSinceEpoch - timestamp;
  String result;

  if (difference < 60000) {
    result = countSeconds(difference);
  } else if (difference < 3600000) {
    result = countMinutes(difference);
  } else if (difference < 86400000) {
    result = countHours(difference);
  } else if (difference < 604800000) {
    result = countDays(difference);
  } else if (difference / 1000 < 2419200) {
    result = countWeeks(difference);
  } else if (difference / 1000 < 31536000) {
    result = countMonths(difference);
  } else {
    result = countYears(difference);
  }

  return !result.startsWith("Μ") ? '$result πριν' : result;
}

String countSeconds(int difference) {
  int count = (difference / 1000).truncate();
  return count > 1 ? '$count δευτερόλεπτα' : 'Μόλις τώρα';
}

String countMinutes(int difference) {
  int count = (difference / 60000).truncate();
  return count.toString() + (count > 1 ? ' λεπτά' : ' λεπτό');
}

String countHours(int difference) {
  int count = (difference / 3600000).truncate();
  return count.toString() + (count > 1 ? ' ώρες' : ' ώρα');
}

String countDays(int difference) {
  int count = (difference / 86400000).truncate();
  return count.toString() + (count > 1 ? ' ημέρες' : ' ημέρα');
}

String countWeeks(int difference) {
  int count = (difference / 604800000).truncate();
  if (count > 3) {
    return '1 μήνας';
  }
  return count.toString() + (count > 1 ? ' εβδομάδες' : ' εβδομάδα');
}

String countMonths(int difference) {
  int count = (difference / 2628003000).round();
  count = count > 0 ? count : 1;
  if (count > 12) {
    return '1 χρόνος';
  }
  return count.toString() + (count > 1 ? ' μήνες' : ' μήνας');
}

String countYears(int difference) {
  int count = (difference / 31536000000).truncate();
  return count.toString() + (count > 1 ? ' χρόνια' : ' χρόνος');
}
