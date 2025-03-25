// TODO 1. 引入lottie三方库。
import lottie from '@ohos/lottie';

@Entry
@Component
export default  struct LottiePage {

  // 动画资源路径和名字
  private mPath: string = "common/lottie/ghost.json"
  // TODO 相当于key，并非资源配置的名字，可以任意
  private mName: string = "test";

  // TODO 2. 使用RenderingContext在Canvas组件上进行绘制，声明CanvasRenderingContext2D变量，RenderingContextSettings用来配置CanvasRenderingContext2D对象的参数表明canvas是否开启抗锯齿。
  private mRenderingSettings: RenderingContextSettings = new RenderingContextSettings(true);
  private mCanvasRenderingContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.mRenderingSettings);

  // TODO 6.实现动画播放方法。
  lottieController(): void {


    lottie.stop();
    lottie.play(this.mName);
  }

  build() {
    Column() {
      // TODO 4.创建画布容器承载lottie
      Canvas(this.mCanvasRenderingContext)
        .width(px2vp(1000))
        .height(px2vp(1000))
        .backgroundColor(Color.Gray)
        .onReady(() => {
          //抗锯齿的设置
          this.mCanvasRenderingContext.imageSmoothingEnabled = true;
          this.mCanvasRenderingContext.imageSmoothingQuality = 'medium'

          // 加载动画前先销毁之前加载的动画
          lottie.destroy(this.mName);
          // TODO 5.加载lottie动画
          lottie.loadAnimation({
            container: this.mCanvasRenderingContext,
            renderer: 'canvas',
            frameRate: 60,                               //设置animator的刷帧率为30
            loop: true,
            autoplay: false,
            name: this.mName,
            path: this.mPath,
          });
        })
        .onDisAppear(() => {
          // 组件移除时，可销毁动画资源
          lottie.destroy(this.mName);
        })

      Text("点击播放动画")
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .onClick(()=>{
          // TODO 7.在组件事件中调用播放方法
          this.lottieController();
        })
    }
    .height('100%')
    .width('100%')
    .justifyContent(FlexAlign.Center)
  }
}

// TODO 3.定义所需数据类型的接口，初始化变量，接口中需要包含资源路径信息和CanvasRenderingContext2D。
interface TabBarOption {
  index: number;
  text: ResourceStr;
  name: string;
  path: string;
  canvasRenderingContext: CanvasRenderingContext2D;
}
