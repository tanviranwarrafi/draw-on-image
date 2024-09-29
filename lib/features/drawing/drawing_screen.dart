import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tutorial/components/buttons/elevate_button.dart';
import 'package:tutorial/components/loaders/circle_loader.dart';
import 'package:tutorial/features/drawing/components/camera_view.dart';
import 'package:tutorial/features/drawing/components/draw_over_image.dart';
import 'package:tutorial/features/drawing/drawing_view_model.dart';
import 'package:tutorial/themes/colors.dart';
import 'package:tutorial/utils/assets.dart';
import 'package:tutorial/utils/dimensions.dart';
import 'package:tutorial/utils/size_config.dart';
import 'package:tutorial/widgets/core/pop_scope_navigator.dart';
import 'package:tutorial/widgets/library/svg_image.dart';
import 'package:tutorial/widgets/ui/circle_icon_box.dart';

class DrawingScreen extends StatefulWidget {
  @override
  State<DrawingScreen> createState() => _DrawingScreenState();
}

class _DrawingScreenState extends State<DrawingScreen> {
  var _viewModel = DrawingViewModel();
  var _modelData = DrawingViewModel();
  var _drawKey = GlobalKey<DrawingRoomState>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => _viewModel.initViewModel());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _viewModel = Provider.of<DrawingViewModel>(context, listen: false);
    _modelData = Provider.of<DrawingViewModel>(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _viewModel.disposeViewModel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var isInitialized = _modelData.cameraController != null && _modelData.cameraController!.value.isInitialized;
    var loader = _modelData.loader || !isInitialized;
    var background = white.withOpacity(0.15);
    return PopScopeNavigator(
      canPop: false,
      child: Scaffold(
        backgroundColor: background,
        appBar: AppBar(
          title: const Text('Define depth or surface', style: TextStyle(color: offWhite4)),
          backgroundColor: transparent,
          leadingWidth: Dimensions.leading_width,
          automaticallyImplyLeading: false,
        ),
        bottomNavigationBar: _modelData.loader || !isInitialized ? null : _bottomNavbar(context),
        body: Container(
          color: transparent,
          width: SizeConfig.width,
          height: SizeConfig.height,
          padding: loader ? null : EdgeInsets.symmetric(horizontal: Dimensions.screen_padding),
          child: loader ? CircleLoader() : _screenView(context),
        ),
      ),
    );
  }

  Widget _screenView(BuildContext context) {
    var controller = _modelData.cameraController;
    var isInitialized = controller != null && controller.value.isInitialized;
    if (!isInitialized) return const SizedBox.shrink();
    return Column(
      children: [
        const SizedBox(height: 10),
        Expanded(
          child: _modelData.image == null
              ? CameraView(controller: controller)
              : DrawingRoom(image: _modelData.image!, isPencil: _modelData.isPencil, onUpdate: _viewModel.onDrawing, key: _drawKey),
        ),
        if (_modelData.image != null) const SizedBox(height: 10),
        if (_modelData.image != null) Row(mainAxisAlignment: MainAxisAlignment.center, children: _imageActionList),
        const SizedBox(height: 20),
      ],
    );
  }

  List<Widget> get _imageActionList {
    var isPencil = _modelData.isPencil;
    return [
      ElevateButton(
        height: 38,
        width: 100,
        label: 'Pencil',
        icon: Assets.svg.pencil,
        color: isPencil ? dark : offWhite4,
        background: isPencil ? white : grey2,
        onTap: () => setState(() => _modelData.isPencil = !_modelData.isPencil),
      ),
      const SizedBox(width: 12),
      ElevateButton(
        height: 38,
        width: 100,
        label: 'Crop',
        color: offWhite4,
        background: grey2,
        icon: Assets.svg.crop,
        onTap: _viewModel.onCropImage,
      ),
    ];
  }

  Widget _bottomNavbar(BuildContext context) {
    var color = const Color(0xFF202231).withOpacity(0.8);
    var bottom = SizeConfig.bottomNotch ? 24.0 : 20.0;
    var center = MainAxisAlignment.center;
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: bottom),
      decoration: BoxDecoration(color: _modelData.image == null ? color : white, borderRadius: SHEET_RADIUS),
      child: Row(mainAxisAlignment: center, children: _modelData.image == null ? _cameraActionList : _decisionActionList),
    );
  }

  List<Widget> get _cameraActionList {
    var isFlash = _modelData.isFlashOn;
    return [
      CircleIconBox(
        size: 48,
        background: white.withOpacity(0.1),
        onTap: _viewModel.imageFromGallery,
        icon: SvgImage(image: Assets.svg.image_square, height: 24, color: white.withOpacity(0.7)),
      ),
      const SizedBox(width: 24),
      Expanded(
        child: ElevateButton(
          radius: 40,
          background: white,
          color: primary,
          icon: Assets.svg.camera,
          label: 'Capture',
          onTap: _viewModel.capturePhoto,
        ),
      ),
      const SizedBox(width: 24),
      CircleIconBox(
        size: 48,
        background: white.withOpacity(0.1),
        onTap: _viewModel.flashActions,
        icon: SvgImage(image: isFlash ? Assets.svg.lightning_2 : Assets.svg.lightning_1, height: 24, color: white.withOpacity(0.7)),
      ),
    ];
  }

  List<Widget> get _decisionActionList {
    return [
      CircleIconBox(
        size: 48,
        background: offWhite2,
        onTap: _onCancel,
        icon: SvgImage(image: Assets.svg.close, height: 24, color: grey2),
      ),
      const SizedBox(width: 24),
      CircleIconBox(
        size: 48,
        background: primary,
        icon: SvgImage(image: Assets.svg.check, height: 24, color: white),
        onTap: _viewModel.onConfirm,
      ),
    ];
  }

  void _onCancel() {
    _drawKey.currentState?.onClear();
    _viewModel.onCancelImage();
  }
}
