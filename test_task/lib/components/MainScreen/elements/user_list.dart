import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:test_task/components/MainScreen/elements/MainScreen_buttons.dart';
import 'package:test_task/services/user/cubit/user_cubit.dart';
import 'package:test_task/services/user/cubit/user_state.dart';
import 'package:test_task/services/user/models/user.dart';
import 'package:test_task/theme/ColorPalette.dart';

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  late ScrollController _scrollController;

  bool _isScrolled = false;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_listenToScrollChange);
    super.initState();
  }

  //Метод меняет флаг
  void _listenToScrollChange() {
    if (_scrollController.offset >= 40.0) {
      setState(() {
        _isScrolled = true;
      });
    } else {
      setState(() {
        _isScrolled = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is UserLoadingState) {
          UserCubit userCubit = context.read<UserCubit>();
          userCubit.fetchUsers();
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is UserLoadedState) {
          List<User> userList = state.loadedUser;
          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.white,
                centerTitle: true,
                pinned: true,
                expandedHeight: 110,
                title: AnimatedOpacity(
                  duration: Duration(milliseconds: 300),
                  opacity: _isScrolled ? 1.0 : 0.0,
                  child: const Text(
                    'Пользователи',
                    style: TextStyle(color: colorBlack),
                  ),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  background: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 16, bottom: 14),
                        child: const Text(
                          'Пользователи',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 28,
                              color: colorBlack,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: userList.map((user) {
                    return Container(
                      color: colorWhite,
                      height: 80.0,
                      child: ListTile(
                        leading: Image.asset(
                          "assets/icons/bx_user_circle.png",
                          fit: BoxFit.fill,
                          height: 50,
                          alignment: Alignment.topCenter,
                        ),
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '${user.name}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20.0),
                            ),
                            Text(
                              'Email: ${user.email}',
                              style: TextStyle(fontSize: 13.0),
                            ),
                            Text(
                              '${user.company.name}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 13.0),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          );
        }

        if (state is UserErrorState) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/icons/warning-sign.png",
                  fit: BoxFit.cover,
                  height: 76.0,
                ),
                const SizedBox(height: 36),
                const Text(
                  'Не удалось загрузить информацию',
                  style: TextStyle(fontSize: 20.0),
                ),
                const SizedBox(height: 32),
                ActionButtons(),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}
