import { router } from '@kit.ArkUI';
import logger from "../../utils/print";
interface Page {
  name: string;
  path: string;
  selected: boolean
}
@Entry
@Component
export default struct Home {
  @State message: string = '首页';
  private pages: Page[] = [{ name: 'CustomCom', path: 'pages/Base/CustomCom', selected: false}]

  handleClick(url:string) {
    try {
      logger.info(url)
      router.pushUrl({
        url
      })
    } catch (e) {
      logger.error(e)
    }
  }

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
              Flex({ direction: FlexDirection.Row, alignItems: ItemAlign.Center}){
                Checkbox()
                  .select(item.selected)
                  .selectedColor(0xed6f21)
                  .shape(CheckBoxShape.CIRCLE)
                  .onChange((value: boolean) => {
                    console.info('Checkbox1 change is' + value)
                  })
                Text(item.name)
                  .ItemStyle()
                  .onClick(() => {
                    this.handleClick(item.path)
                  })
              }
            }
          }, (item: string) => item)
        }
        .listDirection(Axis.Vertical) // 排列方向
        .scrollBar(BarState.Off)
        .friction(0.6)
        .divider({ strokeWidth: 2, color: 0xFFFFFF, startMargin: 20, endMargin: 20 }) // 每行之间的分界线
        .edgeEffect(EdgeEffect.Spring) // 边缘效果设置为Spring
        .width('100%')
    }
    .height('100%')
    .width('100%')
    .padding(20)
  }
}

@Extend(Text) function ItemStyle(){
  .width('100%')
  .height(100)
  .fontSize(16)
  .textAlign(TextAlign.Center)
  .borderRadius(10)
  .backgroundColor(0xFFFFFF)
}