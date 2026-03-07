void main() {
  var gifts = {
    'first': 'partridge',
    'second': 'turtledoves',
    'fifth': 'golden rings',
    'name': 'Nanda',
    'nim': '244107060058',
  };

  var nobleGases = {2: 'helium', 10: 'neon', 18: 'argon', 27: 'Nanda', 28: '244107060058'};

  var mhs1 = Map<String, String>();
  mhs1 ['name'] = 'Nanda';
  mhs1 ['nim'] = '244107060058';

  var mhs2 = Map<int, String>();
  mhs2[27] = 'Nanda';
  mhs2[28] = '244107060058';

  print(gifts);
  print(nobleGases);
  print(mhs1);
  print(mhs2);
}
