import 'package:book_store_manager/models/product_model.dart';
import '../bloc/manage_product_bloc.dart';
import 'package:book_store_manager/widgets/page_route_transition.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../product_detail/product_detail_page.dart';
import 'package:book_store_manager/utils/number_utils.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:gap/gap.dart';

class ProductItem extends StatelessWidget {
  final int index;
  final ProductModel productModel;

  const ProductItem({
    super.key,
    required this.index,
    required this.productModel,
  });

  static const Map<String, String> bookTypes = {
    'bt001': 'Sách giáo khoa',
    'bt002': 'Văn học',
    'bt003': 'Truyện tranh',
    'bt004': 'Trẻ em',
    'bt005': 'KH - KT',
    'bt006': 'Khác',
  };

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .push(PageRouteSlideTransition(
          child: ProductDetailPage(productId: productModel.id),
        ))
            .then(
          (value) {
            if (value == true) {
              context.read<ManageProductBloc>().add(ManageProductLoading());
            }
          },
        );
      },
      child: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        child: Row(
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
                  SizedBox(
                    height: 42,
                    width: 42,
                    child: CachedNetworkImage(
                      imageUrl: productModel.mainImage,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const Gap(4),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${productModel.title}\n",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 13),
                          ),
                          const Gap(2),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Kho: ${productModel.stock}',
                                style: TextStyle(
                                  color: Colors.redAccent[400],
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                bookTypes[productModel.type] ?? 'NullType',
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Gap(4),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
