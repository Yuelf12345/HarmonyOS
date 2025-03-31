import NavBack from '../../components/NavBack'
import ConnectionUtils from '../../utils/connectionUtils'
@Entry
@Component
struct NetworkKitCom {
  @State message: string = 'NetworkKitCom';
  @State NetworkStatus: boolean = false;
  async aboutToAppear(): Promise<void> {
    await ConnectionUtils.isNetworkConnected().then((value) => {
      this.NetworkStatus = value;
    })
  }

  build() {
    RelativeContainer() {
      Column(){
        NavBack()
        Text(this.message)
          .id('NetworkKitCom')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
        Text(this.NetworkStatus ? '网络已连接' : '网络未连接')
          .id('NetworkKitCom')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
      }
   }
  }
}