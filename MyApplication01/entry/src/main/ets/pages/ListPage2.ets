import util from '@ohos.util';

export class ToDo {
  key: string = util.generateRandomUUID(true);
  name: string;

  constructor(name: string) {
    this.name = name;
  }
}

@Entry
@Component
struct ListPage2 {
  @State toDoData: ToDo[] = [];
  private availableThings: string[] = ['读书', '运动', '旅游', '听音乐', '看电影', '唱歌'];
  private isEditMode:Boolean = false
  @State selectedItems: ToDo[] = [];

  private swiperController: SwiperController = new SwiperController()

  @Builder itemEnd(index: number) {
    // 侧滑后尾端出现的组件
    Button({ type: ButtonType.Circle }) {
      Image($r('app.media.icon'))
        .width(20)
        .height(20)
    }
    .onClick(() => {
      this.toDoData.splice(index,1);
    })
  }

  build() {
    Column(){
      Flex({  justifyContent: FlexAlign.SpaceBetween  }){
        Text('待办')
          .fontSize(30)
        Text('+')
          .fontSize(30)
          .onClick(() => {
            TextPickerDialog.show({
              range: this.availableThings,
              onAccept: (value: TextPickerResult) => {
                this.toDoData.push(new ToDo(this.availableThings[value.index])); // 新增列表项数据toDoData
              },
            })
          })
      }
      .margin(10)
      Swiper(this.swiperController) {
        Text('0')
          .width('90%')
          .height('10%')
          .backgroundColor(Color.Gray)
          .textAlign(TextAlign.Center)
          .fontSize(30)
        Text('1')
          .width('90%')
          .height('10%')
          .backgroundColor(Color.Gray)
          .textAlign(TextAlign.Center)
          .fontSize(30)
        Text('2')
          .width('90%')
          .height('10%')
          .backgroundColor(Color.Gray)
          .textAlign(TextAlign.Center)
          .fontSize(30)
      }
      .loop(true)
      List({ space: 10,initialIndex: 0 }) {
        ForEach(this.toDoData, (toDoItem,toDoIndex) => {
          ListItem() {
            Text(toDoItem.name)
              .fontSize(25)
              .textAlign(TextAlign.Center)
          }
          .margin(10)
          .padding(10)
          .width('90%')
          .height('10%')
          .borderRadius(10)
          .backgroundColor(0xFFFFFF)
          .transition({ type: TransitionType.Delete, opacity: 0 })
          .swipeAction({ end: this.itemEnd(toDoIndex) })
        }, toDoItem => toDoItem.key)
      }
      .listDirection(Axis.Vertical) // 排列方向
      .scrollBar(BarState.Off)
      .divider({
        strokeWidth: 1,
        endMargin: 10,
        color: '#ffe9f0f0'
      })
      .width('90%')
    }
    .height('100%')
    .backgroundColor(0xDCDCDC)
  }
}

