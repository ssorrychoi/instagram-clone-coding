import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone_coding/constants/common_size.dart';
import 'package:insta_clone_coding/constants/screen_size.dart';
import 'package:insta_clone_coding/model/user_model_state.dart';
import 'package:insta_clone_coding/screens/profile_screen.dart';
import 'package:insta_clone_coding/widgets/rounded_avatar.dart';
import 'package:provider/provider.dart';

class ProfileBody extends StatefulWidget {
  final Function() onMenuChanged;

  ProfileBody({Key key, this.onMenuChanged}) : super(key: key);

  @override
  _ProfileBodyState createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody>
    with SingleTickerProviderStateMixin {
  SelectedTab _selectedTab = SelectedTab.LEFT;
  double _leftImagesPageMargin = 0;
  double _rightImagesPageMargin = size.width;
  AnimationController _iconAnimationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _iconAnimationController =
        new AnimationController(vsync: this, duration: duration);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _iconAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _appbar(),
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(common_gap),
                            child: RoundedAvatar(
                              size: 80,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: common_gap),
                              child: Table(
                                children: [
                                  TableRow(
                                    children: [
                                      _valueText('1231233'),
                                      _valueText('1231233'),
                                      _valueText('1231233'),
                                    ],
                                  ),
                                  TableRow(
                                    children: [
                                      _labelText('Post'),
                                      _labelText('Followers'),
                                      _labelText('Following'),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      _userName(context),
                      _userBio(),
                      _editProfileBtn(),
                      _tabButtons(),
                      _selectedIndicator(),
                    ],
                  ),
                ),
                _imagesPager(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row _appbar() {
    return Row(
      children: [
        SizedBox(
          width: 44,
        ),
        Expanded(
            child: Text(
          'ssorrychoi',
          textAlign: TextAlign.center,
        )),
        IconButton(
          icon: AnimatedIcon(
            icon: AnimatedIcons.menu_close,
            progress: _iconAnimationController,
          ),
          onPressed: () {
            widget.onMenuChanged();
            _iconAnimationController.status == AnimationStatus.completed
                ? _iconAnimationController.reverse()
                : _iconAnimationController.forward();
          },
        )
      ],
    );
  }

  Text _labelText(String value) => Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.w300, fontSize: 11),
      );

  Text _valueText(String value) {
    return Text(
      value,
      style: TextStyle(fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    );
  }

  SliverToBoxAdapter _imagesPager() {
    return SliverToBoxAdapter(
      child: Stack(
        children: [
          AnimatedContainer(
            duration: duration,
            transform: Matrix4.translationValues(_leftImagesPageMargin, 0, 0),
            curve: Curves.fastOutSlowIn,
            child: _images(),
          ),
          AnimatedContainer(
            duration: duration,
            transform: Matrix4.translationValues(_rightImagesPageMargin, 0, 0),
            curve: Curves.fastOutSlowIn,
            child: _images(),
          ),
        ],
      ),
    );
  }

  GridView _images() {
    return GridView.count(
      // ??? ????????? ?????? ??? ?????????,
      crossAxisCount: 3,

      // ????????? ???????????? ???????????? ??????
      childAspectRatio: 1,

      // GridView??? 1?????????, ???????????? ???????????? ????????? false??? ???????????? ?????? ????????? ?????? ??????????????? ????????? ????????????.
      shrinkWrap: true,

      // CustomScroll????????? scroll??? GridView??? scroll??? ????????? ?????????, Grid?????? scroll ???????????? ?????????????????? ??????
      physics: NeverScrollableScrollPhysics(),
      children: List.generate(
        30,
        (index) => CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: 'https://picsum.photos/id/$index/100/100'),
      ),
    );
  }

  Row _tabButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          icon: ImageIcon(
            AssetImage('assets/images/grid.png'),
            color: _selectedTab == SelectedTab.LEFT
                ? Colors.black
                : Colors.black26,
          ),
          onPressed: () {
            _tabSelected(SelectedTab.LEFT);
          },
        ),
        IconButton(
          icon: ImageIcon(
            AssetImage('assets/images/saved.png'),
            color: _selectedTab == SelectedTab.LEFT
                ? Colors.black26
                : Colors.black,
          ),
          onPressed: () {
            _tabSelected(SelectedTab.RIGHT);
          },
        ),
      ],
    );
  }

  _tabSelected(SelectedTab selectedTab) {
    setState(() {
      switch (selectedTab) {
        case SelectedTab.LEFT:
          _selectedTab = SelectedTab.LEFT;
          _leftImagesPageMargin = 0;
          _rightImagesPageMargin = size.width;
          break;
        case SelectedTab.RIGHT:
          _selectedTab = SelectedTab.RIGHT;
          _leftImagesPageMargin = -size.width;
          _rightImagesPageMargin = 0;
          break;
      }
    });
  }

  Padding _editProfileBtn() {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: common_gap, vertical: common_xxs_gap),
      child: SizedBox(
        height: 24,
        child: OutlineButton(
          onPressed: () {},
          borderSide: BorderSide(color: Colors.black45),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            'Edit Profile',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _userName(BuildContext context) {
    UserModelState userModelState = Provider.of<UserModelState>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: common_gap),
      child: Text(
        userModelState?.userModel == null
            ? "EMPTY"
            : Provider.of<UserModelState>(context).userModel.userName,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _userBio() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: common_gap),
      child: Text(
        'This is my userName!',
        style: TextStyle(fontWeight: FontWeight.w400),
      ),
    );
  }

  Widget _selectedIndicator() {
    return AnimatedContainer(
      duration: duration,
      alignment: _selectedTab == SelectedTab.LEFT
          ? Alignment.centerLeft
          : Alignment.centerRight,
      child: Container(
        height: 3,
        width: size.width / 2,
        color: Colors.black87,
      ),
      curve: Curves.easeInOut,
    );
  }
}

enum SelectedTab { LEFT, RIGHT }
