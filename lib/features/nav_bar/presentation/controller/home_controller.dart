import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
 // final HomeRepository repository = HomeRepository();
  // final ProfileRepository profileRepository = ProfileRepository();

  // final profileController = Get.find<ProfileController>();
  var selectedIndex = 1.obs;
  var currentPage = 2.obs;
  var lastPage = 1;
  var errorMessage = ''.obs;
  var isLoading = false.obs;
  var isLoadingMore = false.obs;
  var loadingNewConversation=false.obs;
  var errorMessageNewConversation=''.obs;
 // var homeData = Rxn<VendorHomeData>();
  var vendorName = ''.obs;
  var vendorType = ''.obs;
  var idv = 0.obs;
  //var latestBookingm = <LatestBookings>[].obs;

  void changeTab(int index) {
    selectedIndex.value = index;
  }

  // Future<void> getHomeData() async {
  //   final result = await repository.getHomeData();
  //   result.fold(
  //     (failure) {
  //       errorMessage.value = failure.message ?? "Something went wrong";
  //     },
  //     (data) {
  //       homeData.value = data.data;
  //       lastPage = data.data.latestBookings.pagination.lastPage;
  //     },
  //   );
  //   isLoading.value = false;
  //   isLoadingMore.value = false;
  // }

 

  final scrollController = ScrollController();
  @override
  void onInit() async {
    super.onInit();
   
    // FirebaseMessagingService firebaseMessagingService =
    //     FirebaseMessagingService();
    // firebaseMessagingService.subscribeToMultipleTopics(idv.value, ["vendor"]);
    // currentPage.value = 1;
    // scrollController.addListener(() {
    //   if (scrollController.position.pixels >=
    //           scrollController.position.maxScrollExtent &&
    //       !isLoadingMore.value &&
    //       currentPage < lastPage) {
    //     currentPage++;
    //     getListingHomeData(loadMore: true);
     // }
   // }
    //);
  }
  

  
}


