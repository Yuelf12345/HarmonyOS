import util from '@ohos.util';
import router from '@ohos.router'
class Contact {
  key: string = util.generateRandomUUID(true);
  name: string;
  icon: Resource;

  constructor(name: string, icon: Resource) {
    this.name = name;
    this.icon = icon;
  }
}
const alphabets = [ 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K',
  'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'];
@Entry
@Component
struct ListPage {
  @State selectedIndex: number = 0;
  private listScroller: Scroller = new Scroller();

  contactsGroups: object[] = [
    {
      title: 'A',
      contacts: [
        new Contact('艾佳', $r('app.media.icon')),
        new Contact('安安', $r('app.media.icon')),
        new Contact('Angela', $r('app.media.icon')),
      ],
    },
    {
      title: 'B',
      contacts: [
        new Contact('白叶', $r('app.media.icon')),
        new Contact('伯明', $r('app.media.icon')),
      ],
    },
    {
      "title": "C",
      "contacts": [
        new Contact('曹雪', $r('app.media.icon')),
        new Contact('陈晨', $r('app.media.icon')),
        new Contact('Charlie', $r('app.media.icon'))
      ]
    },
    {
      "title": "D",
      "contacts": [
        new Contact('丁香', $r('app.media.icon')),
        new Contact('冬梅', $r('app.media.icon')),
        new Contact('Daniel', $r('app.media.icon'))
      ]
    },
    {
      "title": "E",
      "contacts": [
        new Contact('恩熙', $r('app.media.icon')),
        new Contact('Emily', $r('app.media.icon')),
        new Contact('Eric', $r('app.media.icon'))
      ]
    },
    {
      "title": "F",
      "contacts": [
        new Contact('芳芳', $r('app.media.icon')),
        new Contact('菲菲', $r('app.media.icon')),
        new Contact('Frank', $r('app.media.icon'))
      ]
    },
    {
      "title": "G",
      "contacts": [
        new Contact('桂英', $r('app.media.icon')),
        new Contact('郭静', $r('app.media.icon')),
        new Contact('Grace', $r('app.media.icon'))
      ]
    },
    {
      "title": "H",
      "contacts": [
        new Contact('海燕', $r('app.media.icon')),
        new Contact('浩然', $r('app.media.icon')),
        new Contact('Henry', $r('app.media.icon'))
      ]
    },
    {
      "title": "I",
      "contacts": [
        new Contact('依依', $r('app.media.icon')),
        new Contact('Ingrid', $r('app.media.icon')),
        new Contact('Ian', $r('app.media.icon'))
      ]
    },
    {
      "title": "J",
      "contacts": [
        new Contact('嘉怡', $r('app.media.icon')),
        new Contact('静静', $r('app.media.icon')),
        new Contact('Jack', $r('app.media.icon'))
      ]
    },
    {
      "title": "K",
      "contacts": [
        new Contact('凯文', $r('app.media.icon')),
        new Contact('可儿', $r('app.media.icon')),
        new Contact('Kathy', $r('app.media.icon'))
      ]
    }
  ]

  @Builder itemHead(text: string) {
    // 列表分组的头部组件，对应联系人分组A、B等位置的组件
    Text(text)
      .fontSize(20)
      .backgroundColor('#fff1f3f5')
      .width('100%')
      .padding(5)
  }

  build() {
    Stack({ alignContent: Alignment.BottomEnd }){
      List({ space: 10,scroller:this.listScroller }) {
        ForEach(this.contactsGroups, item => {
          ListItemGroup({ header: this.itemHead(item.title) }) {
            // 循环渲染ListItem
            ForEach(item.contacts, (contact:Contact) => {
              ListItem() {
                Row(){
                  Image(contact.icon)
                    .width(40)
                    .height(40)
                    .margin(10)
                  Text(contact.name).fontSize(20)
                }
              }
            }, item => item.key)
          }
        })
      }
      .divider({
        strokeWidth: 1,
        startMargin: 60,
        endMargin: 10,
        color: '#ffe9f0f0'
      })
      .sticky(StickyStyle.Header)  // 设置吸顶，实现粘性标题效果
      .width('100%')
      .onScrollIndex((firstIndex: number) => {
        this.selectedIndex = firstIndex
        // 根据列表滚动到的索引值，重新计算对应联系人索引栏的位置this.selectedIndex
      })
      Column(){
        Button(){
          Text('回到顶部')
            .fontColor('#fff')
        }.onClick(() => {
          // 点击按钮时，指定跳转位置，返回列表顶部
          this.listScroller.scrollToIndex(0)
        })
        Button(){
          Text('返回')
            .fontColor('#fff')
        }
        .onClick(()=>{
          router.replaceUrl({
            url:'pages/Index'
          })
        })
      }

      AlphabetIndexer({ arrayValue: alphabets, selected: 0 })
        .selected(this.selectedIndex)
    }
  }
}