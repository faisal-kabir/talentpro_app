import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:talent_pro/Bloc/product_bloc.dart';
import 'package:talent_pro/Dimension/dimension.dart';
import 'package:talent_pro/Packege/Loading_Button/loading_button.dart';
import 'package:talent_pro/Route/route.dart';
import 'package:talent_pro/Theme/themes.dart';
import 'package:talent_pro/URL/app_constant.dart';
import 'package:talent_pro/URL/url.dart';
import 'package:talent_pro/Widgets/default_appbar.dart';
import 'package:talent_pro/Widgets/default_textfield.dart';
import 'package:talent_pro/Widgets/property_skeleton.dart';
import 'package:talent_pro/Widgets/circular_progress.dart';
import 'package:talent_pro/Widgets/default_dialog.dart';
import 'package:talent_pro/Widgets/grid_animation.dart';
import 'package:talent_pro/Widgets/image_placeholder.dart';
import 'package:talent_pro/Widgets/list_animation.dart';
import 'package:talent_pro/Widgets/swipe_refresh.dart';

import '../main.dart';


class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> with TickerProviderStateMixin {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc(),
      child: BlocBuilder<ProductBloc,ProductState>(
        builder: (context, state) {
          return Scaffold(
            appBar: DefaultAppbar(
              title: context.read<ProductBloc>().isUpdate ? language.Update_Property : language.Add_Property,
            ),
            body: mainView(context),
          );
        }
      ),
    );
  }

  Widget mainView(BuildContext context) {
    return Form(
      key: context.read<ProductBloc>().formKey,
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.only(left: Dimension.Padding,right: Dimension.Padding),
        children: [
          SizedBox(height: Dimension.Padding,),
          DefaultTextField(
            controller: context.read<ProductBloc>().name,
            label: language.Name
          ),
          SizedBox(height: Dimension.Padding,),
          DefaultTextField(
            controller: context.read<ProductBloc>().details,
            label: language.Details,
            maxLine: 5
          ),
          SizedBox(height: Dimension.Padding,),
          DefaultTextField(
            controller: context.read<ProductBloc>().price,
            label: language.Price,
            textInputType: TextInputType.numberWithOptions(decimal: true,),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
          ),
          SizedBox(height: Dimension.Padding,),
          Obx(() =>
              LoadingButton(
                isLoading: context.read<ProductBloc>().Loading.value,
                onPressed: () => context.read<ProductBloc>().submitProduct(),
                buttonDecoration: ButtonDecoration.Shadow,
                backgroundColor: Themes.Primary,
                child: Container(
                    margin: EdgeInsets.only(top: Dimension.Size_10,
                        bottom: Dimension.Size_10),
                    alignment: Alignment.center,
                    width: Get.width * 0.7,
                    child: Text(language.Submit.toUpperCase(),
                      style: Get.textTheme.headline1!.copyWith(
                          color: Themes.White),
                    )
                ),
              )),
        ],
      ),
    );
  }

}
