import 'package:go_router/go_router.dart';

import '../main.dart';
import 'features/authentication/presentation/auth_checker.dart';
import 'features/authentication/presentation/login_screen.dart';
import 'features/authentication/presentation/registration_screen.dart';
import 'features/products/model/product.dart';
import 'features/products/presentation/product_detail_screen.dart';
import 'features/products/presentation/product_list_screen.dart';
import 'features/profile/presentation/profile_screen.dart';

final router = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => AuthChecker(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => RegistrationScreen(),
    ),
    GoRoute(
      path: '/products',
      builder: (context, state) => ProductListScreen(),
    ),
    GoRoute(
      path: '/product-detail/:id',
      builder: (context, state) {
        final product = state.extra as Product;
        return ProductDetailScreen(product: product);
      },
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => ProfileScreen(),
    ),
  ],
);
