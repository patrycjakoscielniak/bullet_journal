// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:my_bullet_journal/app/screens/planner/pages/add/cubit/add_event_cubit.dart'
    as _i6;
import 'package:my_bullet_journal/app/screens/planner/pages/details/cubit/event_details_cubit.dart'
    as _i9;
import 'package:my_bullet_journal/app/screens/planner/pages/edit/cubit/edit_event_cubit.dart'
    as _i8;
import 'package:my_bullet_journal/app/screens/planner/pages/planner_page/cubit/planner_cubit.dart'
    as _i10;
import 'package:my_bullet_journal/app/screens/vision_board/cubit/vision_board_cubit.dart'
    as _i11;
import 'package:my_bullet_journal/app/screens/wishlist/pages/add_item_page/cubit/add_item_cubit.dart'
    as _i7;
import 'package:my_bullet_journal/app/screens/wishlist/pages/wishlist_page/cubit/wishlist_cubit.dart'
    as _i12;
import 'package:my_bullet_journal/domain/repositories/planner_repository.dart'
    as _i3;
import 'package:my_bullet_journal/domain/repositories/vision_board_repository.dart'
    as _i4;
import 'package:my_bullet_journal/domain/repositories/wishlist_repository.dart'
    as _i5;

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i3.PlannerRepository>(() => _i3.PlannerRepository());
    gh.factory<_i4.VisionBoardRepository>(() => _i4.VisionBoardRepository());
    gh.factory<_i5.WishlistRepository>(() => _i5.WishlistRepository());
    gh.factory<_i6.AddEventCubit>(
        () => _i6.AddEventCubit(gh<_i3.PlannerRepository>()));
    gh.factory<_i7.AddItemCubit>(
        () => _i7.AddItemCubit(gh<_i5.WishlistRepository>()));
    gh.factory<_i8.EditEventCubit>(
        () => _i8.EditEventCubit(gh<_i3.PlannerRepository>()));
    gh.factory<_i9.EventDetailsCubit>(
        () => _i9.EventDetailsCubit(gh<_i3.PlannerRepository>()));
    gh.factory<_i10.PlannerCubit>(
        () => _i10.PlannerCubit(gh<_i3.PlannerRepository>()));
    gh.factory<_i11.VisionBoardCubit>(
        () => _i11.VisionBoardCubit(gh<_i4.VisionBoardRepository>()));
    gh.factory<_i12.WishlistCubit>(
        () => _i12.WishlistCubit(gh<_i5.WishlistRepository>()));
    return this;
  }
}
