import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class ShareController extends GetxController {
  final String postText;
  final String postImageUrl;

  ShareController({required this.postText, required this.postImageUrl});

  void shareOnFacebook() {
    Share.share(
      postText,
      subject: "Check out this post on Facebook!",
    );
  }

  void shareOnX() {
    Share.share(
      "$postText #sharedViaMyApp",
      subject: "Check out this post on X!",
    );
  }

  void shareOnInstagram() async {
    // Converti il percorso dell'immagine in un oggetto XFile
    XFile imageFile = XFile(postImageUrl);

    Share.shareXFiles(
      [imageFile], // Passa l'oggetto XFile invece della stringa
      text: postText,
    );
  }
}
