import 'package:carousel_slider/carousel_slider.dart';
import 'package:clover/model/product_model.dart';
import 'package:clover/provider/cart_provider.dart';
import 'package:clover/provider/product_provider.dart';
import 'package:clover/shared/theme.dart';
import 'package:clover/widget/custom_button.dart';
import 'package:clover/widget/custom_recommend_tile_detail.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class DetailProduct extends StatefulWidget {
  final ProductModel product;
  const DetailProduct({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<DetailProduct> createState() => _DetailProductState();
}

int currentIndex = 0;

class _DetailProductState extends State<DetailProduct> {
  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of(context);
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    Widget header() {
      return Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
              viewportFraction: 1.0,
              onPageChanged: (index, reason) {
                setState(
                  () {
                    currentIndex = index;
                  },
                );
              },
            ),
            items: widget.product.photos!
                .map(
                  (item) => Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.transparent),
                          color: kBackgroundColor,
                          borderRadius: BorderRadius.circular(defaultRadius),
                          image: DecorationImage(
                            image: NetworkImage(widget.product.photos![0].url!),
                          ),
                        ),
                        width: double.infinity,
                        height: 300,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 34,
                          vertical: 32,
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: widget.product.photos!.map((urlOfItem) {
          //     int index = widget.product.photos!.indexOf(urlOfItem);
          //     return Container(
          //       width: 8,
          //       height: 8,
          //       margin:
          //           const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
          //       decoration: BoxDecoration(
          //         shape: BoxShape.circle,
          //         color: currentIndex == index ? kPrimaryColor : borderColor,
          //       ),
          //     );
          //   }).toList(),
          // )
        ],
      );
    }

    Widget content() {
      return Container(
        margin: EdgeInsets.symmetric(
          horizontal: defaultMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.product.name!,
                    style: greyTextStyle.copyWith(
                      fontSize: 20,
                      fontWeight: bold,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    cartProvider.addCart(widget.product);
                    Get.snackbar(
                      'Selamat',
                      'Produk berhasil ditambahkan',
                      icon: const Icon(
                        Icons.done,
                      ),
                      duration: const Duration(seconds: 1),
                    );
                  },
                  icon: Icon(
                    Icons.add_shopping_cart,
                    size: 30,
                    color: kPrimaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Image.asset(
                  'assets/icon_star_yellow.png',
                  width: 16,
                ),
                Image.asset(
                  'assets/icon_star_yellow.png',
                  width: 16,
                ),
                Image.asset(
                  'assets/icon_star_yellow.png',
                  width: 16,
                ),
                Image.asset(
                  'assets/icon_star_yellow.png',
                  width: 16,
                ),
                Image.asset(
                  'assets/icon_star.png',
                  width: 16,
                ),
              ],
            ),
            const SizedBox(height: 15),
            Text(
              NumberFormat.currency(
                locale: 'id',
                decimalDigits: 0,
                symbol: 'Rp ',
              ).format(widget.product.price),
              style: greyTextStyle.copyWith(
                fontSize: 18,
                fontWeight: bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Deskripsi produk',
              style: greyTextStyle.copyWith(
                fontWeight: bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.product.description!,
            ),
          ],
        ),
      );
    }

    Widget recommendTile() {
      return Container(
        margin: EdgeInsets.symmetric(
          horizontal: defaultMargin,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Rekomendasi',
                  style: greyTextStyle.copyWith(
                    fontWeight: bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: productProvider.products
                    .map(
                      (product) => RecommendDetail(
                        product: product,
                      ),
                    )
                    .toList(),
              ),
            )
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.share,
              color: kBlackColor,
              size: 24,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
            icon: Icon(
              Icons.shopping_cart_outlined,
              color: kBlackColor,
              size: 24,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.menu_rounded,
              color: kBlackColor,
              size: 24,
            ),
          ),
        ],
        automaticallyImplyLeading: false,
        title: Text(
          'Produk',
          style: blackTextStyle.copyWith(
            fontWeight: bold,
            fontSize: 18,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.chevron_left,
            color: kBlackColor,
            size: 24,
          ),
        ),
        bottom: PreferredSize(
            child: Container(
              height: 1,
              color: borderColor,
            ),
            preferredSize: const Size.fromHeight(5)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: kBackgroundColor,
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(
          defaultMargin,
          20,
          defaultMargin,
          20,
        ),
        child: CustomeButton(
          text: 'Beli Sekarang',
          color: kPrimaryColor,
          onPressed: () async {
            cartProvider.addCart(widget.product);
            Navigator.pushNamed(context, '/cart');
          },
        ),
      ),
      body: ListView(
        children: [
          header(),
          const SizedBox(height: 30),
          content(),
          const SizedBox(height: 20),
          recommendTile(),
        ],
      ),
    );
  }
}
