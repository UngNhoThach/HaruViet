import 'dart:convert';
import 'package:haruviet/page/chat/models/chat_user.dart';
import 'package:haruviet/page/chat/widgets/conversation_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

List<ChatUsers> chatUsers = [
  ChatUsers(
      text: "",
      secondaryText: "",
      image: "",
      time: "17 giờ trước",
      name: 'Ung Nho Thạch',
      messageText: 'Sẽ gửi ngay',
      imageURL:
          'https://scontent.fsgn5-6.fna.fbcdn.net/v/t39.30808-6/269989686_1398481893901977_3691020222309844635_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=efb6e6&_nc_ohc=BRUBdpbZSrEAX9LRDz8&_nc_ht=scontent.fsgn5-6.fna&oh=00_AfDDW7aGFsPzeRrqFCp1dnL2D5tEHXTXA9Jig0ZSSM1QSw&oe=65E306E4'),
  ChatUsers(
      text: "",
      secondaryText: "",
      image: "",
      time: "17 giờ trước",
      name: 'Ung Nho Thạch',
      messageText: 'Sẽ gửi ngay',
      imageURL:
          'https://scontent.fsgn5-6.fna.fbcdn.net/v/t39.30808-6/269989686_1398481893901977_3691020222309844635_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=efb6e6&_nc_ohc=BRUBdpbZSrEAX9LRDz8&_nc_ht=scontent.fsgn5-6.fna&oh=00_AfDDW7aGFsPzeRrqFCp1dnL2D5tEHXTXA9Jig0ZSSM1QSw&oe=65E306E4'),
  ChatUsers(
      text: "",
      secondaryText: "",
      image: "",
      time: "17 giờ trước",
      name: 'Ung Nho Thạch',
      messageText: 'Sẽ gửi ngay',
      imageURL:
          'https://scontent.fsgn5-6.fna.fbcdn.net/v/t39.30808-6/269989686_1398481893901977_3691020222309844635_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=efb6e6&_nc_ohc=BRUBdpbZSrEAX9LRDz8&_nc_ht=scontent.fsgn5-6.fna&oh=00_AfDDW7aGFsPzeRrqFCp1dnL2D5tEHXTXA9Jig0ZSSM1QSw&oe=65E306E4'),
  ChatUsers(
      text: "",
      secondaryText: "",
      image: "",
      time: "17 giờ trước",
      name: 'Ung Nho Thạch',
      messageText: 'Sẽ gửi ngay',
      imageURL:
          'https://scontent.fsgn5-6.fna.fbcdn.net/v/t39.30808-6/269989686_1398481893901977_3691020222309844635_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=efb6e6&_nc_ohc=BRUBdpbZSrEAX9LRDz8&_nc_ht=scontent.fsgn5-6.fna&oh=00_AfDDW7aGFsPzeRrqFCp1dnL2D5tEHXTXA9Jig0ZSSM1QSw&oe=65E306E4'),
  ChatUsers(
      text: "",
      secondaryText: "",
      image: "",
      time: "17 giờ trước",
      name: 'Ung Nho Thạch',
      messageText: 'Sẽ gửi ngay',
      imageURL:
          'https://scontent.fsgn5-6.fna.fbcdn.net/v/t39.30808-6/269989686_1398481893901977_3691020222309844635_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=efb6e6&_nc_ohc=BRUBdpbZSrEAX9LRDz8&_nc_ht=scontent.fsgn5-6.fna&oh=00_AfDDW7aGFsPzeRrqFCp1dnL2D5tEHXTXA9Jig0ZSSM1QSw&oe=65E306E4'),
  ChatUsers(
      text: "",
      secondaryText: "",
      image: "",
      time: "17 giờ trước",
      name: 'Ung Nho Thạch',
      messageText: 'Sẽ gửi ngay',
      imageURL:
          'https://scontent.fsgn5-6.fna.fbcdn.net/v/t39.30808-6/269989686_1398481893901977_3691020222309844635_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=efb6e6&_nc_ohc=BRUBdpbZSrEAX9LRDz8&_nc_ht=scontent.fsgn5-6.fna&oh=00_AfDDW7aGFsPzeRrqFCp1dnL2D5tEHXTXA9Jig0ZSSM1QSw&oe=65E306E4'),
  ChatUsers(
      text: "",
      secondaryText: "",
      image: "",
      time: "17 giờ trước",
      name: 'Ung Nho Thạch',
      messageText: 'Sẽ gửi ngay',
      imageURL:
          'https://scontent.fsgn5-6.fna.fbcdn.net/v/t39.30808-6/269989686_1398481893901977_3691020222309844635_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=efb6e6&_nc_ohc=BRUBdpbZSrEAX9LRDz8&_nc_ht=scontent.fsgn5-6.fna&oh=00_AfDDW7aGFsPzeRrqFCp1dnL2D5tEHXTXA9Jig0ZSSM1QSw&oe=65E306E4'),
  ChatUsers(
      text: "",
      secondaryText: "",
      image: "",
      time: "17 giờ trước",
      name: 'Ung Nho Thạch',
      messageText: 'Sẽ gửi ngay',
      imageURL:
          'https://scontent.fsgn5-6.fna.fbcdn.net/v/t39.30808-6/269989686_1398481893901977_3691020222309844635_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=efb6e6&_nc_ohc=BRUBdpbZSrEAX9LRDz8&_nc_ht=scontent.fsgn5-6.fna&oh=00_AfDDW7aGFsPzeRrqFCp1dnL2D5tEHXTXA9Jig0ZSSM1QSw&oe=65E306E4'),
  ChatUsers(
      text: "",
      secondaryText: "",
      image: "",
      time: "17 giờ trước",
      name: 'Ung Nho Thạch',
      messageText: 'Sẽ gửi ngay',
      imageURL:
          'https://scontent.fsgn5-6.fna.fbcdn.net/v/t39.30808-6/269989686_1398481893901977_3691020222309844635_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=efb6e6&_nc_ohc=BRUBdpbZSrEAX9LRDz8&_nc_ht=scontent.fsgn5-6.fna&oh=00_AfDDW7aGFsPzeRrqFCp1dnL2D5tEHXTXA9Jig0ZSSM1QSw&oe=65E306E4'),
  ChatUsers(
      text: "",
      secondaryText: "",
      image: "",
      time: "17 giờ trước",
      name: 'Ung Nho Thạch',
      messageText: 'Sẽ gửi ngay',
      imageURL:
          'https://scontent.fsgn5-6.fna.fbcdn.net/v/t39.30808-6/269989686_1398481893901977_3691020222309844635_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=efb6e6&_nc_ohc=BRUBdpbZSrEAX9LRDz8&_nc_ht=scontent.fsgn5-6.fna&oh=00_AfDDW7aGFsPzeRrqFCp1dnL2D5tEHXTXA9Jig0ZSSM1QSw&oe=65E306E4'),
];

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  late List<dynamic> cartItems = [];
  List<int> cartItemCount = [1, 1, 1, 1];
  int totalPrice = 0;

  Future<void> fetchItems() async {
    final String response = await rootBundle.loadString('assets/products.json');
    final data = await json.decode(response);

    // cartItems = data['products'].map((data) => Product.fromJson(data)).toList();

    sumTotal();
  }

  sumTotal() {
    cartItems.forEach((item) {
      totalPrice = item.price + totalPrice;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fetchItems().whenComplete(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SafeArea(
            child: Padding(
              padding: EdgeInsets.only(left: 16, right: 16, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Tin nhắn",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    padding:
                        EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 2),
                    height: 22,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.pink[50],
                    ),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.add,
                          color: Colors.pink,
                          size: 14,
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                          "Thêm mới",
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Padding(
            padding: EdgeInsets.all(4),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Tìm kiếm ...",
                hintStyle: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey.shade600,
                  size: 18,
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
                contentPadding: EdgeInsets.all(4),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.grey.shade100)),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 12),
                itemCount: chatUsers.length,
                itemBuilder: (BuildContext context, index) {
                  return ConversationList(
                    name: chatUsers[index].name,
                    messageText: chatUsers[index].messageText,
                    imageUrl: chatUsers[index].imageURL,
                    time: chatUsers[index].time,
                    isMessageRead: (index == 0 || index == 3) ? true : false,
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(
                  color: Colors.grey,
                  thickness: 0.4,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
