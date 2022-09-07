import 'package:get/get.dart';

class QuestionnaireController extends GetxController {
  Rx<QuestionnairePage> currentPage = QuestionnairePage.consent.obs;
  var progress = 0.0.obs;
  var date = DateTime.now().obs;
  var dateOfBirth = "".obs;

  QuestionnairePage findNextPage() {
    final nextIndex =
        (currentPage.value.index + 1) % QuestionnairePage.values.length;
    return QuestionnairePage.values[nextIndex];
  }

  QuestionnairePage findPreviousPage() {
    final prefIndex =
        (currentPage.value.index - 1) % QuestionnairePage.values.length;
    return QuestionnairePage.values[prefIndex];
  }

  void nextPage() {
    currentPage.value = findNextPage();
    switch (currentPage.value) {
      case QuestionnairePage.heightWeight:
        progress.value = 0.25;
        break;
      case QuestionnairePage.timesYouEat:
        progress.value = 0.5;
        break;
      case QuestionnairePage.finish:
        progress.value = 1;
        break;
      default:
        progress.value = 0;
        break;
    }
  }

  void onButtonTapped() {
    if (currentPage.value == QuestionnairePage.finish) {
      Get.offAllNamed('/home');
    } else {
      nextPage();
    }
  }

  void onBackPressed() {
    if (currentPage.value == QuestionnairePage.consent) {
      Get.back();
    } else {
      currentPage.value = findPreviousPage();
    }
  }
}

enum QuestionnairePage { consent, bio, heightWeight, timesYouEat, finish }
