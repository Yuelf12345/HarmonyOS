import NavBack from '../../components/NavBack'
@Entry
@Component
struct NavigationCom {
  @State message: string = 'NavigationCom';
  pageStack: NavPathStack = new NavPathStack()
  build() {
    RelativeContainer() {
      Navigation(this.pageStack) {
        NavBack()
        Text(this.message)
          .id('NavigationComHelloWorld')
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
          .alignRules({
            center: { anchor: '__container__', align: VerticalAlign.Center },
            middle: { anchor: '__container__', align: HorizontalAlign.Center }
          })
        Button('Go To PageOne')
          .onClick(() => {
            this.pageStack.pushPath({name:'PageOne' , param: 'PageOne Param'})
          })
      }
      .title('NavIndex')
      .hideNavBar(false) // 隐藏导航栏
      .hideTitleBar(false) // 隐藏标题栏
      .hideToolBar(true) // 隐藏工具栏
    }
    .height('100%')
    .width('100%')
  }
}