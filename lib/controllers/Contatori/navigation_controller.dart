import 'package:get/get.dart';

class NavigationController extends GetxController {
  var selectedIndex = 0.obs; // Indice corrente selezionato

  // Metodo per navigare a una pagina diversa
  void navigateToPage(int index) {
    selectedIndex.value = index;

  // Naviga alla pagina corrispondente
  switch (index) {
  case 0:
  Get.toNamed('/taps_home');
  break;
  case 1:
  Get.toNamed('/scrolling');
  break;
  case 2:
  Get.toNamed('/pod');
  break;
  }
}

}
