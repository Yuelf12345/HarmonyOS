import NavBack from '../../components/NavBack'
@Entry
@Component
struct CustomCom {
  @State message: string = 'Hello World';

  build() {
    RelativeContainer() {
      NavBack()
      Text(this.message)
        .id('CustomComHelloWorld')
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
    }
    .height('100%')
    .width('100%')
  }
}