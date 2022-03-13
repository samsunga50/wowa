double calculateCharge(String text) {
//https://ceb.mu/customer-corner/tariff/domestic-tariff
  const double MINIMUM_CHARGE = 44;
  const double FIRST25 = 3.16;
  const List<double> NEXT25 = [4.38, 4.74, 5.45];
  const double NEXT100 = 6.15;
  const List<double> NEXT50 = [7.02, 7.90];
  const double ADDITIONAL = 8.77;

//user input

  var unit = 1;
  try {
    unit = int.parse(text);
  } catch (e) {
    return 0;
  }

  var rate = 'MINIMUM_CHARGE';
  var charge = MINIMUM_CHARGE;

//FIRST25
  var gamut = 25;
  if (unit > gamut) {
    charge += gamut * FIRST25;
    unit -= gamut;
  } else {
    rate = 'FIRST25';
    charge += unit * FIRST25;
  }

//NEXT25
  gamut = 25;
  for (var i = 0; i < 3; i++) {
    if (unit > gamut) {
      charge += gamut * NEXT25[i];
      unit -= gamut;
    } else {
      if (rate == 'MINIMUM_CHARGE') {
        var index = i + 1;
        rate = 'NEXT25(' + index.toString() + ')';
        charge += unit * NEXT25[i];
      }
    }
  }
//NEXT100
  gamut = 100;
  if (unit > gamut) {
    charge += gamut * NEXT100;
    unit -= gamut;
  } else {
    if (rate == 'MINIMUM_CHARGE') {
      rate = 'NEXT100';
      charge += unit * NEXT100;
    }
  }

//NEXT50
  gamut = 50;
  for (var i = 0; i < 2; i++) {
    if (unit > gamut) {
      charge += gamut * NEXT50[i];
      unit -= gamut;
    } else {
      if (rate == 'MINIMUM_CHARGE') {
        var index = i + 1;
        rate = 'NEXT50(' + index.toString() + ')';
        charge += unit * NEXT50[i];
      }
    }
  }

//ADDITIONAL
  if (rate == 'MINIMUM_CHARGE') {
    rate = 'ADDITIONAL';
    charge += unit * ADDITIONAL;
  }

  return charge;
}
