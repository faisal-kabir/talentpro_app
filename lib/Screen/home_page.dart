import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:talent_pro/Bloc/home_bloc.dart';
import 'package:talent_pro/Controller/home_controller.dart';
import 'package:talent_pro/Dimension/dimension.dart';
import 'package:talent_pro/Model/products.dart';
import 'package:talent_pro/Route/route.dart';
import 'package:talent_pro/Theme/themes.dart';
import 'package:talent_pro/URL/app_constant.dart';
import 'package:talent_pro/URL/url.dart';
import 'package:talent_pro/Widgets/dialog_button.dart';
import 'package:talent_pro/Widgets/property_skeleton.dart';
import 'package:talent_pro/Widgets/circular_progress.dart';
import 'package:talent_pro/Widgets/default_dialog.dart';
import 'package:talent_pro/Widgets/grid_animation.dart';
import 'package:talent_pro/Widgets/image_placeholder.dart';
import 'package:talent_pro/Widgets/list_animation.dart';
import 'package:talent_pro/Widgets/swipe_refresh.dart';

import '../main.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: BlocBuilder<HomeBloc,HomeState>(
        builder: (context, state) {
          Widget responseWidget= Container();
          if(state is ProductLoading){
            responseWidget = PropertySkeleton();
          } else if (state is ProductGet) {
            responseWidget = mainView(context,state);
          }
          return Scaffold(
            appBar: AppBar(
              title: Image.asset('assets/banner.png',height: Dimension.Size_40,),
              centerTitle: true,
              automaticallyImplyLeading: false,
              backgroundColor: Themes.White,
            ),
            body: SwipeRefresh(
                controller: context.read<HomeBloc>().refreshController,
                onRefresh: (){
                  context.read<HomeBloc>().getAllProduct();
                },
                children: [
                  responseWidget
                ]
            ),
            floatingActionButton: FloatingActionButton.extended(
                onPressed: () => changeData(context),
                icon: Icon(Icons.add_circle),
                label: Text(language.Add_Property,),
            ),
          );
        }
      ),
    );
  }

  Widget mainView(BuildContext context, ProductGet state) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: state.products!.data!.length,
      itemBuilder: (context,index){
        return ListAnimation(
          index: index,
          child: Card(
            margin: EdgeInsets.all(Dimension.Size_10).copyWith(bottom: 0),
            elevation: 5,
            child: ListTile(
              onTap: (){
                changeData(context,data: state.products!.data![index]);
              },
              title: RichText(
                text: TextSpan(
                  text: state.products!.data![index].name!,
                  style: Get.textTheme.headline1,
                  children: [
                    TextSpan(
                      style: Get.textTheme.bodyText1,
                      text: '  (\$${state.products!.data![index].price!})'
                    )
                  ]
                ),
              ),
              subtitle: Text(state.products!.data![index].details!,maxLines: 2,overflow: TextOverflow.ellipsis,),
              trailing: SizedBox(
                width: Get.width*0.2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(Icons.edit),
                    IconButton(
                      onPressed: () => deleteProduct(context,state.products!.data![index]),
                      icon: Icon(Icons.delete,color: Themes.Red,)
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void changeData(BuildContext context, {ProductData? data}) async {
    var backData = await Get.toNamed(ADD_PRODUCT,arguments: data);
    if(backData!=null && backData){
      context.read<HomeBloc>().getAllProduct();
    }
  }

  void deleteProduct(BuildContext context, ProductData productData) {
    Get.dialog(
      DefaultDialog(
        title: language.Warning,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(language.Are_you_sure_to_delete_this_product,style: Get.textTheme.bodyText1,),
            DialogButton(
              negativeButton: language.No,
              positiveButton: language.Yes,
              onTap: (state){
                if(state){
                  context.read<HomeBloc>().deleteProduct(productData.id.toString());
                }
                Get.back();
              }
            )
          ],
        ),
      )
    );
  }

}
