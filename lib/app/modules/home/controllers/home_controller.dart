import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:teleffony_app/app/models/category_model.dart';
import 'package:teleffony_app/app/models/contact_model.dart';
import 'package:teleffony_app/app/modules/home/views/home_view.dart';
import 'package:uuid/uuid.dart';

class HomeController extends GetxController {
  final GetStorage storage = GetStorage();

  final RxInt _categoryIndex = 0.obs;
  int get categoryIndex => _categoryIndex.value;
  set categoryIndex(value) => _categoryIndex.value = value;

  final RxBool _showContactForm = false.obs;
  bool get showContactForm => _showContactForm.value;
  set showContactForm(value) => _showContactForm.value = value;

  final TextEditingController addPhoneController = TextEditingController();
  final TextEditingController addNameController = TextEditingController();
  final TextEditingController addSocialLink = TextEditingController();

  final RxList<Category> _categories = <Category>[].obs;
  List<Category> get categories => _categories;

  final RxList<AppContact> _contacts = <AppContact>[].obs;
  List<AppContact> get contacts => _contacts;
  set contacts(value) => _contacts.value = value;

  final RxList<Category> _selectedCategories = <Category>[].obs;
  List<Category> get selectedCategories => _selectedCategories;

  List<AppContact> get selectedForDelete =>
      contacts.where((contact) => contact.marked).toList();

  final RxBool enableDelete = false.obs;

  final Rx<Category?> _selectedCategory = Rx<Category?>(null);
  Category? get selectedCategory => _selectedCategory.value;
  set selectedCategory(Category? value) => _selectedCategory.value = value;

  // Hold original copy
  var filterCategories = <Category>[];

  final RxBool _categorySelectorShown = false.obs;
  get categorySelectorShown => _categorySelectorShown.value;
  set categorySelectorShown(value) => _categorySelectorShown.value = value;

  late ImagePicker imagePicker;
  final Rx<File?> imageFile = Rx<File?>(null);
  late TextEditingController nameController;

  ScrollController scrollController = ScrollController();

  final RxMap<String, AppContact> _contactsToSave = <String, AppContact>{}.obs;
  Map<String, AppContact> get contactsToSave => _contactsToSave;
  set contactsToSave(value) => _contactsToSave.value = value;

  @override
  void onInit() async {
    super.onInit();
    imagePicker = ImagePicker();
    nameController = TextEditingController();
    // await storage.erase(); // Used during development
    getCategories();
    loadToSelectedCategories();
  }

  void selectPicture() async {
    XFile? imageXFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );

