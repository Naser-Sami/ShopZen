import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '/core/_core.dart';
import '/config/_config.dart';
import '/features/home/_home.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const routeName = 'product-details';
  const ProductDetailsScreen({super.key, required this.product});

  final ProductEntity product;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  String selectedThumbnail = '';
  String selectedSize = 'M';
  Color selectedColor = Colors.blue;

  final List<String> sizes = ['S', 'M', 'L', 'XL', 'XXL'];
  final List<Color> colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.purple
  ];

  void onSizeSelected(String size) {
    setState(() {
      selectedSize = size;
    });
  }

  void onColorSelected(Color color) {
    setState(() {
      selectedColor = color;
    });
  }

  void onThumbnailSelected(String thumbnail) {
    setState(() {
      selectedThumbnail = thumbnail;
    });
  }

  @override
  void initState() {
    super.initState();
    selectedThumbnail = widget.product.thumbnail ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        top: false,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: false,
              floating: false,
              snap: false,
              stretch: true,
              expandedHeight: 420,
              backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.10),
              flexibleSpace: FlexibleSpaceBar(
                background: Hero(
                  tag: "Product${widget.product.id}",
                  child: Image.network(
                    selectedThumbnail,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              bottom: AppBar(
                automaticallyImplyLeading: false,
                toolbarHeight: TSize.s76,
                title: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: SizedBox(
                    height: TSize.s48,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => Container(
                        width: TSize.s48,
                        height: TSize.s48,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary.withValues(alpha: 0.10),
                          borderRadius: BorderRadius.circular(TRadius.r08),
                        ),
                        child: IconButton(
                          onPressed: () {
                            onThumbnailSelected(widget.product.images[index]);
                          },
                          icon: Image.network(
                            widget.product.images[index],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      separatorBuilder: (_, __) => TSize.s16.toWidth,
                      itemCount: widget.product.images.length,
                    ),
                  ),
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: TSize.s16),
                  child: FavoriteIconWidget(
                    product: widget.product,
                  ),
                ),
              ],
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: TPadding.p16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TSize.s16.toHeight,
                        TextWidget(
                          widget.product.title ?? "",
                          style: theme.textTheme.titleLarge,
                        ),
                        TSize.s16.toHeight,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (widget.product.price != null)
                              TextWidget(
                                "\$${(widget.product.price! * (widget.product.discountPercentage != null ? (1 - widget.product.discountPercentage! / 100) : 1)).toStringAsFixed(2)}",
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ProductReviewsRatioWidget(product: widget.product),
                          ],
                        ),
                        TSize.s16.toHeight,
                        TextWidget(
                          "Product Details",
                          style: theme.textTheme.titleMedium,
                        ),
                        SizedBox(height: TSize.s08),
                        ReadMoreText(
                          widget.product.description ?? "",
                          trimMode: TrimMode.Line,
                          trimLines: 3,
                          trimCollapsedText: ' Read more',
                          trimExpandedText: ' Show less',
                          moreStyle: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                          ),
                          lessStyle: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.error,
                          ),
                        ),
                        TSize.s16.toHeight,
                        Divider(),
                        TSize.s16.toHeight,

                        // If product has sizes
                        if (widget.product.category!.contains('shirt') ||
                            widget.product.category!.contains('tops')) ...[
                          TextWidget('Select Size', style: theme.textTheme.titleMedium),
                          TSize.s16.toHeight,
                          Wrap(
                            spacing: TSize.s16,
                            children: List.generate(
                              sizes.length,
                              (index) => GestureDetector(
                                onTap: () => onSizeSelected(sizes[index]),
                                child: Chip(
                                  label: TextWidget(
                                    sizes[index],
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: selectedSize == sizes[index]
                                          ? Colors.white
                                          : null,
                                      fontWeight: selectedSize == sizes[index]
                                          ? FontWeight.bold
                                          : null,
                                    ),
                                  ),
                                  backgroundColor: selectedSize == sizes[index]
                                      ? theme.colorScheme.primary
                                      : theme.colorScheme.primary.withValues(alpha: 0.10),
                                  side: BorderSide(
                                    color:
                                        theme.colorScheme.primary.withValues(alpha: 0.20),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          TSize.s24.toHeight,
                        ],

                        // If product has colors
                        TextWidget('Select Color', style: theme.textTheme.titleMedium),
                        TSize.s16.toHeight,
                        Wrap(
                          spacing: TSize.s08,
                          children: [
                            for (var color in colors)
                              GestureDetector(
                                onTap: () => onColorSelected(color),
                                child: Container(
                                  padding: EdgeInsets.all(1),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      width: 2,
                                      color: selectedColor == color
                                          ? theme.colorScheme.primary
                                          : Colors.transparent,
                                    ),
                                  ),
                                  child: CircleAvatar(
                                    radius: TSize.s12,
                                    backgroundColor: color,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        TSize.s24.toHeight,
                        ExpansionTile(
                          title: TextWidget('Rating & Reviews'),
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: TSize.s20)
                                  .copyWith(
                                bottom: TSize.s20,
                              ),
                              child: Row(
                                children: [
                                  TextWidget(
                                    widget.product.rating.toString(),
                                    style: theme.textTheme.titleLarge?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextWidget(
                                    '/5',
                                    style: theme.textTheme.titleLarge?.copyWith(
                                      color: theme.colorScheme.outline,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TSize.s08.toWidth,
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      TextWidget(
                                        'Overall Rating',
                                        style: theme.textTheme.titleMedium,
                                      ),
                                      TextWidget(
                                          '${widget.product.reviews.length} Ratings')
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Divider(),
                            TSize.s24.toHeight,
                            for (var review in widget.product.reviews) ...[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      RatingBar.builder(
                                        ignoreGestures: true,
                                        itemSize: 24,
                                        initialRating: review.rating?.toDouble() ?? 0,
                                        minRating: 0,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemPadding:
                                            EdgeInsets.symmetric(horizontal: 4.0),
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (rating) {},
                                      ),
                                      TSize.s16.toWidth,
                                      TextWidget(
                                        review.reviewerName?.split(' ')[0] ?? '',
                                        style: theme.textTheme.titleSmall,
                                      ),
                                    ],
                                  ),
                                  TSize.s16.toHeight,
                                  TextWidget('Sample review Title',
                                      style: theme.textTheme.titleLarge),
                                  TSize.s16.toHeight,
                                  TextWidget(
                                    review.comment ?? '',
                                    style: theme.textTheme.bodyMedium,
                                  ),
                                  TSize.s16.toHeight,
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: review.reviewerName ?? '',
                                          style: theme.textTheme.titleSmall?.copyWith(
                                            color: theme.colorScheme.outline,
                                          ),
                                        ),
                                        TextSpan(
                                          text: ', ',
                                          style: theme.textTheme.titleSmall?.copyWith(
                                            color: theme.colorScheme.outline,
                                          ),
                                        ),
                                        TextSpan(
                                          text: review.date?.formattedDateWithMonthName ??
                                              '',
                                          style: theme.textTheme.titleSmall?.copyWith(
                                            color: theme.colorScheme.outline,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  TSize.s16.toHeight,
                                  SizedBox(
                                    height: TSize.s48,
                                    child: ListView.separated(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) => Container(
                                        width: TSize.s48,
                                        height: TSize.s48,
                                        decoration: BoxDecoration(
                                          color: theme.colorScheme.primary
                                              .withValues(alpha: 0.10),
                                          borderRadius:
                                              BorderRadius.circular(TRadius.r08),
                                        ),
                                        child: IconButton(
                                          onPressed: () {
                                            onThumbnailSelected(
                                                widget.product.images[index]);
                                          },
                                          icon: Image.network(
                                            widget.product.images[index],
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      separatorBuilder: (_, __) => TSize.s16.toWidth,
                                      itemCount: widget.product.images.length,
                                    ),
                                  ),
                                  TSize.s24.toHeight,
                                ],
                              ),
                            ],
                            TSize.s24.toHeight,
                          ],
                        ),
                        Divider(),
                        TSize.s60.toHeight,
                        ElevatedButton(
                          onPressed: () {},
                          child: TextWidget('Add to Cart'),
                        ),
                        TSize.s24.toHeight,
                      ],
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
