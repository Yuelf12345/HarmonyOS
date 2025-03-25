import Home from './Home/Home'
import My from './My/My'


@Entry
@Component
struct Index {
  @State currentIndex: number = 0

  @Builder tabBuilder(title: string, targetIndex: number) {
    Column() {
      Text(title)
        .fontColor(this.currentIndex === targetIndex ? '#1698CE' : '#6B6B6B')
    }
  }

  build() {
    Column() {
      Tabs({ barPosition: BarPosition.End }) {
        TabContent() {
          Home()
        }.tabBar(this.tabBuilder('首页', 0))

        TabContent() {
          My()
        }.tabBar(this.tabBuilder('我的', 1))
      }
      .animationDuration(0)
      .backgroundColor('#F1F3F5')
      .onChange((index: number) => {
        this.currentIndex = index
      })
    }.width('100%')
  }
}