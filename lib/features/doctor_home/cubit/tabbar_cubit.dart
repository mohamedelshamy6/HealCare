import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'tabbar_state.dart';

class TabbarCubit extends Cubit<TabbarState> {
  TabbarCubit() : super(TabbarInitial());
  int selectedIndex=0;
  changeTabs(index){
    selectedIndex==index;
    emit(TabbarSuccess());
  }

}
