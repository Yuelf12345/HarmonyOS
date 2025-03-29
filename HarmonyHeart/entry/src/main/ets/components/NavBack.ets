import { router } from '@kit.ArkUI';
@Entry
@Component
export default struct NavBack {
  build() {
    Column() {
      Text('返回')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Top },
          middle: { anchor: '__container__', align: HorizontalAlign.Start }
        })
        .onClick(() => {
          router.back();
        })
    }
    .height('auto')
    .width('100%')
  }
}