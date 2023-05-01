import 'package:flutter/material.dart';

import '../../../app_core/services/size_config.dart';
import '../../models/special_offer.dart';

class SpecialOffers extends StatefulWidget {
  const SpecialOffers({
    super.key,
  });

  @override
  State<SpecialOffers> createState() => _SpecialOffersState();
}

class _SpecialOffersState extends State<SpecialOffers> {
  late final List<SpecialOffer> specials = homeSpecialOffers;

  int selectIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(15),
        vertical: getProportionateScreenWidth(15),
      ),
      child: Stack(children: [
        Container(
          height: getProportionateScreenWidth(150),
          decoration: BoxDecoration(
            color: const Color(0xFFE7E7E7),
            borderRadius: BorderRadius.circular(20),
          ),
          child: PageView.builder(
            itemBuilder: (context, index) {
              final data = specials[index];
              return SpecialOfferWidget(context, data: data, index: index);
            },
            itemCount: specials.length,
            allowImplicitScrolling: true,
            onPageChanged: (value) {
              setState(() => selectIndex = value);
            },
          ),
        ),
        _buildPageIndicator()
      ]),
    );
  }

  Widget _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < specials.length; i++) {
      list.add(i == selectIndex ? _indicator(true) : _indicator(false));
    }
    return Container(
      height: 140,
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: list,
      ),
    );
  }

  Widget _indicator(bool isActive) {
    return SizedBox(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        height: 4.0,
        width: isActive ? 16 : 4.0,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(2)),
          color: isActive ? const Color(0XFF101010) : const Color(0xFFBDBDBD),
        ),
      ),
    );
  }
}

class SpecialOfferWidget extends StatelessWidget {
  const SpecialOfferWidget(
    this.context, {
    Key? key,
    required this.data,
    required this.index,
  }) : super(key: key);

  final SpecialOffer data;
  final BuildContext context;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.discount,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: getProportionateScreenWidth(26)),
                ),
                const SizedBox(height: 6),
                Text(
                  data.title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: getProportionateScreenWidth(16)),
                ),
                const SizedBox(height: 6),
                Text(
                  data.detail,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: getProportionateScreenWidth(12)),
                ),
              ],
            ),
          ),
        ),
        AspectRatio(
          aspectRatio: 0.7,
          child: Image.asset(
            data.icon,
          ),
        ),
      ],
    );
  }
}
