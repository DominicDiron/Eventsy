import 'package:get_storage/get_storage.dart';

class CurrentId {
  late final GetStorage box;
  late int currentUserId;

  // Constructor
  CurrentId() {
    box = GetStorage();
    currentUserId = box.read('id'); // Assign the value inside the constructor
  }
}
