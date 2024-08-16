import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Open all and close browser",
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final TextEditingController urlController = TextEditingController();

  Future<void> openAllBrowsers(String url) async {
    try {
      final response = await http.post(
        Uri.parse('https://localhost:7171/api/Browser/open-all?url=$url'),
      );
      if (response.statusCode == 200) {
        print('Tất cả trình duyệt đã được mở với URL: $url');
      } else {
        print('Lỗi khi mở trình duyệt: ${response.body}');
      }
    } catch (e) {
      print('Lỗi: $e');
    }
  }

  Future<void> closeAllBrowsers() async {
    try {
      final response = await http
          .post(Uri.parse('https://localhost:7171/api/Browser/close'));
      if (response.statusCode == 200) {
        print('Tất cả trình duyệt đã được đóng.');
      } else {
        print('Lỗi khi đóng trình duyệt: ${response.body}');
      }
    } catch (e) {
      print('Lỗi: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Điều khiển trình duyệt',
          style: TextStyle(color: Colors.amber),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: urlController,
                decoration: InputDecoration(
                  labelText: 'Nhập URL',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                String url = urlController.text.trim();
                if (url.isNotEmpty) {
                  openAllBrowsers(url);
                } else {
                  print('Vui lòng nhập URL hợp lệ.');
                }
              },
              child: Text('Mở Tất Cả Trình Duyệt'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: closeAllBrowsers,
              child: Text('Đóng Tất Cả Trình Duyệt'),
            ),
          ],
        ),
      ),
    );
  }
}
