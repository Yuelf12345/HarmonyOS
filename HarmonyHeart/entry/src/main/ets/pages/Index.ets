import {apiGetData} from '../api/index';

@Entry
@Component
struct Index {
  @State message: string = 'Hello World';

  build() {
    RelativeContainer() {
      Text(this.message)
        .id('HelloWorld')
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
      Button() {
        Text('点击获取数据')
          .fontSize(20)
          .onClick(async() => {
            const data:object = await apiGetData();
            console.log('data===>',JSON.stringify(data))
          })
      }
    }
    .height('100%')
    .width('100%')
  }
}