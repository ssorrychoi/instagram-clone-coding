import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:insta_clone_coding/constants/common_size.dart';
import 'package:insta_clone_coding/constants/screen_size.dart';

class ProfileBody extends StatefulWidget {
  @override
  _ProfileBodyState createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  SelectedTab _selectedTab = SelectedTab.LEFT;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _userName(),
                _userBio(),
                _editProfileBtn(),
                _tabButtons(),
                _selectedIndicator(),
              ],
            ),
          ),
          SliverToBoxAdapter(
              child: GridView.count(
            // 몇 칸으로 설정 할 것인지,
            crossAxisCount: 3,

            // 각각의 아이템의 가로세로 비율
            childAspectRatio: 1,

            // GridView가 1줄일때, 그만큼만 차지해야 되는데 false로 설정하게 되면 아래로 계속 내려가면서 에러가 발생한다.
            shrinkWrap: true,

            // CustomScroll에서의 scroll과 GridView의 scroll이 겹치기 때문에, Grid에서 scroll 제스처를 무시하겠다는 의미
            physics: NeverScrollableScrollPhysics(),
            children: List.generate(
              30,
              (index) => CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: 'https://picsum.photos/id/$index/100/100'),
            ),
          )),
        ],
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
            setState(() {
              _selectedTab = SelectedTab.LEFT;
            });
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
            setState(() {
              _selectedTab = SelectedTab.RIGHT;
            });
          },
        ),
      ],
    );
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

  Widget _userName() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: common_gap),
      child: Text(
        'userName',
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
      duration: Duration(milliseconds: 300),
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
