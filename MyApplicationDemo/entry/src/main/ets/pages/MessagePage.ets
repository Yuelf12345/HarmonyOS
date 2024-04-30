

@Entry
@Component
export default struct Message {

  @Builder  DeleteTask(index:number){
  Button(){
    Image($r("app.media.delete"))
      .width(24)
  }
  .width(40)
  .height(40)
  .type(ButtonType.Circle)
  .backgroundColor(Color.Red).margin(5)
  .onClick(()=>{
    this.taskData.splice(index,1)
    this.totalTask = this.taskData.length
    this.finishTask = this.taskData.filter(i=>i.finished).length
  })
}
  //数据
  @State taskData:Array<Task> = []
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
            .width('100')
          Row() {
            Text(this.finishTask + '')
              .fontSize(30)
              .fontColor('#36D')
            Text(' / ' + this.totalTask)
              .fontSize(30)
          }
        }
      }.card().margin({top:20,bottom:10})
      .justifyContent(FlexAlign.SpaceEvenly)
      Button("新增任务")
        .width(200)
        .onClick(()=>{
          this.taskData.push(new Task())
        })
      List({space:8}){
        ForEach(
          this.taskData,
          (item:Task,index)=>{
            ListItem(){
              Row(){
                Text(item.name)
                  .fontSize(20)
                Checkbox()
                  .select(item.finished)
                  .onChange(val=>{
                    item.finished = val
                    this.finishTask = this.taskData.filter(i=>i.finished).length
                  })
              }.card()
              .justifyContent(FlexAlign.SpaceBetween)
            }.swipeAction({end:this.DeleteTask(index)})
          }
        )
      }
      .width("100%")
      .alignListItem(ListItemAlign.Center)
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .padding({top:20})
    .backgroundColor('#ffeceaea')
  }
}


class Task{
  static id: number = 1
  name: string = `任务${Task.id++}`
  finished: boolean = false
}

@Styles
function card(){
  .width("95%")
  .padding(20)
  .backgroundColor(Color.White)
  .borderRadius(15)
  .shadow({radius:6,color:"#1F000000",offsetX:2,offsetY:4})
}

