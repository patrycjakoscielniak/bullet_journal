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
    as _i7;
import 'package:my_bullet_journal/app/screens/planner/pages/details/cubit/event_details_cubit.dart'
    as _i10;
import 'package:my_bullet_journal/app/screens/planner/pages/edit/cubit/edit_event_cubit.dart'
    as _i9;
import 'package:my_bullet_journal/app/screens/planner/pages/planner_page/cubit/planner_cubit.dart'
    as _i11;
import 'package:my_bullet_journal/app/screens/vision_board/cubit/vision_board_cubit.dart'
    as _i12;
import 'package:my_bullet_journal/app/screens/wishlist/pages/add_item_page/cubit/add_item_cubit.dart'
    as _i8;
import 'package:my_bullet_journal/app/screens/wishlist/pages/wishlist_page/cubit/wishlist_cubit.dart'
    as _i13;
import 'package:my_bullet_journal/data/remote_data_sources/planner_remote_data_source.dart'
    as _i3;
import 'package:my_bullet_journal/domain/repositories/planner_repository.dart'
    as _i4;
import 'package:my_bullet_journal/domain/repositories/vision_board_repository.dart'
    as _i5;
import 'package:my_bullet_journal/domain/repositories/wishlist_repository.dart'
    as _i6;

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
    gh.factory<_i3.PlannerRemoteDataSource>(
        () => _i3.PlannerRemoteDataSource());
    gh.factory<_i4.PlannerRepository>(
        () => _i4.PlannerRepository(gh<_i3.PlannerRemoteDataSource>()));
    gh.factory<_i5.VisionBoardRepository>(() => _i5.VisionBoardRepository());
    gh.factory<_i6.WishlistRepository>(() => _i6.WishlistRepository());
    gh.factory<_i7.AddEventCubit>(
        () => _i7.AddEventCubit(gh<_i4.PlannerRepository>()));
    gh.factory<_i8.AddItemCubit>(
        () => _i8.AddItemCubit(gh<_i6.WishlistRepository>()));
    gh.factory<_i9.EditEventCubit>(
        () => _i9.EditEventCubit(gh<_i4.PlannerRepository>()));
    gh.factory<_i10.EventDetailsCubit>(
        () => _i10.EventDetailsCubit(gh<_i4.PlannerRepository>()));
    gh.factory<_i11.PlannerCubit>(
        () => _i11.PlannerCubit(gh<_i4.PlannerRepository>()));
    gh.factory<_i12.VisionBoardCubit>(
        () => _i12.VisionBoardCubit(gh<_i5.VisionBoardRepository>()));
    gh.factory<_i13.WishlistCubit>(
        () => _i13.WishlistCubit(gh<_i6.WishlistRepository>()));
    return this;
  }
}
