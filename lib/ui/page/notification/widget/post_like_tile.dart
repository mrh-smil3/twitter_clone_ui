import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone_ui/model/feedModel.dart';
import 'package:twitter_clone_ui/model/user.dart';
import 'package:twitter_clone_ui/state/feedState.dart';
import 'package:twitter_clone_ui/state/notificationState.dart';
import 'package:twitter_clone_ui/ui/page/feed/feedPostDetail.dart';
import 'package:twitter_clone_ui/ui/page/profile/profilePage.dart';
import 'package:twitter_clone_ui/ui/page/profile/widgets/circular_image.dart';
import 'package:twitter_clone_ui/ui/theme/theme.dart';
import 'package:twitter_clone_ui/widgets/customWidgets.dart';
import 'package:twitter_clone_ui/widgets/newWidget/title_text.dart';
import 'package:twitter_clone_ui/widgets/url_text/customUrlText.dart';

class PostLikeTile extends StatelessWidget {
  final FeedModel model;
  const PostLikeTile({Key? key, required this.model}) : super(key: key);
  Widget _userList(BuildContext context, List<String>? list) {
    int length = list?.length ?? 0;
    List<Widget> avaterList = [];
    var state = Provider.of<NotificationState>(context);
    if (list != null) {
      if (list.length > 5) {
        list = list.take(5).toList();
      }
      avaterList = list.map((userId) {
        return _userAvater(userId, state, (name) {});
      }).toList();
    }
    if (length > 5) {
      avaterList.add(
        Text(
          " +${length - 5}",
          style: TextStyles.subtitleStyle.copyWith(fontSize: 16),
        ),
      );
    }

    var col = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const SizedBox(width: 20),
            customIcon(context,
                icon: AppIcon.heartFill,
                iconColor: TwitterColor.ceriseRed,
                isTwitterIcon: true,
                size: 25),
            const SizedBox(width: 10),
            Row(children: avaterList),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 60, bottom: 5, top: 5),
          child: TitleText(
            '$length people like your Tweet',
            fontSize: 18,
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
    return col;
  }

  Widget _userAvater(
      String userId, NotificationState state, ValueChanged<String> name) {
    return FutureBuilder(
      future: state.getUserDetail(userId),
      builder: (BuildContext context, AsyncSnapshot<UserModel?> snapshot) {
        if (snapshot.hasData) {
          name(snapshot.data!.displayName!);
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    ProfilePage.getRoute(profileId: snapshot.data!.userId!));
              },
              child: CircularImage(path: snapshot.data!.profilePic, height: 30),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String description = "";
    if (model.description != null) {
      description = model.description!.length > 150
          ? model.description!.substring(0, 150) + '...'
          : model.description!;
    }
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          color: TwitterColor.white,
          child: ListTile(
            onTap: () {
              var state = Provider.of<FeedState>(context, listen: false);
              state.getPostDetailFromDatabase(null, model: model);

              Navigator.push(context, FeedPostDetail.getRoute(model.key!));
            },
            title: _userList(context, model.likeList),
            subtitle: Padding(
              padding: const EdgeInsets.only(left: 60),
              child: UrlText(
                text: description,
                style: const TextStyle(
                  color: AppColor.darkGrey,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ),
        const Divider(height: 0, thickness: .6)
      ],
    );
  }
}
