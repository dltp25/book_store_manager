import '../bloc/manage_product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TotalProduct extends StatelessWidget {
  const TotalProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
      child: BlocBuilder<ManageProductBloc, ManageProductState>(
        buildWhen: (previous, current) {
          return previous.showedProducts.length !=
              current.showedProducts.length;
        },
        builder: (context, state) {
          return Text(
            '${state.showedProducts.length} sản phẩm',
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          );
        },
      ),
    );
  }
}
