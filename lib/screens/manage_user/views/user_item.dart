import 'package:book_store_manager/models/user_model.dart';
import 'package:book_store_manager/screens/user_details/user_details_page.dart';
import 'package:book_store_manager/widgets/page_route_transition.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../utils/number_utils.dart';

class UserItem extends StatelessWidget {
  final int index;
  final UserModel user;

  const UserItem({super.key, required this.index, required this.user});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          PageRouteSlideTransition(
            child: UserDetailsPage(user: user),
          ),
        );
      },
      child: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        height: 68,
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Center(
                child: Text(
                  NumberUtils.sttFormat(index),
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: Row(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(user.avatar),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            user.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            'Thành viên',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