    if (imageXFile != null) {
      imageFile.value = File(imageXFile.path);
    }
  }

  void openCategoryDetails(Category category) {
    getContacts(category.id!);
    selectedCategory = category;

    Get.dialog(
      CategoryDetailsModal(
        category: category,
      ),
    );
  }

  getCategories() {
    final jsonData = storage.read<String>('categories');
    if (jsonData != null) {
      final categoryList = jsonDecode(jsonData) as List<dynamic>;
      List<Category> categoryData =
          categoryList.map((e) => Category.fromJson(e)).toList();
      _categories.assignAll(categoryData);
    }
  }

  void setCategory(Category category) {
    int foundIndex = _categories.indexWhere((c) => c.id == category.id);
    if (foundIndex != -1) {
      _categories[foundIndex] = category;
    } else {
      _categories.add(category);
    }

    final categoriesJson =
        jsonEncode(_categories.map((category) => category.toJson()).toList());
    storage.write('categories', categoriesJson);

    // Clear Input
    nameController.clear();
    imageFile.value = null;
  }

  void setContact(AppContact contact) {
    int foundIndex = _contacts.indexWhere((c) => c.id == contact.id);
    if (foundIndex != -1) {
      _contacts[foundIndex] = contact;
    } else {
      _contacts.add(contact);
    }

    final contactsJson = jsonEncode(_contacts.map((c) => c.toJson()).toList());
    storage.write('contacts_${contact.categoryId}', contactsJson);
  }

  void getContacts(String categoryId) {
    var storeKey = 'contacts_$categoryId';

    final jsonData = storage.read<String>(storeKey);
    if (jsonData != null) {
      final contactList = jsonDecode(jsonData) as List<dynamic>;
      List<AppContact> contactData = contactList
          .map((e) => AppContact.fromJson(e as Map<String, dynamic>))
          .toList();
      _contacts.assignAll(contactData);
    }
  }

  void addToSelectedCategories(Category cat) {
    int foundIndex = _selectedCategories.indexWhere((c) => c.id == cat.id);
    if (foundIndex != -1) {
      _selectedCategories[foundIndex] = cat;
    } else {
      _selectedCategories.add(cat);
      filterCategories.add(cat);
    }

    final categoriesJson = jsonEncode(
        _selectedCategories.map((category) => category.toJson()).toList());
    storage.write('selected_categories', categoriesJson);
  }

  void loadToSelectedCategories() {
    final jsonData = storage.read<String>('selected_categories');
    if (jsonData != null) {
      final categoryList = jsonDecode(jsonData) as List<dynamic>;
      List<Category> categoryData =
          categoryList.map((e) => Category.fromJson(e)).toList();
      _selectedCategories.assignAll(categoryData);
      filterCategories.assignAll(categoryData);
    }
  }

  Future<void> getContactFromPhone() async {
    var granted = await FlutterContactPicker.hasPermission();
    if (granted) {
      // We already have permission
    } else {
      // We request for permissions
      granted = await FlutterContactPicker.requestPermission();
    }

    final PhoneContact contact = await FlutterContactPicker.pickPhoneContact();

    var appContact = AppContact(
      id: const Uuid().v4(),
      categoryId: selectedCategory?.id,
      name: contact.fullName,
      number: contact.phoneNumber?.number,
      marked: false,
    );

    _contactsToSave['phone'] = appContact;
  }

  Future<void> getContactFromSocial() async {
    String link = addSocialLink.text;
    String name = addNameController.text;

    var appContact = AppContact(
      id: const Uuid().v4(),
      categoryId: selectedCategory?.id,
      name: name,
      number: link,
      marked: false,
    );

    _contactsToSave['social'] = appContact;

    addNameController.clear();
    addSocialLink.clear();

    categoryIndex = 1;
  }

  Future<void> confirmSaveNumbers() async {
    List<AppContact> contactsList = contactsToSave.values.toList();
    for (var cnt in contactsList) {
      setContact(cnt);
    }
    _contactsToSave.clear();
    categoryIndex = 0;
  }

  Future<void> closeDetailsView() async {
    _contacts.clear();
    categoryIndex = 0;
    Get.back();
  }

  void markForDelete(AppContact contact) {
    if (selectedForDelete.contains(contact)) {
      selectedForDelete.remove(contact);
    } else {
      selectedForDelete.add(contact);
    }
  }

  Future<void> deleteContacts() async {
    if (enableDelete.value) {
      var selectedContacts = List.of(selectedForDelete);

      for (var contact in selectedContacts) {
        var storeKey = 'contacts_${contact.categoryId}';
        if (storage.hasData(storeKey)) {
          var storeData = storage.read(storeKey);
          var storeList = jsonDecode(storeData) as List<dynamic>;
          List<AppContact> contactList = storeList
              .map(
                (e) => AppContact.fromJson(e as Map<String, dynamic>),
              )
              .toList();

          contactList.removeWhere((c) => c.id == contact.id);
          _contacts.removeWhere((c) => c.id == contact.id);

          storage.write(storeKey,
              jsonEncode(contactList.map((e) => e.toJson()).toList()));
        }
      }

      enableDelete.value = false;
    } else {
      enableDelete.value = true;
    }
  }

  void filterResults(String searchTerm) {
    if (searchTerm.isEmpty) {
      selectedCategories.assignAll(filterCategories);
    } else {
      selectedCategories.assignAll(filterCategories.where((category) =>
          category.name!.toLowerCase().contains(searchTerm.toLowerCase())));
    }
  }

  void getContactFromForm() {
    String name = addNameController.text;
    String phone = addPhoneController.text;
    print("$name, $phone");

    var appContact = AppContact(
      id: const Uuid().v4(),
      categoryId: selectedCategory?.id,
      name: name,
      number: phone,
      marked: false,
    );

    _contactsToSave['form'] = appContact;

    categoryIndex = 1;

    addNameController.clear();
    addPhoneController.clear();
  }
}
