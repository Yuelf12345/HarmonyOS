import router from '@ohos.router';

@Entry
@Component
struct Index {
  @State message: string = 'Hello HarmonyOS'

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
        TextInput({
          placeholder: "Hello, Harmony",
        })
        Button(){
          Text('Next').fontSize(30).fontWeight(FontWeight.Bold)
        }.type(ButtonType.Capsule)
        .margin({ top: 20 })
        .backgroundColor('#0D9FFB')
        .width('40%')
        .height('5%')
        .onClick(() => {
          // 跳转到第二页
          router.pushUrl({ url: 'pages/Home' ,params: {info:this.message}})
        })
        Button(){
          Text('表单').fontSize(30).fontWeight(FontWeight.Bold)
        }
        .width('40%')
        .height('5%')
        .onClick(() => {
          // 跳转到第二页
          router.pushUrl({ url: 'pages/From'})
        })
        Button(){
          Text('列表').fontSize(30).fontWeight(FontWeight.Bold)
        }
        .width('40%')
        .height('5%').onClick(() => {
          // 跳转到第二页
          router.pushUrl({ url: 'pages/ListPage'})
        })
        Button(){
          Text('任务列表').fontSize(30).fontWeight(FontWeight.Bold)
        }
        .width('40%')
        .height('5%').onClick(() => {
          // 跳转到第二页
          router.pushUrl({ url: 'pages/ListPage2'})
        })
      }
      .width('100%')
    }
    .height('100%')
  }
}