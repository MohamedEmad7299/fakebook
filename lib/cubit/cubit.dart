
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_states.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screens = [
    // ProductsScreen(),
    // CategoriesScreen(),
    // FavoritesScreen(),
    // SettingsScreen(),
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(HomeChangeBottomNavState());
  }

  //HomeModel? homeModel;

  Map<int, bool> favourites = {};

  void getHomeData() {

    // emit(HomeLoadingState());
    //
    // DioHelper.getData(path: HOME, token: token).then(
    //   (value) {
    //     homeModel = HomeModel.fromJson(value.data);
    //     for (var element in homeModel!.data!.products!) {
    //       favourites.addAll({element.id!: element.inFavorites!});
    //     }
    //     emit(HomeSuccessState());
    //   },
    // ).catchError((error) {
    //   emit(HomeErrorState(error.toString()));
    // });
  }

  //CategoriesModel? categoriesModel;

  bool errorShown = false;

  void setErrorShown(bool value) {
    errorShown = value;
  }

  void getCategoriesData() {
    // DioHelper.getData(path: CATEGORIES).then(
    //   (value) {
    //     categoriesModel = CategoriesModel.fromJson(value.data);
    //     emit(CategoriesSuccessState());
    //   },
    // ).catchError((error) {
    //   emit(CategoriesErrorState(error.toString()));
    // });
  }

  //FavouritesModel? favouritesModel;

  void updateFavourites(int productId) {
    favourites[productId] = !favourites[productId]!;
    emit(FavoritesChangeState());

    // DioHelper.postData(
    //   path: FAVORITES,
    //   token: token,
    //   data: {
    //     'product_id': productId,
    //   },
    // ).then(
    //   (value) {
    //
    //     errorShown = false;
    //
    //     favouritesModel = FavouritesModel.fromJson(value.data);
    //
    //     if (!favouritesModel!.status!) {
    //       favourites[productId] = !favourites[productId]!; // Revert change
    //       emit(FavoritesErrorState(favouritesModel!.message!));
    //     } else {
    //       emit(FavoritesSuccessState());
    //     }
    //   },
    // ).catchError((error) {
    //   favourites[productId] = !favourites[productId]!; // Revert on error
    //   emit(FavoritesErrorState(error.toString()));
    // });
  }

  //ProfileModel? profileModel;

  void getProfileData() {
    // emit(ProfileLoadingState());
    // DioHelper.getData(path: PROFILE, token: token).then(
    //   (value) {
    //     profileModel = ProfileModel.fromJson(value.data);
    //     emit(ProfileSuccessState());
    //   },
    // ).catchError((error) {
    //   emit(ProfileErrorState(error.toString()));
    // });
  }

  //UpdateProfileModel? updateProfileModel;

  var infoError = false;

  void updateProfileData({
    required String name,
    required String email,
    required String phone
  }) {

    emit(UpdateProfileLoadingState());

    // DioHelper.putData(
    //   path: UPDATE_PROFILE,
    //   token: token,
    //   data: {
    //     "name": name,
    //     "phone": phone,
    //     "email": email
    //   },
    //   lang: 'en',
    // ).then(
    //   (value) {
    //     updateProfileModel = UpdateProfileModel.fromJson(value.data);
    //     emit(FavoritesSuccessState());
    //   },
    // ).catchError((error) {
    //   emit(ProfileErrorState(error.toString()));
    //   print("THE ERROR --------------------------> $error");
    // });
  }
}
