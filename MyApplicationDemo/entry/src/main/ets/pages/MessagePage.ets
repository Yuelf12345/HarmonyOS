import {AddTaskDialog} from '../components/TaskDialog'

@Entry
@Component
export default struct Message {
  @State isEdit:boolean = false
  @State currentIndex:number = 0
  @Builder
  MyMenu(index:number){
    Menu() {
      MenuItem({ startIcon: $r("app.media.data_selected"), content: "编辑" }).onClick(()=>{
        this.isEdit = true
        this.currentIndex = index
        console.info('index',this.currentIndex)
        this.title = this.taskData[index].title
        this.addTaskDialogController.open()
      })
      MenuItem({ startIcon: $r("app.media.delete"), content: "删除" }).onClick(()=>{
          this.taskData.splice(index,1)
          this.totalTask = this.taskData.length
          this.finishTask = this.taskData.filter(i=>i.state).length
      })
    }
  }

  @Builder  TaskMenu(index:number){
    Button(){
      Image($r("app.media.icon"))
        .width(24)
    }
    .width(40)
    .height(40)
    .type(ButtonType.Circle)
    .backgroundColor(Color.White).margin(5)
    .bindMenu(this.MyMenu(index))
  }

  //数据

  index:number = 0

  //状态变量
  @State totalTask:number = 0
  @State finishTask:number = 0

  @State taskData:Array<Task> = []
  @State title: string = ''
  addTaskDialogController: CustomDialogController = new CustomDialogController({
    builder: AddTaskDialog({
      title: $title,
      taskData: $taskData,
      isEdit: $isEdit,
      totalTask: $totalTask,
      currentIndex:$currentIndex,
      cancel: this.onCancel,
      confirm: this.onAccept,
    })
  })
  onCancel() {
    this.title = ''
    console.info('cancel')
  }
  onAccept(title) {
    if(this.isEdit){
      console.info('index', this.currentIndex)
      this.taskData.splice(this.currentIndex,1,new Task(title))
    }else{
      this.taskData.push(new Task(title));
    }
    this.totalTask = this.taskData.length
    this.title = ''
  }

  public valueArr: number[] = [10, 10, 10, 10, 10, 10, 10, 10, 10]


  build() {
    Column({space:20}){
      Row(){
        Text('任务进度:')
          .fontWeight(FontWeight.Bolder)
          .fontSize(30)
        Stack(){
          // Progress({value:this.finishTask,type:ProgressType.Ring,total:this.totalTask})
          //   .width('100')
          // Row() {
          //   Text(this.finishTask + '')
          //     .fontSize(30)
          //     .fontColor('#36D')
          //   Text(' / ' + this.taskData.length)
          //     .fontSize(30)
          // }
          DataPanel({ values: [(this.finishTask/this.taskData.length)*100], max: 100, type: DataPanelType.Circle }).width(168).height(168)
          Column() {
            if(this.taskData.length > 0){
              Text(`${(this.finishTask/this.taskData.length)*100}`).fontSize(35).fontColor('#182431')
            }else{
              Text('0').fontSize(35).fontColor('#182431')
            }
          }

          Text('%')
            .fontSize(9.33)
            .lineHeight(12.83)
            .fontWeight(500)
            .opacity(0.6)
            .position({ x: 104.42, y: 78.17 })
        }
      }.card().margin({top:20,bottom:10})
      .justifyContent(FlexAlign.SpaceEvenly)
      Button('新增任务')
        .width(200)
        .onClick(()=>{
          this.isEdit = false
          this.addTaskDialogController.open()
        })
      List({space:8}){
        ForEach(
          this.taskData,
          (item:Task,index)=>{
            ListItem(){
              Row(){
                Text(item.title)
                  .fontSize(20)
                Checkbox()
                  .select(item.state)
                  .onChange(val=>{
                    item.state = val
                    this.finishTask = this.taskData.filter(i=>i.state).length
                  })
              }.card()
              .justifyContent(FlexAlign.SpaceBetween)
            }.swipeAction({end:this.TaskMenu(index)})
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
  title: string
  content: string
  state: boolean = false

  constructor(title:string,content?:string,state?:boolean) {
    this.title = title
    if(content) {
      this.content = content
    }
    if (state) {
      this.state = state
    }
  }
}

@Styles
function card(){
  .width("95%")
  .padding(20)
  .backgroundColor(Color.White)
  .borderRadius(15)
  .shadow({radius:6,color:"#1F000000",offsetX:2,offsetY:4})
}

