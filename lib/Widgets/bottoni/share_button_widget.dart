import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../generated/l10n.dart';
import '../../controllers/share_controller.dart';

class ShareButton extends StatelessWidget {
  final ShareController shareController;

  const ShareButton({
    Key? key,
    required this.shareController,
  }) : super(key: key);

  void _showShareOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.facebook, color: Colors.blue),
              title: Text(S.of(context).share_on_facebook),
              onTap: () {
                Navigator.pop(context);
                shareController.shareOnFacebook();
              },
            ),
            ListTile(
              leading: const Icon(Icons.share, color: Colors.black),
              title: Text(S.of(context).share_on_x),
              onTap: () {
                Navigator.pop(context);
                shareController.shareOnX();
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt, color: Colors.purple),
              title: Text(S.of(context).share_on_instagram),
              onTap: () {
                Navigator.pop(context);
                shareController.shareOnInstagram();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      ),
      onPressed: () => _showShareOptions(context),
      child: Text(
        S.of(context).share,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontFamily: 'KeplerStd',
        ),
      ),
    );
  }
}
