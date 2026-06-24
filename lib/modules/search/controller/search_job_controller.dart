import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:job_finder_app/data/model/job_model.dart';
import 'package:job_finder_app/data/repository/job_repository.dart';
import 'package:job_finder_app/modules/dashboard/controller/dashboard_controller.dart';

class SearchJobController extends GetxController {
  final JobRepository repository;

  SearchJobController(this.repository);

  final jobs = <JobModel>[].obs;

  final isLoading = false.obs;
  final isLoadingMore = false.obs;

  final searchController = TextEditingController();
  final scrollController = ScrollController();
  final box = GetStorage();
  final searchHistory = <String>[].obs;

  Timer? _debounce;

  String currentQuery = '';

  int currentPage = 1;

  bool hasMore = true;

  final selectedFilter = 'All'.obs;
  final filteredSuggestions = <String>[].obs;
  final suggestions = [
    'Software Engineer',
    'Flutter Developer',
    'Mobile Developer',
    'UI UX Designer',
    'Data Analyst',
    'Backend Developer',
    'Frontend Developer',
    'Project Manager',
  ].obs;

  @override
  void onInit() {
    super.onInit();

    searchHistory.value = List<String>.from(box.read('search_history') ?? []);

    currentQuery = Get.arguments ?? '';

    searchController.text = currentQuery;

    loadCachedJobs(currentQuery);

    if (currentQuery.isNotEmpty) {
      fetchJobs();
    }

    scrollController.addListener(_onScroll);
  }

  void changeFilter(String filter) {
    selectedFilter.value = filter;

    currentPage = 1;
    hasMore = true;

    fetchJobs();
  }

  void _onScroll() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200) {
      loadMoreJobs();
    }
  }

  Future<void> fetchJobs() async {
    String query = currentQuery;
    if (isLoading.value) return;
    
    if (selectedFilter.value == 'Remote') {
        query = '$query Remote';
    }

    if (selectedFilter.value == 'Full Time') {
      query = '$query Full Time';
    }

    if (selectedFilter.value == 'Part Time') {
      query = '$query Part Time';
    }

    try {
      isLoading.value = true;

      final result = await repository.getJobs(
        query: currentQuery,
        page: currentPage,
      );

    jobs.assignAll(result);

    hasMore = result.length >= 20;
    box.write(
      'cached_jobs_${query.toLowerCase()}',
      result.map((e) => e.toJson()).toList(),
    );
      
    } catch (e) {
      print('API ERROR: $e');
      loadCachedJobs(currentQuery);
      Get.snackbar(
        'Offline Mode',
        'Showing cached jobs',
      );
    } finally {
      isLoading.value = false;
    }
  }

  void loadCachedJobs(String query) {
    print('LOAD CACHE');
    try{
      final data =
        box.read('cached_jobs_${query.toLowerCase()}') ?? [];

      jobs.value = List<Map<String, dynamic>>.from(data).map((e) => JobModel.fromJson(e)).toList();
    }catch(e){
      Get.snackbar(
          'Error',
          'No Cached Jobs',
        );
    }
}

  Future<void> loadMoreJobs() async {
    //print('LOAD MORE PAGE: $currentPage');
    if (isLoadingMore.value || !hasMore) return;

    try {
      isLoadingMore.value = true;

      currentPage++;

      final result = await repository.getJobs(
        query: currentQuery,
        page: currentPage,
      );

      if (result.isEmpty) {
        hasMore = false;
        return;
      }

      jobs.addAll(result);
    } catch (e) {
      currentPage--;

      Get.snackbar(
        'Error',
        e.toString(),
      );
    } finally {
      isLoadingMore.value = false;
    }
  }

void onSearchChanged(String value) {
  //print('Typing: $value');
  if (_debounce?.isActive ?? false) {
    _debounce?.cancel();
  }

  // Suggestion Filter
  if (value.isEmpty) {
    filteredSuggestions.clear();
  } else {
    filteredSuggestions.value =
        suggestions.where(
          (item) => item
              .toLowerCase()
              .contains(
                value.toLowerCase(),
              ),
        ).toList();
  }

  //  print(
  //     'Suggestions: ${filteredSuggestions.length}',
  //   );

  _debounce = Timer(
    const Duration(milliseconds: 800),
    () {
      final query = value.trim();

      if (query.isEmpty) return;

      if (query == currentQuery) return;

      currentQuery = query;

      currentPage = 1;
      hasMore = true;

      fetchJobs();
    },
  );
}

  Future<void> searchJobs() async {
    final query = searchController.text.trim();

    if (query.isEmpty) return;

    saveSearchHistory(query);

    currentQuery = query;

    currentPage = 1;
    hasMore = true;

    await fetchJobs();
    // load dashboard stats
   Future.microtask(() {
  if (Get.isRegistered<DashboardController>()) {
    Get.find<DashboardController>()
        .loadStats();
  }
});
  }

  Future<void> refreshJobs() async {
    currentPage = 1;
    hasMore = true;

    await fetchJobs();
  }

  @override
  void onClose() {
    _debounce?.cancel();

    scrollController.removeListener(_onScroll);

    scrollController.dispose();
    searchController.dispose();

    super.onClose();
  }

  void saveSearchHistory(String query) {
    if(query.isEmpty) return;
    searchHistory.remove(query);
    searchHistory.insert(0, query);
    if(searchHistory.length > 5){
      searchHistory.removeLast();
    }
    box.write('search_history', searchHistory);
  }

  void removeSearchHistory(String keyword) {
    searchHistory.remove(keyword);

    box.write(
      'search_history',
      searchHistory.toList(),
    );
    Future.microtask(() {
      if (Get.isRegistered<DashboardController>()) {
        Get.find<DashboardController>()
            .loadStats();
      }
    });
  }

  void clearSearchHistory() {
    searchHistory.clear();

    box.remove('search_history');
     Future.microtask(() {
      if (Get.isRegistered<DashboardController>()) {
        Get.find<DashboardController>()
            .loadStats();
      }
    });
  }

}