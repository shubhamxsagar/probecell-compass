import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:probcell_solutions/core/services/api_client.dart';
import 'package:probcell_solutions/presentation/chats/chat_controller.dart';
import 'package:probcell_solutions/presentation/home/models/areas_model.dart';
import 'package:probcell_solutions/presentation/home/models/category_model.dart';
import 'package:probcell_solutions/presentation/home/models/courses_model.dart';
import 'package:probcell_solutions/presentation/home/models/search_history_model.dart';
import 'package:probcell_solutions/presentation/home/models/sub_category_model.dart';
import 'package:probcell_solutions/presentation/home/models/work_types_model.dart';
import 'package:probcell_solutions/routes/app_routes.dart';

class HomeController extends GetxController with GetTickerProviderStateMixin {
  late ApiClient _apiClient;
  late AnimationController animationController;
  var categories = <Category>[].obs;
  var subCategories = <SubCategory>[].obs;
  var typesWork = <TypesWork>[].obs;
  var areas = <Areas>[].obs;
  var courses = <Courses>[].obs;

  var isListVisible = false.obs;
  RxInt currentTabIndex = 0.obs;
  RxInt currentServiceSlide = 0.obs;
  var expandedHistoryIndex = (-1).obs;


  CategoryModel? categoryModel;
  SubCategoryModel? subCategoryModel;
  TypesWorkModel? typesWorkModel;
  AreasModel? areasModel;
  CoursesModel? coursesModel;
  SearchHistoryModel? searchHistoryModel;

  Rx<RxStatus> categoryStatus = RxStatus.empty().obs;
  Rx<RxStatus> subCategoryStatus = RxStatus.empty().obs;
  Rx<RxStatus> typesWorkStatus = RxStatus.empty().obs;
  Rx<RxStatus> areasStatus = RxStatus.empty().obs;
  Rx<RxStatus> coursesStatus = RxStatus.empty().obs;
  Rx<RxStatus> searchHistoryStatus = RxStatus.empty().obs;

  void onBottomNavigationBarItemTapped(int tabIdx) {
    currentTabIndex.value = tabIdx;
  }

  final carouselServiceItems = [
    {
      'title': 'Service 1',
      'description': 'Service 1 description',
    },
    {
      'title': 'Service 2',
      'description': 'Service 2 description',
    },
    {
      'title': 'Service 3',
      'description': 'Service 3 description',
    },
  ];

  @override
  void onInit() {
    super.onInit();
    _apiClient = Get.find<ApiClient>();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    )..forward();

