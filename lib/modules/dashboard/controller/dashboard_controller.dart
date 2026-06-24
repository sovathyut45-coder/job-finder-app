import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DashboardController extends GetxController{
  final currentIndex = 0.obs;
  final box = GetStorage();

  final savedCount = 0.obs;
  final recentCount = 0.obs;
  final searchCount = 0.obs;
  final appliedCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadStats();
  }
  
  void changeIndex(int index){
    currentIndex.value = index;
  }

  void loadStats(){
    savedCount.value = (box.read('save_jobs') ?? []).length;
    recentCount.value = (box.read('recent_jobs') ?? []).length;
    searchCount.value = (box.read('search_history') ?? []).length;
    appliedCount.value = (box.read('applied_jobs') ?? []).length;
  }


}