import 'package:haruviet/helper/colors.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: colorMain,
        title: const Text(
          "Về chúng tôi",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(8),
          child: const Text(
            "Westcon-Comstor là nhà cung cấp công nghệ hàng đầu toàn cầu và chuyên gia phân phối công nghệ kinh doanh. Hoạt động tại hơn 70 quốc gia, chúng tôi mang đến giá trị và cơ hội kinh doanh bằng cách kết nối các nhà cung cấp CNTT hàng đầu thế giới với một kênh phân phối gồm các đại lý công nghệ, nhà tích hợp hệ thống và nhà cung cấp dịch vụ. Chúng tôi kết hợp hiểu biết sâu sắc về ngành, chuyên môn kỹ thuật và nhiều thập kỷ kinh nghiệm phân phối để mang lại giá trị và tăng tốc cho các nhà cung cấp của chúng tôi và hỗ trợ các đối tác thành công trong kinh doanh.",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
