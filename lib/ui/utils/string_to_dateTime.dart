DateTime durationToCheckoutTime(String duration) {
  var now = DateTime.now();

  var num = int.parse(duration.split(' ').first);
  var scale = duration.split(' ').last;

  var checkout;

  switch (scale) {
    case 'hours':
      checkout = now.add(Duration(hours: num));
      break;
    case 'days':
      checkout = now.add(Duration(days: num));
      break;
    case 'months':
      checkout = now.add(Duration(days: 30 * num));
      break;
  }

  return checkout;
}
