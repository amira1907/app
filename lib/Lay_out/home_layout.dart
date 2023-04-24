import 'package:ShopApp/Lay_out/Cubit/cubit.dart';
import 'package:ShopApp/Lay_out/Cubit/states.dart';
import 'package:ShopApp/Shareing/Compounant/compunant.dart';
import 'package:ShopApp/models/LoginModel.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class Home_Layout extends StatelessWidget {
  const Home_Layout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(

      listener: (context, state) {

      },
      builder: (context, state) {
        var cubit=ShopCubit.get(context);
        ShopLoginModel ?loginModel;
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.menu,
                color: Colors.black,
              ),
            ),
            title: Text(

              '${loginModel?.data?.name}',
            ),
            actions: [
              IconButton(
                  onPressed: (){},
                  icon: Icon(
                    Icons.search,
                    color: Colors.black,
                  )
              ),
            ],
            elevation: 0,
          ),
          body:ShopCubit.get(context).screens[cubit.currentIndex],
          bottomNavigationBar: Container(
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 20,
            ),
            child: GNav(
              backgroundColor: Colors.black,
              color: Colors.white,
              activeColor: Colors.orangeAccent,
              tabBackgroundColor: Colors.grey.shade800,
              gap: 8,

              onTabChange: (index) {
                cubit.changeScreen(index);
              },

              padding: EdgeInsets.all(20),

              tabs: [

                GButton(
                  icon: Icons.shopping_cart,
                  text: 'Shopping',
                ),
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.person,
                  text: 'user',
                ),
              ],
            ),
          ),
          ),
        );
      },

      );
  }
}


