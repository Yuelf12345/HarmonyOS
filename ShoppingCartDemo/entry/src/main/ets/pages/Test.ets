// xxx.ets
@Entry
@Component
struct ListExample {
  @State arr: number[] = []
 @State page: number = 1
  aboutToAppear(){
    this.getData(10, this.page)
  }

  getData(limit: number, page: number){
      for (let i = 0; i < limit; i++) {
        this.arr.push(page * limit + i)
      }
  }

  build() {
    Column() {
      List({ space: 20, initialIndex: 0 }) {
        ForEach(this.arr, (item) => {
          ListItem() {
            Text('' + item)
              .width('100%').height(100).fontSize(16)
              .textAlign(TextAlign.Center).borderRadius(10).backgroundColor(0xFFFFFF)
          }
        }, item => item)
      }
      .listDirection(Axis.Vertical) // 排列方向
      .divider({ strokeWidth: 2, color: 0xFFFFFF, startMargin: 20, endMargin: 20 }) // 每行之间的分界线
      .edgeEffect(EdgeEffect.Spring) // 滑动到边缘无效果
      .onScrollIndex((firstIndex: number, lastIndex: number) => {
        console.info('first' + firstIndex)
        console.info('last' + lastIndex)
      })
      .onReachEnd(() => {
        console.info('onReachEnd')
        this.page++
        this.getData(10, this.page)
      })
      .width('90%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(0xDCDCDC)
    .padding({ top: 5 })
  }
}