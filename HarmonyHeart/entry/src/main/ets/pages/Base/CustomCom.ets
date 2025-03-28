import NavBack from '../../components/NavBack'
import logger from "../../utils/print";
@Entry
@Component
struct CustomCom {
  @State message: string = 'CustomCom';
  @State textColor: Color = Color.Black;

  onPageShow() {
    this.textColor = Color.Blue;
    logger.info('CustomCom onPageShow 页面显示');
  }

  aboutToAppear() {
    logger.info('CustomCom onPageShow 创建后 build前');
  }

  onDidBuild(){
    logger.info('CustomCom onDidBuild build后');
  }

  aboutToDisappear(){
    logger.info('CustomCom aboutToDisappear 销毁');
  }

  onPageHide() {
    this.textColor = Color.Transparent;
    logger.info('CustomCom onPageHide 页面隐藏');
  }

  onBackPress() {
    this.textColor = Color.Red;
    logger.info('CustomCom onBackPress 返回时');
  }


  build() {
    RelativeContainer() {
      NavBack()
      Text(this.message)
        .fontColor(this.textColor)
        .id('CustomComHelloWorld')
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
      Child({ message: new Message('Child') })
    }
    .height('100%')
    .width('100%')
  }
}

export class Message {
  value: string | undefined;

  constructor(value: string) {
    this.value = value
  }
}

@Reusable
@Component
struct Child {
  @State message: Message = new Message('AboutToReuse');

  aboutToReuse(params: Record<string, ESObject>) {
    logger.info("Recycle Child 重新加入到节点树时")
    this.message = params.message as Message
  }
  aboutToRecycle() {
    //这里可以释放比较占内存的内容或其他非必要资源引用，避免一直占用内存，引发内存泄漏
    console.info("Recycle Child,child进入复用池中");
  }

  // onWillApplyTheme中可获取当前组件上下文的Theme对象。此处在onWillApplyTheme中将状态变量textColor、columBgColor，赋值为当前使用的Theme对象（BlueColorsTheme）中的配色。
  onWillApplyTheme(theme: Theme) {
    console.info('IndexComponent onWillApplyTheme',theme.colors.fontPrimary);
  }
  build() {
    Column() {
      Text(this.message.value)
        .fontSize(20)
    }
    .borderWidth(2)
    .height(100)
  }
}