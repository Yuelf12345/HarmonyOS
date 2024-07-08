import router from '@ohos.router';
import Shopping from './Shopping'

@Entry
@Component
struct ContentView {

  build() {
    Row() {
      Tabs({ barPosition: BarPosition.End }) {
        TabContent() {
          Text('首页的内容').fontSize(30)
        }
        .tabBar('首页')

        TabContent() {
          Shopping()
        }
        .tabBar('商城')

        TabContent() {
          Text('发现的内容').fontSize(30)
        }
        .tabBar('发现')

        TabContent() {
          Text('我的内容').fontSize(30)
        }
        .tabBar("我的")
      }
    }
    .height('100%')
  }
}