import router from '@ohos.router'
const params = router.getParams();
@Entry
@Component
struct Second {


  build() {
    Row() {
      Column() {
        Text(params['info'])
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
        Button() {
          Text('Back')
            .fontSize(25)
            .fontWeight(FontWeight.Bold)
        }
        .type(ButtonType.Capsule)
        .margin({
          top: 20
        })
        .backgroundColor('#0D9FFB')
        .width('40%')
        .height('5%')
        .onClick(() => {
          router.back()  // 返回到第一页
        })
      }
      .width('100%')
    }
    .height('100%')
  }
}
