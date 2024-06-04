import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

class MapWithBottomSheet extends StatefulWidget {
  final String url;

  const MapWithBottomSheet({super.key, required this.url});

  @override
  _MapWithBottomSheetState createState() => _MapWithBottomSheetState();
}

class _MapWithBottomSheetState extends State<MapWithBottomSheet> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  final MethodChannel _channel = const MethodChannel('openIntentChannel');
  File? _selectedImage;
  String? _uploadedImageUrl;

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldMessengerKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('LOCK MEMORY'),
        ),
        body: Stack(
          children: [
            WebView(
              initialUrl: widget.url,
              javascriptMode: JavascriptMode.unrestricted,
              javascriptChannels: <JavascriptChannel>{
                _toasterJavascriptChannel()
              },
              navigationDelegate: (delegate) async {
                debugPrint('[Webview] delegate : ${delegate.url}');

                if (Platform.isAndroid &&
                    delegate.url.startsWith('intent://')) {
                  await _channel.invokeMethod('intent', {'url': delegate.url});

                  return NavigationDecision.prevent;
                } else if (Platform.isIOS &&
                    delegate.url.contains('itms-apps')) {
                  await _iosNavigate(delegate.url);

                  return NavigationDecision.prevent;
                }

                return NavigationDecision.navigate;
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () {
                  _showBottomSheet(context);
                },
                child: const Text('정보 보기'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    '대구가톨릭대학교(해석이와삼따리)',
                    style: TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () => _pickImage(ImageSource.camera, setState),
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('카메라'),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => _pickImage(ImageSource.gallery, setState),
                    icon: const Icon(Icons.photo_library),
                    label: const Text('갤러리'),
                  ),
                  if (_uploadedImageUrl != null) ...[
                    const SizedBox(height: 20),
                    Image.network(
                      _uploadedImageUrl!,
                      height: 200,
                    ),
                  ],
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source, StateSetter setState) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
      await _uploadImage(setState);
    }
  }

  Future<void> _uploadImage(StateSetter setState) async {
    if (_selectedImage == null) return;

    final fileName = path.basename(_selectedImage!.path);
    final storageRef = FirebaseStorage.instance.ref().child('picc/$fileName');

    try {
      await storageRef.putFile(_selectedImage!);
      final downloadUrl = await storageRef.getDownloadURL();

      setState(() {
        _uploadedImageUrl = downloadUrl;
      });

      _scaffoldMessengerKey.currentState?.showSnackBar(
        const SnackBar(content: Text('이미지가 업로드되었습니다.')),
      );
    } catch (e) {
      _scaffoldMessengerKey.currentState?.showSnackBar(
        SnackBar(content: Text('업로드 실패: $e')),
      );
    }
  }

  JavascriptChannel _toasterJavascriptChannel() {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          _scaffoldMessengerKey.currentState
              ?.showSnackBar(SnackBar(content: Text(message.message)));
        });
  }

  Future<void> _iosNavigate(String url) async {
    if (url.contains('id304608425')) {
      if (!(await launchUrl(Uri.parse('kakaomap://open')))) {
        await launchUrl(Uri.parse('https://apps.apple.com/us/app/id304608425'));
      }
    } else {
      await launchUrl(Uri.parse(url));
    }
  }
}
