import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_finder_app/data/model/job_model.dart';
import 'package:job_finder_app/data/repository/job_repository.dart';

class SearchJobController extends GetxController {
  final JobRepository repository;

  SearchJobController(this.repository);

  final jobs = <JobModel>[].obs;

  final isLoading = false.obs;
  final isLoadingMore = false.obs;

  final searchController = TextEditingController();
  final scrollController = ScrollController();

  Timer? _debounce;

  String currentQuery = '';

  int currentPage = 1;

  bool hasMore = true;

  @override
  void onInit() {
    super.onInit();

    currentQuery = Get.arguments ?? '';

    searchController.text = currentQuery;

    if (currentQuery.isNotEmpty) {
      fetchJobs();
    }

    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200) {
      loadMoreJobs();
    }
  }

  Future<void> fetchJobs() async {
    print('Searching: $currentQuery page=$currentPage');
    if (isLoading.value) return;
    try {
      isLoading.value = true;

      final result = await repository.getJobs(
        query: currentQuery,
        page: currentPage,
      );

      jobs.value = result;

      hasMore = result.isNotEmpty;
      
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadMoreJobs() async {
    print('LOAD MORE PAGE: $currentPage');
    if (isLoadingMore.value) return;

    if (!hasMore) return;

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
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }

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

    currentQuery = query;

    currentPage = 1;
    hasMore = true;

    await fetchJobs();
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
}