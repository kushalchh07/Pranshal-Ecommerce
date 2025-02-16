import 'dart:convert';

class HomeModel {
  final bool status;
  final List<Category> categories;
  final List<Brand> brands;
  final List<Product> products;
  final List<FlashSaleProduct> flashSaleProducts;
  final List<Product> recommendedProducts;

  HomeModel({
    required this.status,
    required this.categories,
    required this.brands,
    required this.products,
    required this.flashSaleProducts,
    required this.recommendedProducts,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      status: json['status'],
      categories: (json['categories'] as List)
          .map((e) => Category.fromJson(e))
          .toList(),
      brands: (json['brands'] as List).map((e) => Brand.fromJson(e)).toList(),
      products:
          (json['products'] as List).map((e) => Product.fromJson(e)).toList(),
      flashSaleProducts: (json['flashSaleProducts'] as List)
          .map((e) => FlashSaleProduct.fromJson(e))
          .toList(),
          recommendedProducts:  (json['recommendedProducts'] as List)
          .map((e) => Product.fromJson(e))
          .toList()
    );
  }
}

// Category Model
class Category {
  final int categoryId;
  final String categoryName;
  final String categoryDescription;
  final String categoryThumbnail;

  Category({
    required this.categoryId,
    required this.categoryName,
    required this.categoryDescription,
    required this.categoryThumbnail,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      categoryId: json['category_id'],
      categoryName: json['category_name'],
      categoryDescription: json['category_description'],
      categoryThumbnail: json['category_thumbnail'],
    );
  }
}

// Brand Model
class Brand {
  final int brandId;
  final String brandName;
  final String brandThumbnail;
  final String brandDescription;

  Brand({
    required this.brandId,
    required this.brandName,
    required this.brandThumbnail,
    required this.brandDescription,
  });

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      brandId: json['brand_id'],
      brandName: json['brand_name'],
      brandThumbnail: json['brand_thumbnail'],
      brandDescription: json['brand_description'],
    );
  }
}

// Product Model
class Product {
  final int productId;
  final int categoryId;
  final int brandId;
  final String productName;
  final String categoryName;
  final String brandName;
  final String productDescription;
  final String productThumbnail;
  final double normalPrice;
  final double sellPrice;
  final int totalProductCount;

  Product({
    required this.productId,
    required this.categoryId,
    required this.brandId,
    required this.productName,
    required this.categoryName,
    required this.brandName,
    required this.productDescription,
    required this.productThumbnail,
    required this.normalPrice,
    required this.sellPrice,
    required this.totalProductCount,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['product_id'],
      categoryId: json['category_id'],
      brandId: json['brand_id'],
      productName: json['product_name'],
      categoryName: json['category_name'],
      brandName: json['brand_name'],
      productDescription: json['product_description'],
      productThumbnail: json['product_thumbnail'],
      normalPrice: json['normal_price'].toDouble(),
      sellPrice: json['sell_price'].toDouble(),
      totalProductCount: json['total_product_count'],
    );
  }
}

// Flash Sale Product Model
class FlashSaleProduct {
  final int productId;
  final int categoryId;
  final int brandId;
  final String productName;
  final String categoryName;
  final String brandName;
  final String productDescription;
  final String productThumbnail;
  final double normalPrice;
  final double sellPrice;
  final int totalProductCount;

  FlashSaleProduct({
    required this.productId,
    required this.categoryId,
    required this.brandId,
    required this.productName,
    required this.categoryName,
    required this.brandName,
    required this.productDescription,
    required this.productThumbnail,
    required this.normalPrice,
    required this.sellPrice,
    required this.totalProductCount,
  });

  factory FlashSaleProduct.fromJson(Map<String, dynamic> json) {
    return FlashSaleProduct(
      productId: json['product_id'],
      categoryId: json['category_id'],
      brandId: json['brand_id'],
      productName: json['product_name'],
      categoryName: json['category_name'],
      brandName: json['brand_name'],
      productDescription: json['product_description'],
      productThumbnail: json['product_thumbnail'],
      normalPrice: json['normal_price'].toDouble(),
      sellPrice: json['sell_price'].toDouble(),
      totalProductCount: json['total_product_count'],
    );
  }
}
