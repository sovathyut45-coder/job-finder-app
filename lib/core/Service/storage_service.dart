import 'package:get_storage/get_storage.dart';

class StorageService {
  static final box = GetStorage();

  static const String saveJobKey = 'save_jobs';
  static const String searchHistoryKey = 'search_history';

}