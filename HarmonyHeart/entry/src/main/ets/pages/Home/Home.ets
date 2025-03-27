import router from '@ohos.router';
interface Page {
  name: string;
  path: string;
}
@Entry
@Component
export default struct Home {
  @State message: string = '首页';
  private pages: Page[] = [{ name: 'Home', path: '/pages/Home/Home'}]
  build() {
    RelativeContainer() {
      Text(this.message)
        .id('Home')
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
      List({ space: 20, initialIndex: 0 }) {
        ForEach(this.pages, (item: Page) => {
          ListItem() {
            Text(item.name)
              .width('100%').height(100).fontSize(16)
              .textAlign(TextAlign.Center).borderRadius(10).backgroundColor(0xFFFFFF)
          }
        }, (item: string) => item)
      }
      .listDirection(Axis.Vertical) // 排列方向
      .scrollBar(BarState.Off)
      .friction(0.6)
      .divider({ strokeWidth: 2, color: 0xFFFFFF, startMargin: 20, endMargin: 20 }) // 每行之间的分界线
      .edgeEffect(EdgeEffect.Spring) // 边缘效果设置为Spring
    }
    .height('100%')
    .width('100%')
  }
}