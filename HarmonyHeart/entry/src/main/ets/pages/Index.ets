import Home from './Home/Home'
import My from './My/My'
import LottiePage from './LottiePage'


@Entry
@Component
struct Index {
  @State currentIndex: number = 0

  @Builder tabBuilder(title: string, targetIndex: number, selectedImg: Resource, normalImg: Resource) {
    Column() {
      Image(this.currentIndex === targetIndex ? selectedImg : normalImg)
        .size({ width: 25, height: 25 })
      Text(title)
        .fontColor(this.currentIndex === targetIndex ? '#f1d5da' : '#9fc6ff')
    }
  }

  build() {
    Column() {
      Tabs({ barPosition: BarPosition.End }) {
        TabContent() {
          Home()
        }.tabBar(this.tabBuilder('首页', 0, $r('app.media.home_selected'), $r('app.media.home_normal')))

        TabContent() {
          // My()
          LottiePage()
        }.tabBar(this.tabBuilder('我的', 1, $r('app.media.mine_selected'), $r('app.media.mine_normal')))
      }
      .animationDuration(0)
      .backgroundColor('#F1F3F5')
      .onChange((index: number) => {
        this.currentIndex = index
      })
    }.width('100%')
  }
}