import 'package:ShopApp/Lay_out/Cubit/cubit.dart';
import 'package:ShopApp/Lay_out/Cubit/states.dart';
import 'package:ShopApp/Lay_out/home_layout.dart';
import 'package:ShopApp/Shareing/Compounant/compunant.dart';
import 'package:ShopApp/models/CategoryModel.dart';
import 'package:ShopApp/models/Home_Model.dart';
import 'package:ShopApp/moduls/CategoryScreen.dart';
import 'package:ShopApp/moduls/Detiels_product.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
            condition:
            ShopCubit.get(context).homeModel != null&&
                ShopCubit.get(context).categoryModel != null,
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()),
            builder: (context) =>
                productBuilder(
                    ShopCubit.get(context).homeModel,
                    ShopCubit.get(context).categoryModel,
                    context),

        );
      },
    );
  }
}

Widget productBuilder(HomeModel? model,CategoriesModel  ? categoriesModel , context) =>
    SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'SPECIAL OFFERS',
                style: TextStyle(
                    fontWeight: FontWeight.w400, color: Colors.black54),
              ),
              SizedBox(
                height: 12,
              ),
              CarouselSlider(
                items: model?.data?.banners
                    .map(
                       (e) => Image(
                        image: NetworkImage('${e.image}'),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    )
                    .toList(),
                options: CarouselOptions(
                  height: 250,
                  autoPlay: true,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: (Duration(seconds: 1)),
                  reverse: false,
                  initialPage: 0,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal,
                  autoPlayInterval: Duration(seconds: 3),
                  viewportFraction: 1,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    'Latest Product',
                    style: TextStyle(
                        fontWeight: FontWeight.w400, color: Colors.black54),
                  ),
                  // Spacer(),
                  // MaterialButton(
                  //   onPressed: () {},
                  //   child: Text(
                  //     'View All',
                  //     style: TextStyle(
                  //         fontWeight: FontWeight.w400,
                  //         color: Colors.orangeAccent,
                  //         decoration: TextDecoration.underline),
                  //   ),
                  // ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
               Container(
                 height: 100,
                 child: ListView.separated(

                   scrollDirection: Axis.horizontal,
                     // shrinkWrap: true,
                     physics: BouncingScrollPhysics(),
                     itemBuilder: (context, index) => buildProductItem(model!.data?.products[index],categoriesModel, context),
                     separatorBuilder: (context, index) => SizedBox(
                       width: 10,
                     ),
                     itemCount: 2,

                 ),
               ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    'Categories',
                    style: TextStyle(
                        fontWeight: FontWeight.w400, color: Colors.black54),
                  ),
                  Spacer(),
                  MaterialButton(
                    onPressed: () {
                      navigateTo(context, CategoryScreen());
                    },
                    child: Text(
                      'View All',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.orangeAccent,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 70,
                child: ListView.separated(

                  scrollDirection: Axis.horizontal,
                  // shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) => buildCategoryItem(categoriesModel.data!.data[index]),
                  separatorBuilder: (context, index) => SizedBox(
                    width: 10,
                  ),
                  itemCount: categoriesModel!.data!.data.length,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Text(
                    'All Product',
                    style: TextStyle(
                        fontWeight: FontWeight.w400, color: Colors.black54),
                  ),
                  Spacer(),
                  MaterialButton(
                    onPressed: () {},
                    child: Text(
                      'View All',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.orangeAccent,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),

                    borderRadius: BorderRadius.all(Radius.circular(13)),
                    color: Colors.grey[300],
                ),
                child: GridView.count(

                  crossAxisSpacing: 2,
                  mainAxisSpacing: 1,
                  childAspectRatio: 1 / 1.58,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  children:
                  List.generate(
                    // model!.data!.products.length,
                    6,
                        (index) => InkWell(
                          child: buildGridView(model!.data!.products[index],context) ,
                         onTap: (){
                           Navigator.push(context,MaterialPageRoute(builder: (context)=>ProductDetails(
                            details: ShopCubit.get(context).productDetailsModel!.data!.data![index],)

                           )
                           );
                         },
                        ),

                  ),

                ),
              ),

            ],
          ),
        ),
      ),
    );
Widget buildProductItem(ProductsModel? model ,CategoriesModel? categoriesModel, context) => Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.orangeAccent),
        borderRadius: BorderRadius.all(Radius.circular(20)),
        image: DecorationImage(
          image: NetworkImage(
            '${model?.image}'
          ),
          fit: BoxFit.cover,
        ),
      ),
    );


Widget buildGridView(ProductsModel? model , context) => Container(
  color: Colors.white,

  child: Image(
    image: NetworkImage('${model?.image}'),
    // width: double.infinity,
    height: 30,
  ),
);

Widget buildCategoryItem(DataModel ? model) => Container(
  width: 100,
  child: Center(
    child: Text(
      textAlign: TextAlign.center,
      '${model!.name.toUpperCase()}',
      maxLines: 2,
      style: TextStyle(
        fontWeight:FontWeight.w400 ,
        color: Colors.black54,
        overflow: TextOverflow.ellipsis,



      ),
    ),
  ),
  decoration: BoxDecoration(

      borderRadius: BorderRadius.all(Radius.circular(18)),
      color: Colors.orange.withOpacity(.2)
  ),
);