class Book {
  Book({required this.name, required this.isFiction, this.progress = 0});
  //changed name and isFiction to no longer be final, so they can be edited
  String name;
  double progress;
  bool isFiction;
  void changeProgress(double newProgress) {
    progress = newProgress;
  }

  void increaseProgress() {
    progress = progress + .02;
  }
}
