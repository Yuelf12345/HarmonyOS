
import MyComponent from './MyPage'
import Message from './MessagePage'
import { request } from '../utils/request'
import PreferencesUtil from '../store/index'
import router from '@ohos.router';

import common from '@ohos.app.ability.common';

@Entry
@Component
struct TabsExample {
  context:common.UIAbilityContext = getContext(this) as common.UIAbilityContext
  @State fontColor: string = '#182431'
  @State selectedFontColor: string = '#007DFF'
  @State currentIndex: number = 0
  private controller: TabsController = new TabsController()

  @Builder TabBuilder(title: string, targetIndex: number, selectedImg: Resource, normalImg: Resource) {
    Column() {
      Image(this.currentIndex === targetIndex ? selectedImg : normalImg)
        .size({ width: 25, height: 25 })
      Text(title)
        .fontColor(this.currentIndex === targetIndex ? '#1698CE' : '#6B6B6B')
    }
    .width('100%')
    .height(50)
    .justifyContent(FlexAlign.Center)
  }

    @State userInfo:any = {
      username:''
    };
    @State count: number = 0;
    @State result:any = null;

  async aboutToAppear(){
    console.info("===页面初始化===")
    await PreferencesUtil.loadPreference(this.context,"USER")
    const res = await PreferencesUtil.getPreferenceValue("USER","userinfo","") as string
    console.info('res',res)
    if(res){
      this.userInfo = JSON.parse(res)
      console.info("userInfo",this.userInfo)
    }else{
      console.info("userInfo",this.userInfo)
      router.pushUrl({
        // 本人创建过的页面
        url: 'pages/LoginPage',
      })
    }
  }


  build() {
    Column() {
      Tabs({ barPosition: BarPosition.End, controller: this.controller }) {
        TabContent() {
          Column(){
            Button(`请求次数: ${this.count}`)
              .onClick(async()=>{
                this.count += 1;
              })
            Text(`${this.userInfo.username}`)
          }.width('100%').height('100%').backgroundColor('#00CB87')
        }.tabBar(this.TabBuilder('首页', 0, $r('app.media.home_selected'), $r('app.media.home_normal')))

        TabContent() {
          Column() {
            Message()
          }.width('100%').height('100%').backgroundColor('#007DFF')
        }.tabBar(this.TabBuilder('信息', 1, $r('app.media.message_selected'), $r('app.media.message_normal')))

        TabContent() {
          Column().width('100%').height('100%').backgroundColor('#FFBF00')
        }.tabBar(this.TabBuilder('数据', 2, $r('app.media.data_selected'), $r('app.media.data_normal')))

        TabContent() {
          Column(){
            MyComponent({
              title:"我是标题",
              content:"我是内容"
            })
          }.width('100%').height('100%').backgroundColor('#E67C92')
        }.tabBar(this.TabBuilder('我的', 3, $r('app.media.my_selected'), $r('app.media.my_normal')))
      }
      .vertical(false)
      .barMode(BarMode.Fixed)
      .barWidth(360)
      .barHeight(56)
      .animationDuration(400)
      .onChange((index: number) => {
        this.currentIndex = index
      })
      .width('100%')
      .height('100%')
      .backgroundColor('#F1F3F5')
    }.width('100%')
  }
}