class Test {
  String key;
  String name;

  Test.fromJson(snapshot)
      : key = snapshot.key,
        name = snapshot.value['Name'];
}
