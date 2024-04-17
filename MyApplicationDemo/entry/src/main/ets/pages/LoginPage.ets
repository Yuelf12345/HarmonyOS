import prompt from '@system.prompt';
// 引入router
import router from '@ohos.router';
import { request } from '../utils/request'
import PreferencesUtil from '../store/index'
let msg: String = 'login页面传来的数据'

@Entry
@Component
struct RowPage {
  @State username: string = '张三'
  @State password: any = '123'

  @State userInfo:string = '用户信息';
  @State count: number = 0;
  @State result:any = null;

  async S_login(params) {
    this.result =await request('/login','POST',params)
    console.info('this.result',JSON.stringify(this.result))
    console.info('code',this.result.code == 200)
    this.userInfo = this.result.data
    if(this.result.code == 200){
      // 保存用户信息
      await  PreferencesUtil.putPreferenceValue("USER","userinfo",JSON.stringify(this.userInfo))
      router.replaceUrl({
        url: 'pages/Index',
      })
    }else{
      // 清除用户信息
      await  PreferencesUtil.deletePreferenceValue("USER","userinfo")
    }}


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
      TextInput({ placeholder: '账号' ,text:`${this.username}`})
        .onChange((value: string) => {
          this.username = value;
        })
        .backgroundColor('#F0F2F4')
        .border({ color: '#ff008aff', width: '100%' })
      TextInput({ placeholder: '密码',text:`${this.password}` })
        .maxLength(12)
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
          if (this.username != '' && this.password != '') {
            this.S_login({
              username:this.username,
              password:this.password
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