class ContactGroup {
  bool expand = false;
  String groupName;
  List<ContactFriend> friendList = <ContactFriend>[];

  ContactGroup(this.groupName);
}

class ContactFriend {
  String friendName;
  String friendAvatar;

  ContactFriend(this.friendName, this.friendAvatar);
}
