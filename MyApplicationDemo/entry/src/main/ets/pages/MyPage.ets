import router from '@ohos.router';
import PreferencesUtil from '../store/index'
@Component
export default struct MyComponent{
  private title = "第二期"
  private content = "/会议信息"

  build() {
    Column(){
      Text(this.title)
      Text(this.content)
      Button('退出登录')
        .onClick(async()=>{
          // await PreferencesUtil.deletePreferenceValue("USER","userinfo")
          router.pushUrl({
              url:"pages/LoginPage"
            })
        })
    }.padding(10)
  }
}