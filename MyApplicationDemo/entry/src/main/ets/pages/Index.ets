
import MyComponent from './MyPage'

import http from '@ohos.net.http';



@Entry
@Component
struct TabsExample {
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

   @State userInfo:String = 'hhh';
    @State count: number = 0;
  S_login() {
    let httpRequest = http.createHttp();
    let url = "http://10.0.1.83:3000/login"     // 要使用ip地址
    console.info("开始请求");
    httpRequest.request(
      // 填写HTTP请求的URL地址，可以带参数也可以不带参数。URL地址需要开发者自定义。请求的参数可以在extraData中指定
      url,
      {
        method: http.RequestMethod.POST, // 可选，默认为http.RequestMethod.GET
        // 开发者根据自身业务需要添加header字段
        header: {
          'Content-Type': 'application/json'
        },
        // 当使用POST请求时此字段用于传递内容
        extraData: {
          "username": '张三',
          "password": '123456'
        },
        connectTimeout: 6000, // 可选，默认为60000ms
        readTimeout: 6000, // 可选，默认为60000ms
      }, (err, data:any) => {

      if (!err) {
        // data.result为HTTP响应内容，可根据业务需要进行解析
        if (data.responseCode == 200) {
          console.info("传递成功")
          console.info("从服务器返回接口返回数据成功，传递参数" + data.result)
        }
        console.info('Result:' + data.result);
        console.info('code:' + data.responseCode);
        // data.header为HTTP响应头，可根据业务需要进行解析
        console.info('header:' + JSON.stringify(data.header));
        console.info('cookies:' + data.cookies); // 8+
        if(data.result.code  == 200){
          this.userInfo =data.result.data
        }
        console.info('this.userInfo',this.userInfo)
      } else {
        console.info('error:' + JSON.stringify(err));
        // 当该请求使用完毕时，调用destroy方法主动销毁。
        httpRequest.destroy();
      }
    }
    );
  }


  build() {
    Column() {
      Tabs({ barPosition: BarPosition.End, controller: this.controller }) {
        TabContent() {
          Column(){
            Button(`请求次数: ${this.count} ${this.userInfo}`)
              .onClick(()=>{
                // this.S_login()
                console.info('打印日志信息');
                this.count += 1;
                // console.info("普通的信息");
                // console.debug("DEBUG级别的信息");
                // console.warn("警告的信息");
                this.userInfo = 'hello'
              })
            Text(`${this.userInfo}`)
          }.width('100%').height('100%').backgroundColor('#00CB87')
        }.tabBar(this.TabBuilder('首页', 0, $r('app.media.home_selected'), $r('app.media.home_normal')))

        TabContent() {
          Column().width('100%').height('100%').backgroundColor('#007DFF')
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