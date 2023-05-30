import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:subway_ody/domain/usecases/local/app/GetLocationPermissionUseCase.dart';
import 'package:subway_ody/presentation/feature/main/widget/MainAppBar.dart';
import 'package:subway_ody/presentation/feature/main/widget/content/ActiveContent.dart';
import 'package:subway_ody/presentation/feature/main/widget/content/ErrorGpsContent.dart';
import 'package:subway_ody/presentation/feature/main/widget/content/ErrorNotAvailableContent.dart';
import 'package:subway_ody/presentation/ui/colors.dart';
import 'package:subway_ody/presentation/utils/Common.dart';

enum UiState { IDLE, LOADING, GPS_DENIED, SUCCESS }

class MainScreen extends HookWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiState = useState(UiState.IDLE);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        GetIt.instance<GetLocationPermissionUseCase>().call().then((value) {
          uiState.value = value ? UiState.SUCCESS : UiState.GPS_DENIED;
        });
      });
    }, []);

    return Scaffold(
      appBar: const MainAppBar(),
      body: uiState.value == UiState.SUCCESS
          ? const ActiveContent()
          : uiState.value == UiState.GPS_DENIED
              ? const ErrorGpsContent()
              : uiState.value == UiState.LOADING
                  ? CircularProgressIndicator(color: getColorScheme(context).colorPrimary)
                  : const ErrorNotAvailableContent(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: getColorScheme(context).colorPrimary,
        onPressed: () {
          // uiState.value == UiState.SUCCESS ? ;
        },
        child: uiState.value == UiState.SUCCESS
            ? SvgPicture.asset('assets/imgs/refresh.svg')
            : const SizedBox(),
      ),
    );
  }
}
