import router from '@ohos.router';

@Entry
@Component
export default  struct Shopping {
  @State ProductType:number = 0
  @State SortType:number = 0
  @State ProductTypeList: Array<string> = ['推荐', '数码','食品']
  @State SortTypeList: Array<string> = ['综合排序', '销量优先','价格']
  @State ProductList: Array<any> = [
    {
      img:'https://gw.alicdn.com/tps/LB1HL0mQVXXXXbzXVXXXXXXXXXX.png',
      title:'DELSEY 男士双肩背包',
      price: 269,
      orderNum:69
    },
    {
      img:'https://gw.alicdn.com/tps/LB1HL0mQVXXXXbzXVXXXXXXXXXX.png',
      title:'Beats EP头戴式耳机',
      price: 558,
      orderNum:1872
    },
    {
      img:'https://gw.alicdn.com/tps/LB1HL0mQVXXXXbzXVXXXXXXXXXX.png',
      title:'DELSEY 男士双肩背包',
      price: 269,
      orderNum:69
    },
    {
      img:'https://gw.alicdn.com/tps/LB1HL0mQVXXXXbzXVXXXXXXXXXX.png',
      title:'Beats EP头戴式耳机',
      price: 558,
      orderNum:1872
    },
    {
      img:'https://gw.alicdn.com/tps/LB1HL0mQVXXXXbzXVXXXXXXXXXX.png',
      title:'DELSEY 男士双肩背包',
      price: 269,
      orderNum:69
    },
    {
      img:'https://gw.alicdn.com/tps/LB1HL0mQVXXXXbzXVXXXXXXXXXX.png',
      title:'Beats EP头戴式耳机',
      price: 558,
      orderNum:1872
    }
  ]
  build() {
    Row() {
      Column() {
        Text('商品列表')
          .fontSize(20)
          .margin({top:10,bottom:10})
        Flex(){
          ForEach(this.ProductTypeList,(item,index)=>{
            Button(item, { type: ButtonType.Normal, stateEffect: true })
              .width(`${1/this.ProductTypeList.length*100}%`)
              .backgroundColor(`${this.ProductType == index ? '#9A51FF' : '#5D4285'}`)
              .padding({top:15,bottom:15})
              .onClick(()=>{
                this.ProductType = index
                console.info('当前点击', index)
              })
          })
        }.width('100%')
        Flex(){
          ForEach(this.SortTypeList,(item,index)=>{
            Button(item, { type: ButtonType.Normal, stateEffect: true })
              .width(`${1/this.SortTypeList.length*100}%`)
              .backgroundColor(Color.White)
              .fontColor(`${this.SortType == index ? '#9A51FF' : '#5D4285'}`)
              .padding({top:15,bottom:15})
              .onClick(()=>{
                this.SortType = index
                console.info('当前点击', index)
              })
          })
        }.width('100%')
        Flex({direction:FlexDirection.Column,justifyContent:FlexAlign.SpaceBetween}){
          List({space:8}){
            ForEach(this.ProductList,(item,index)=>{
              ListItem(){
                Row(){
                  Image(item.img)
                    .width(50).height(50).margin(10).overlay('png')
                  Column(){
                    Text(item.title)
                      .width('100%')
                      .textAlign(TextAlign.Start)
                      .height(36)
                      .fontSize(15)
                    Flex({ direction:FlexDirection.Row,justifyContent: FlexAlign.SpaceBetween }){
                      Column(){
                        Text(`￥${item.price}`)
                          .priceText()
                        Text(`${item.orderNum}已付款`)
                          .width('100%')
                          .fontSize(12)
                          .textAlign(TextAlign.Start)
                          .fontColor('#888')
                      }
                      Text('+')
                        .height(22)
                        .width(32)
                        .fontColor('#fff')
                        .textAlign(TextAlign.Center)
                        .borderRadius(12)
                        .backgroundColor('#7a45e5')
                        .onClick(()=>{
                          console.info('213',item.price)
                        })
                    }.width('100%')
                  }.width('70%')
                }.card()
              }
            })
          }.flexShrink(1)
          Flex({justifyContent:FlexAlign.SpaceBetween}){
            Text('数量')
            Button('去购物车')
              .onClick(()=>{
                router.pushUrl({url:"pages/ShoppingCart"})
              })
          }.padding(10)
        }.height('80%')
      }
      .height('100%')
      .width('100%')
    }
    .height('100%')
  }
}


@Styles
function card(){
  .width("100%")
  .padding(20)
  .backgroundColor(Color.White)
  .borderRadius(15)
  .shadow({radius:6,color:"#1F000000",offsetX:2,offsetY:4})
}

@Extend(Text) function priceText(){
  .width('100%')
  .fontSize(15)
  .textAlign(TextAlign.Start)
  .fontColor('#7a45e5')
  .fontWeight(FontWeight.Bolder)
}