    // Add listener to restart animation when it completes
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    )..forward();
  }

  void toggleHistoryExpansion(int index) {
  if (expandedHistoryIndex.value == index) {
    expandedHistoryIndex.value = -1;
  } else {
    expandedHistoryIndex.value = index;
  }
}

  void toggleSelectionCategories(int index) {
    // Deselect all first
    for (var item in categories) {
      item.isSelected = false;
    }
    // Select only the clicked item
    categories[index].isSelected = true;
    categories.refresh();
  }
  

  void toggleSelectionSubCategories(int index) {
    for (var item in subCategories) {
      item.isSelected = false;
    }
    subCategories[index].isSelected = true;
    subCategories.refresh();
  }

  void toggleSelectionTypesWork(int index) {
    for (var item in typesWork) {
      item.isSelected = false;
    }
    typesWork[index].isSelected = true;
    typesWork.refresh();
  }

  void toggleSelectionAreas(int index) {
    for (var item in areas) {
      item.isSelected = false;
    }
    areas[index].isSelected = true;
    print('Selected Area: ${areas[index].name}');
    areas.refresh();
  }

  void toggleSelectionCourses(int index) {
    for (var item in courses) {
      item.isSelected = false;
    }
    courses[index].isSelected = true;
    courses.refresh();
  }

  void changeScreen(int index) {
    currentTabIndex.value = index;
    if (index == 4) {
      getAreas();
    } else if (index == 5) {
      getCourses();
    } else if (index == 6) {
      getTypesWork();
    } else if (index == 7) {
      getCategories();
    } else if (index == 8) {
      subCategory();
    } else {
      Get.toNamed(
        Routes.chat,
        arguments: {
          'category': categories.firstWhere((element) => element.isSelected).id,
          'subCategory': subCategories.firstWhere((element) => element.isSelected).id,
          'typesWork': typesWork.firstWhere((element) => element.isSelected).id,
          'areas': areas.firstWhere((element) => element.isSelected).id,
          'courses': courses.firstWhere((element) => element.isSelected).id,
        },
        preventDuplicates: false,
      )?.then((value) {
        if (value != null && value['refresh']) {
          print('Refreshing search history...');
          getSearchHistory();
        }
      });
      Get.delete<ChatController>();
      Get.put(ChatController());
    }
  }

  Future<void> getSearchHistory() async {
    searchHistoryStatus.value = RxStatus.loading();
    _apiClient.searchHistory(
      onSuccess: (onSuccess) {
        print('Search History fetched $onSuccess');
        searchHistoryModel = SearchHistoryModel.fromJson(onSuccess);
        searchHistoryStatus.value = RxStatus.success();
      },
      onError: (onError) {
        searchHistoryStatus.value = RxStatus.error();
      },
    );
  }

  Future<void> getCategories() async {
    categoryStatus.value = RxStatus.loading();
    categoryModel = null;
    _apiClient.categories(
      onSuccess: (onSuccess) {
        print('Categories fetched $onSuccess');
        categoryStatus.value = RxStatus.success();
        categoryModel = CategoryModel.fromJson(onSuccess);

        categories.clear();

        if (categoryModel != null && categoryModel!.data != null) {
          for (var data in categoryModel!.data!) {
            categories.add(Category(data.id.toString(), data.name!));
          }
        }
      },
      onError: (onError) {
        categoryStatus.value = RxStatus.error();
        print('Categories not fetched $onError');
      },
    );
  }

  Future<void> subCategory() async {
    subCategoryStatus.value = RxStatus.loading();
    subCategoryModel = null;
    _apiClient.subcategories(
      onSuccess: (onSuccess) {
        print('Sub Categories fetched $onSuccess');
        subCategoryStatus.value = RxStatus.success();
        subCategoryModel = SubCategoryModel.fromJson(onSuccess);

        subCategories.clear();

        if (subCategoryModel != null && subCategoryModel!.data != null) {
          for (var data in subCategoryModel!.data!) {
            subCategories.add(SubCategory(data.id.toString(), data.name!));
          }
        }
      },
      onError: (onError) {
        subCategoryStatus.value = RxStatus.error();
        print('Sub Categories not fetched $onError');
      },
    );
  }

  Future<void> getTypesWork() async {
    typesWorkStatus.value = RxStatus.loading();
    typesWorkModel = null;
    _apiClient.typesOfWork(
      onSuccess: (onSuccess) {
        print('Types Work fetched $onSuccess');
        typesWorkStatus.value = RxStatus.success();
        typesWorkModel = TypesWorkModel.fromJson(onSuccess);

        typesWork.clear();

        if (typesWorkModel != null && typesWorkModel!.data != null) {
          for (var data in typesWorkModel!.data!) {
            typesWork.add(TypesWork(data.id.toString(), data.name!));
          }
        }
      },
      onError: (onError) {
        typesWorkStatus.value = RxStatus.error();
        print('Types Work not fetched $onError');
      },
    );
  }

  Future<void> getAreas() async {
    areasStatus.value = RxStatus.loading();
    areasModel = null;
    _apiClient.areas(
      onSuccess: (onSuccess) {
        print('Areas fetched $onSuccess');
        areasStatus.value = RxStatus.success();
        areasModel = AreasModel.fromJson(onSuccess);

        areas.clear();

        if (areasModel != null && areasModel!.data != null) {
          for (var data in areasModel!.data!) {
            areas.add(Areas(data.id.toString(), data.name!));
          }
        }
      },
      onError: (onError) {
        areasStatus.value = RxStatus.error();
        print('Areas not fetched $onError');
      },
    );
  }

  Future<void> getCourses() async {
    coursesStatus.value = RxStatus.loading();
    coursesModel = null;
    _apiClient.courses(
      onSuccess: (onSuccess) {
        print('Courses fetched $onSuccess');
        coursesStatus.value = RxStatus.success();
        coursesModel = CoursesModel.fromJson(onSuccess);

        courses.clear();

        if (coursesModel != null && coursesModel!.data != null) {
          for (var data in coursesModel!.data!) {
            courses.add(Courses(data.id.toString(), data.name!));
          }
        }
      },
      onError: (onError) {
        coursesStatus.value = RxStatus.error();
        print('Courses not fetched $onError');
      },
    );
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }

  void restartAnimations() {
    if (animationController.isCompleted) {
      animationController.reset();
      animationController.forward();
    }
  }
}

class Category {
  final String id;
  final String name;
  bool isSelected;

  Category(this.id, this.name, {this.isSelected = false});
}

class SubCategory {
  final String id;
  final String name;
  bool isSelected;

  SubCategory(this.id, this.name, {this.isSelected = false});
}

class TypesWork {
  final String id;
  final String name;
  bool isSelected;

  TypesWork(this.id, this.name, {this.isSelected = false});
}

class Areas {
  final String id;
  final String name;
  bool isSelected;

  Areas(this.id, this.name, {this.isSelected = false});
}

class Courses {
  final String id;
  final String name;
  bool isSelected;

  Courses(this.id, this.name, {this.isSelected = false});
}
