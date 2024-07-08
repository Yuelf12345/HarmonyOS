import NotificationManager from '@ohos.notificationManager';
import wantAgent from '@ohos.app.ability.wantAgent';

@Entry
@Component
struct MainView{
  sendNotification(){
    let wantAgentObj = null; // 用于保存创建成功的wantAgent对象，后续使用其完成触发的动作。

    // 通过WantAgentInfo的operationType设置动作类型。
    let wantAgentInfo = {
      wants: [
        {
          deviceId: '',
          bundleName: 'com.example.test',
          abilityName: 'com.example.test.MainAbility',
          action: '',
          entities: [],
          uri: '',
          parameters: {}
        }
      ],
      operationType: wantAgent.OperationType.START_ABILITY,
      requestCode: 0,
      wantAgentFlags:[wantAgent.WantAgentFlags.CONSTANT_FLAG]
    }
    // 创建WantAgent
    wantAgent.getWantAgent(wantAgentInfo, (err, data) => {
      if (err) {
        console.error('[WantAgent]getWantAgent err=' + JSON.stringify(err));
      } else {
        console.info('[WantAgent]getWantAgent success');
        wantAgentObj = data;
      }
    });
    // 构造NotificationRequest对象
    let notificationRequest = {
      content: {
        contentType: NotificationManager.ContentType.NOTIFICATION_CONTENT_BASIC_TEXT,
        normal: {
          title: 'Test_Title',
          text: 'Test_Text',
          additionalText: 'Test_AdditionalText',
        },
      },
      id: 1,
      label: 'TEST',
      wantAgent: wantAgentObj,
    }
    // 通知发送
    NotificationManager.publish(notificationRequest, (err) => {
      if (err) {
        console.error(`[ANS] failed to publish, error[${err}]`);
        return;
      }
      console.info(`[ANS] publish success `);
    });
  }


  build(){
    Column(){
      Text('Hello World')
        .fontSize(30)
      Button('发送通知')
        .onClick(()=>{
          this.sendNotification()
        })
    }
  }
}