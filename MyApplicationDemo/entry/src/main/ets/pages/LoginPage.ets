// 引入router
import router from '@ohos.router';
// 引入弹窗
import prompt from '@system.prompt';

let msg: String = 'login页面传来的数据'

@Entry
@Component
struct RowPage {
  @State account: string = ''
  @State password: any = ''

  build() {
    Column({ space: 10 }) {
      Image($r('app.media.icon'))
        .width(78)
        .height(78)
        .margin({ top: 120, bottom: 20 })
      Text('登录界面')
        .fontSize(24)
        .fontWeight(FontWeight.Medium)
        .fontColor('#182431')
      Text('登录账号以使用更多服务')
        .fontSize(16)
        .fontColor('#798189')
        .margin({ top: 20, bottom: 20 })
      TextInput({ placeholder: '账号' })
        .maxLength(11)
        .type(InputType.Number)
        .onChange((value: string) => {
          this.account = value;
        })
        .backgroundColor('#F0F2F4')
        .border({ color: '#ff008aff', width: '100%' })
      TextInput({ placeholder: '密码' })
        .type(InputType.Password)
        .onChange((value: string) => {
          this.password = value;
        })
        .backgroundColor('#F0F2F4')
        .border({ color: '#ff008aff', width: '100%' })
      Row() {
        Text('短信验证码登录')
          .fontColor('#017DFF')
        Text('忘记密码')
          .fontColor('#017DFF')
      }.width('100%')
      .margin({ top: 10 })
      .justifyContent(FlexAlign.SpaceBetween)

      Button('登录')
        .onClick(() => {
          if (this.account != '' && this.password != '') {
            router.pushUrl({
              // 本人创建过的页面
              url: 'pages/ListPage',
              params: {
                src: msg,
              }
            })
          } else {
            prompt.showToast({
              message: '请输入账号密码！',
              duration: 2000,
            });

          }
        }
        )
        .width('100%')
        .margin({ top: 50, bottom: 10 })
      Text('注册账号')
        .fontColor('#017DFF')
    }.height('100%')
    .width('100%')
    .padding(10)
    .backgroundColor('#F1F3F5')
  }
}