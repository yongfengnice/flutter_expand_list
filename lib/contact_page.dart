import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expand_list/contact_group.dart';

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  ScrollController _scrollController = ScrollController();
  List<ContactGroup> contactGroupList = <ContactGroup>[];

  @override
  void initState() {
    super.initState();
    ContactFriend friend = ContactFriend('张三',
        'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1607604584863&di=cd01a7187dd45e6a79e00ceba574d3e8&imgtype=0&src=http%3A%2F%2Fa2.att.hudong.com%2F12%2F87%2F01300001149956130041875096065.jpg');
    ContactFriend friend2 = ContactFriend('李四',
        'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1607603618135&di=6c286dd25cc3005737b4249f577f381b&imgtype=0&src=http%3A%2F%2Fbbs.jooyoo.net%2Fattachment%2FMon_0910%2F24_293205_2d4adfacccd3031.jpg');
    ContactGroup contactGroup = ContactGroup('分组1');
    for (var i = 0; i < 5; i++) {
      contactGroup.friendList.add(friend);
    }
    contactGroupList.add(contactGroup);
    ContactGroup contactGroup2 = ContactGroup('分组2');
    for (var i = 0; i < 10; i++) {
      contactGroup2.friendList.add(friend2);
    }
    contactGroupList.add(contactGroup2);
  }

  @override
  Widget build(BuildContext context) {
    _contactHeader() {
      return Column(
        children: [
          Container(height: 100, color: Colors.red),
          Container(height: 100, color: Colors.green),
        ],
      );
    }

    _friendHeader(ContactGroup contactGroup) {
      return GestureDetector(
        onTap: () {
          setState(() {
            contactGroup.expand = !contactGroup.expand;
          });
        },
        child: Container(
          padding: EdgeInsets.only(left: 10),
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(bottom: BorderSide(color: Colors.grey[100], width: 0.5)),
          ),
          child: Row(
            children: [
              Image.asset(contactGroup.expand ? 'assets/展开.png' : 'assets/收起.png', width: 20, height: 20),
              Text('${contactGroup.groupName}(${contactGroup.friendList.length})'),
            ],
          ),
        ),
      );
    }

    _friendBody(ContactFriend contactFriend) {
      return Container(
        padding: EdgeInsets.only(left: 16),
        height: 60,
        color: Colors.white,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CachedNetworkImage(
                imageUrl: contactFriend.friendAvatar,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 10),
            Text('${contactFriend.friendName}')
          ],
        ),
      );
    }

    _contactBody(BuildContext context, ContactGroup contactGroup) {
      return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return _friendHeader(contactGroup);
          } else {
            return _friendBody(contactGroup.friendList[index - 1]);
          }
        },
        itemCount: contactGroup.expand ? contactGroup.friendList.length + 1 : 1,
      );
    }

    return ListView.builder(
      controller: _scrollController,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return _contactHeader();
        } else {
          return _contactBody(context, contactGroupList[index - 1]);
        }
      },
      itemCount: contactGroupList.length + 1,
    );
  }
}
