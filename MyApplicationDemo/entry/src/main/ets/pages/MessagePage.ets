@Entry
@Component
export default struct Message {

  //数据
  @State taskData:Array<string> = []
  index:number = 0

  //状态变量
  @State totalTask:number = 0
  @State finishTask:number = 0

  build() {
    Column({space:20}){
      Row(){
        Text('任务进度:')
          .fontWeight(FontWeight.Bolder)
          .fontSize(30)
        Stack(){
          Progress({value:this.finishTask,type:ProgressType.Ring,total:this.totalTask})
            .width('100%')
          Row() {
            Text(this.finishTask + '')
              .fontSize(30)
              .fontColor('#36D')
            Text(' / ' + this.totalTask)
              .fontSize(30)
          }
        }
      }
      .card()
      .justifyContent(FlexAlign.SpaceEvenly)
    }
    .width('100%')
    .height('100%')
    .padding({top:20})
    .backgroundColor('#ffeceaea')
  }
}