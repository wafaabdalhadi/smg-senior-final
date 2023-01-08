import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Util/bottom_bar.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomBar(),
    );
  }
}
