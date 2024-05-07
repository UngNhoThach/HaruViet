import 'package:comment_tree/data/comment.dart';
import 'package:comment_tree/widgets/comment_tree_widget.dart';
import 'package:comment_tree/widgets/tree_theme_data.dart';
import 'package:eco_app/helper/colors.dart';
import 'package:eco_app/helper/spaces.dart';
import 'package:flutter/material.dart';

class AskQuesitonPage extends StatefulWidget {
  const AskQuesitonPage({super.key});

  @override
  _AskQuesitonPageState createState() => _AskQuesitonPageState();
}

class _AskQuesitonPageState extends State<AskQuesitonPage> {
  int? replyId;

  final FocusNode _focusNode = FocusNode();

  final List<Comment> commentList = [
    Comment(
        time: '30s giây trước',
        avatar: 'null',
        userName: 'null',
        content: 'Thực phẩm tươi lâu, làm lạnh đa chiều, tiết kiệm điện'),
    Comment(
        time: '2 phút trước',
        avatar: 'null',
        userName: 'null',
        content:
            'Không có hình ảnh nào. Thực phẩm tươi lâu, làm lạnh đa chiều, tiết kiệm điện'),
    Comment(
        time: '2 phút trước',
        avatar: 'null',
        userName: 'null',
        content: 'Thực phẩm tươi lâu, làm lạnh đa chiều, tiết kiệm điện'),
    Comment(
        time: '2 phút trước',
        avatar: 'null',
        userName: 'null',
        content: 'Thực phẩm tươi lâu, làm lạnh đa chiều, tiết kiệm điện '),
    Comment(
        time: '2 phút trước',
        avatar: 'null',
        userName: 'null',
        content: 'Thực phẩm tươi lâu, làm lạnh đa chiều, tiết kiệm điện '),
    Comment(
        time: '2 phút trước',
        avatar: 'null',
        userName: 'null',
        content: 'Thực phẩm tươi lâu, làm lạnh đa chiều, tiết kiệm điện '),
    Comment(
        time: '2 phút trước',
        avatar: 'null',
        userName: 'null',
        content: 'Thực phẩm tươi lâu, làm lạnh đa chiều, tiết kiệm điện '),
  ];
  int length = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    length = commentList.length;

    return GestureDetector(
      onTap: () {
        _focusNode.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Hỏi đáp'),
          backgroundColor: colorMain,
        ),
        body: Column(
          children: [
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  color: colorGray02,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.only(left: 16, bottom: 8, top: 8),
                    height: 46,
                    width: double.infinity,
                    child: Row(
                      children: <Widget>[
                        spaceW16,
                        Expanded(
                          child: TextField(
                            focusNode: _focusNode,
                            decoration: const InputDecoration(
                                hintText: "Đặt câu hỏi ...",
                                hintStyle: TextStyle(
                                    color: Colors.black54, fontSize: 14),
                                border: InputBorder.none),
                          ),
                        ),
                        spaceW16,
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: Colors.lightBlue,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Icon(
                              Icons.send,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                        spaceW16,
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    spaceH16,
                    ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) => index == length
                          ? space0
                          : Column(
                              children: [
                                spaceH10,
                                const Divider(
                                  thickness: 8,
                                  color: colorGray02,
                                  height: 1,
                                ),
                                spaceH16,
                              ],
                            ),
                      shrinkWrap: true,
                      itemCount: length,
                      itemBuilder: (BuildContext context, index) {
                        return _conmentItem(context, index: index);
                      },
                    ),
                    spaceH72,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _conmentItem(BuildContext context, {required index}) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: CommentTreeWidget<Comment, Comment>(
            Comment(
                time: '2 phút trước',
                avatar: 'null',
                userName: 'null',
                content: 'Rất đẹp và chất lượng '),
            index == 2 || index == 4
                ? commentList.sublist(0, 1)
                : commentList.sublist(0, 2),
            treeThemeData:
                const TreeThemeData(lineColor: colorGray03, lineWidth: 0.5),
            avatarRoot: (context, data) => const PreferredSize(
              preferredSize: Size.fromRadius(18),
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey,
                backgroundImage: AssetImage('assets/images/education.png'),
              ),
            ),
            avatarChild: (context, data) => const PreferredSize(
              preferredSize: Size.fromRadius(12),
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey,
                backgroundImage: AssetImage('assets/images/education.png'),
              ),
            ),
            contentChild: (context, data) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'NGÔ THỊ THẮM',
                          style: Theme.of(context).textTheme.caption?.copyWith(
                              fontWeight: FontWeight.w600, color: colorBlack),
                        ),
                        spaceH4,
                        Text(
                          '${data.content}',
                          style: Theme.of(context).textTheme.caption?.copyWith(
                              fontWeight: FontWeight.w300, color: colorBlack),
                        ),
                        spaceH4,
                        Text(
                          '${data.time}',
                          style: Theme.of(context).textTheme.caption?.copyWith(
                              fontWeight: FontWeight.w300, color: colorGray05),
                        ),
                      ],
                    ),
                  ),
                  DefaultTextStyle(
                    style: Theme.of(context).textTheme.caption!.copyWith(
                        color: colorGray03, fontWeight: FontWeight.bold),
                    child: const Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 8,
                          ),
                          Text('Thích'),
                          SizedBox(
                            width: 24,
                          ),
                          Text('Phản hồi'),
                        ],
                      ),
                    ),
                  )
                ],
              );
            },
            contentRoot: (context, data) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'DANG VAN THANH',
                          style: Theme.of(context).textTheme.caption!.copyWith(
                              fontWeight: FontWeight.w600, color: colorBlack),
                        ),
                        spaceH4,
                        Text(
                          '${data.content}',
                          style: Theme.of(context).textTheme.caption!.copyWith(
                              fontWeight: FontWeight.w300, color: colorBlack),
                        ),
                        spaceH4,
                        Text(
                          '${data.time}',
                          style: Theme.of(context).textTheme.caption!.copyWith(
                              fontWeight: FontWeight.w300, color: colorGray05),
                        ),

                        // colorGray05
                      ],
                    ),
                  ),
                  DefaultTextStyle(
                    style: Theme.of(context).textTheme.caption!.copyWith(
                        color: colorGray03, fontWeight: FontWeight.bold),
                    child: const Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 8,
                          ),
                          Text('Thích'),
                          SizedBox(
                            width: 24,
                          ),
                          Text('Phản hồi'),
                        ],
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
