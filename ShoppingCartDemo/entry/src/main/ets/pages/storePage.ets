import persistentStorage from '../utils/store'

@Entry
@Component
struct  MainView {
  @State title:string = "";

  async aboutToAppear(){
    await persistentStorage.putPersistentStorage('myStore','title','这是标题')
    this.title = await persistentStorage.getPersistentStorage('myStore','title','默认标题') as string;
  }

  build(){
    Column(){
      Text(this.title)
        .fontSize(30)
    }
  }
}