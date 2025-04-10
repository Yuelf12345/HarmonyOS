@Entry
@Component
struct LoginPage {
  @State username: string = ''
  @State password: string = ''
  @State isLoading: boolean = false

  build() {
    Column() {
      // 顶部返回按钮
      Row() {
        Image($r('app.media.ic_back'))
          .width(24)
          .height(24)
          .margin({ left: 16 })
          .onClick(() => {
            // 返回上一页
          })
      }
      .width('100%')
      .height(56)
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.Start)

      // 可爱的太阳和月亮图标
      Stack() {
        Image($r('app.media.ic_sun'))
          .width(80)
          .height(80)
          .margin({ top: 20, right: 100 })
        
        Image($r('app.media.ic_moon'))
          .width(80)
          .height(80)
          .margin({ top: 20, left: 100 })
      }
      .width('100%')
      .height(200)
      .backgroundColor('#6B5ECD')
      .borderRadius({ bottomLeft: 30, bottomRight: 30 })

      // 欢迎文本
      Text('嗨~ 欢迎回来')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 40, bottom: 40 })

      // 输入框区域
      Column({ space: 20 }) {
        // 用户名输入框
        TextInput({ placeholder: '请输入用户名' })
          .backgroundColor('#F5F5F5')
          .height(50)
          .borderRadius(25)
          .padding({ left: 20, right: 20 })
          .onChange((value: string) => {
            this.username = value
          })

        // 密码输入框
        TextInput({ placeholder: '请输入密码' })
          .backgroundColor('#F5F5F5')
          .height(50)
          .borderRadius(25)
          .padding({ left: 20, right: 20 })
          .type(InputType.Password)
          .onChange((value: string) => {
            this.password = value
          })

        // 登录按钮
        Button('登录', { type: ButtonType.Capsule })
          .width('100%')
          .height(50)
          .backgroundColor('#6B5ECD')
          .fontSize(18)
          .margin({ top: 30 })
          .onClick(() => {
            this.handleLogin()
          })

        // 其他登录方式
        Row({ space: 20 }) {

        }
        .margin({ top: 50 })

        // 注册链接
        Text('还没有账号？立即注册')
          .fontSize(14)
          .fontColor('#6B5ECD')
          .margin({ top: 20 })
          .onClick(() => {
            // 跳转到注册页面
          })
      }
      .padding({ left: 20, right: 20 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }

  private handleLogin() {
    if (!this.username || !this.password) {

    }

    this.isLoading = true
    // TODO: 实现登录逻辑
    setTimeout(() => {
      this.isLoading = false
      // 登录成功后的处理
    }, 2000)
  }
} 