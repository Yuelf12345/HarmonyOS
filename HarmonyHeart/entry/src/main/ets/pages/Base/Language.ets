import { i18n } from '@kit.LocalizationKit';
import logger from "../../utils/print";
@Entry
@Component
struct Language {
  @State content: string | Resource = $r("app.string.test_content");

  private systemLanguage: string = ""; // 存储系统语言
  private systemLanguages: Array<string> = [];// 系统语言列表
  // 构造函数中初始化系统语言
  aboutToAppear() {
    try {
      this.systemLanguages = i18n.System.getSystemLanguages();
      logger.info("系统语言列表：" + this.systemLanguages);
      this.systemLanguage = i18n.System.getSystemLanguage(); // 获取系统语言
      logger.info("当前系统语言：" + this.systemLanguage);
      i18n.System.setAppPreferredLanguage(this.systemLanguage); // 设置应用语言为系统语言
    } catch (error) {
      logger.error("获取或设置系统语言失败：" + error);
    }
  }

  build() {
    Column() {
      Text(this.content).fontSize(20)

      Button(){
        Text("切换中文")
      }
      .onClick(()=>{
        // 设置语言偏好
        try {
          i18n.System.setAppPreferredLanguage("zh"); // 设置应用偏好语言为zh-Hans
        } catch(error) {
          logger.error("设置语言偏好失败：" + error)
        }
      })

      Button(){
        Text("切换英文")
      }
        .onClick(()=>{
          // 设置语言偏好
          try {
            i18n.System.setAppPreferredLanguage("en");
          } catch(error) {
            logger.error("设置语言偏好失败：" + error)
          }
        })
    }
    .height('100%')
    .width('100%')
  }
}
