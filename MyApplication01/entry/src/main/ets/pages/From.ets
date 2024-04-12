import router from '@ohos.router'
@Entry
@Component
struct From {
  @State title: string = '表单组件'
  @State progressValue: number = 0
  @State handlePopup: boolean = false

  dialogController: CustomDialogController = new CustomDialogController({
    builder: CustomDialogExample({
      cancel: this.onCancel,
      confirm: this.onAccept,
    }),
    alignment: DialogAlignment.Default,  // 可设置dialog的对齐方式，设定显示在底部或中间等，默认为底部显示
  })
  onCancel() {
    console.info('Callback when the first button is clicked')
  }
  onAccept() {
    console.info('Callback when the second button is clicked')
  }

  build() {
    Row() {
      Column() {
        Text(this.title)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
        Button('回退', { type: ButtonType.Normal, stateEffect: true })
          .borderRadius(8)
          .backgroundColor(0x317aff)
          .width(90)
          .height(40)
          .onClick(()=>
            router.back()
          )
        Row(){
          Radio({ value: 'Radio1', group: 'radioGroup' })
            .checked(false)
            .onChange((isChecked: boolean) => {
              console.log('isChecked',isChecked)
            })
          Radio({ value: 'Radio2', group: 'radioGroup' })
            .checked(true)
        }
        Row(){
          Toggle({ type: ToggleType.Checkbox, isOn: false })
          Toggle({ type: ToggleType.Checkbox, isOn: true })
        }
        Row(){
          Toggle({ type: ToggleType.Switch, isOn: false })
          Toggle({ type: ToggleType.Switch, isOn: true })
        }
        Row(){
          Progress({ value: 20, total: 100, type: ProgressType.Linear }).width(200).height(50)
            .style({strokeWidth:50}).value(this.progressValue)
          Button(`${this.progressValue < 100 ?'+10':'重置'}`, { type: ButtonType.Circle, stateEffect: false })
            .backgroundColor(0x317aff)
            .width(20)
            .height(20)
            .onClick(()=>{
              this.progressValue += 10
              if(this.progressValue >100){
                this.progressValue = 0
              }
            })
        }
        Text() {
          Span('我是Span1，').fontSize(16).fontColor(Color.Grey)
            .decoration({ type: TextDecorationType.LineThrough, color: Color.Red })
          Span('我是Span2').fontColor(Color.Blue).fontSize(16)
            .fontStyle(FontStyle.Italic)
            .decoration({ type: TextDecorationType.Underline, color: Color.Black })
          Span('，我是Span3').fontSize(16).fontColor(Color.Grey)
            .decoration({ type: TextDecorationType.Overline, color: Color.Green })
        }
        .borderWidth(1)
        .padding(10)
        TextInput({placeholder:'我是提示文本',text:'我是当前文本内容'})
          .backgroundColor(Color.Grey)
          .type(InputType.Normal)
        TextInput()
          .type(InputType.Password)

        Button('click me')
          .onClick(() => {
            this.dialogController.open()
          })
          .onHover(()=>{
            this.handlePopup = !this.handlePopup
          })
          .bindPopup(this.handlePopup, {
            message: '打开弹窗',
          })
        Button('菜单')
          .bindMenu([
          {
            value: 'Menu1',
            action: () => {
              console.info('handle Menu1 select')
            }
          },
        {
            value: 'Menu2',
            action: () => {
              console.info('handle Menu2 select')
            }
        }
        ])
      }
      .width('100%')
    }
    .height('100%')
  }
}


@CustomDialog
struct CustomDialogExample {
  controller: CustomDialogController
  cancel: () => void
  confirm: () => void
  build() {
    Column() {
      Text('我是内容').fontSize(20).margin({ top: 10, bottom: 10 })
      Flex({ justifyContent: FlexAlign.SpaceAround }) {
        Button('cancel')
          .onClick(() => {
            this.controller.close()
            this.cancel()
          }).backgroundColor(0xffffff).fontColor(Color.Black)
        Button('confirm')
          .onClick(() => {
            this.controller.close()
            this.confirm()
          }).backgroundColor(0xffffff).fontColor(Color.Red)
      }.margin({ bottom: 10 })
    }
  }
}