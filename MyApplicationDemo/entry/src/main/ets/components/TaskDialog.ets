@CustomDialog
export struct AddTaskDialog{
  controller: CustomDialogController
  cancel: () => void
  confirm: (title:string) => void

  @Link title:string
  @Link isEdit:boolean
  @Link taskData:string
  @Link totalTask:number
  @Link currentIndex:number
  build() {
    Column({ space: 10 }) {
      Text("添加任务").fontSize(20).margin({top:10,bottom:10})
      TextInput({text: this.title, placeholder: '请输入'}).onChange((value:string)=>this.title = value)
      Flex({justifyContent: FlexAlign.SpaceAround}) {
        Button('取消')
          .onClick(()=>{
            this.controller.close()
            this.cancel()
          }).backgroundColor(0x909399)
        Button(`${this.isEdit?'保存':'添加'}`)
          .onClick(()=>{
            this.controller.close()
            this.confirm(this.title)
          })
      }.margin({bottom:10})
    }
  }
}