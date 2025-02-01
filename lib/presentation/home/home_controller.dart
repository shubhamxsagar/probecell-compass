import 'package:get/get.dart';

class HomeController extends GetxController {
  var categories = <Category>[].obs;
  var subCategories = <SubCategory>[].obs;
  var isListVisible = false.obs;
  RxInt currentTabIndex = 0.obs;
  RxInt currentServiceSlide = 0.obs;
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
    categories.addAll([
      Category('Science & Technology'),
      Category('Engineering'),
      Category('Social Sciences'),
      Category('Business & Economics'),
      Category('Healthcare'),
      Category('Environment & Sustainability'),
      Category('Emerging Tech'),
    ]);
    subCategories.addAll([
      SubCategory('AI'),
      SubCategory('Robotics'),
      SubCategory('Quantum'),
      SubCategory('Space'),
      SubCategory('Biotech'),
      SubCategory('Cybersecurity'),
      SubCategory('Civil'),
      SubCategory('Mechanical'),
      SubCategory('Electrical'),
      SubCategory('Aerospace'),
      SubCategory('Nanotech'),
      SubCategory('Automation'),
      SubCategory('Psychology'),
      SubCategory('Education'),
      SubCategory('Sociology'),
      SubCategory('Politics'),
      SubCategory('Ethics'),
      SubCategory('Law'),
      SubCategory('Finance'),
      SubCategory('Marketing'),
      SubCategory('Entrepreneurship'),
      SubCategory('E-commerce'),
      SubCategory('Leadership'),
      SubCategory('Investment'),
      SubCategory('Genetics'),
      SubCategory('MentalHealth'),
      SubCategory('Epidemiology'),
      SubCategory('Pharma'),
      SubCategory('Telemedicine'),
      SubCategory('Bioinformatics'),
      SubCategory('Climate'),
      SubCategory('Renewable'),
      SubCategory('Conservation'),
      SubCategory('Recycling'),
      SubCategory('Sustainability'),
      SubCategory('Biodiversity'),
      SubCategory('Metaverse'),
      SubCategory('Blockchain'),
      SubCategory('Web3'),
      SubCategory('AR/VR'),
      SubCategory('Drones'),
      SubCategory('Automation'),
    ]);
  }

  void toggleSelectionCategories(int index) {
    categories[index].isSelected = !categories[index].isSelected;
    categories.refresh();
  }
  void toggleSelectionSubCategories(int index) {
    subCategories[index].isSelected = !subCategories[index].isSelected;
    subCategories.refresh();
  }
}

class Category {
  final String name;
  bool isSelected;

  Category(this.name, {this.isSelected = false});
}

class SubCategory {
  final String name;
  bool isSelected;

  SubCategory(this.name, {this.isSelected = false});
}
