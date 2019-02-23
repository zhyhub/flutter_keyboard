# PlateNumberKeyboard

## 目前是测试版，需要用到 showBottomSheet() 来实现键盘的弹出，还存在一些bug，接下来修复bug，然后通过动画来实现弹出。

## 优化PlateNumberKeyboard内部结构，方便调用。

## Use

### showBottomSheet(
### context: context,
### builder: (_) {
### return PlateNumberKeyboard(
### backResult: (val) => onDataChange(val),
### results: resultList,); });