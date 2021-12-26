import 'package:get/get.dart';
import 'package:talent_pro/Screen/add_product_page.dart';
import 'package:talent_pro/Screen/home_page.dart';
import 'package:talent_pro/Screen/splash.dart';


const String HOME = "/home";
const String DEMO = "/demo";
const String SPLASH_SCREEN = "/";
const String ADD_PRODUCT = "/add-product";


List<GetPage> appRoutes()=>[
  GetPage(name: SPLASH_SCREEN, page: () => Splash()),
  GetPage(name: HOME, page: () => HomePage()),
  GetPage(name: ADD_PRODUCT, page: () => AddProduct()),
];
