import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';

const TAG: string = '[EntryAbility]';
const DOMAIN_NUMBER: number = 0x0000;

export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    hilog.info(DOMAIN_NUMBER, TAG, '%{public}s', 'Ability onCreate UIAbility实例创建完成');
  }

  onDestroy(): void {
    hilog.info(DOMAIN_NUMBER, TAG, '%{public}s', 'Ability onDestroy UIAbility实例销毁');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    hilog.info(DOMAIN_NUMBER, TAG, '%{public}s', 'Ability onWindowStageCreate 窗口平台创建完成');

    windowStage.loadContent('pages/Index', (err) => {
      if (err.code) {
        hilog.error(DOMAIN_NUMBER, TAG, 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(DOMAIN_NUMBER, TAG, 'Succeeded in loading the content.');
    });

    //   设置WindowStage的事件订阅（获焦/失焦、切到前台/切到后台、前台可交互/前台不可交互）
    try {
      windowStage.on('windowStageEvent', (data)=>{
        let stageEventType: window.WindowStageEventType = data;
        switch(stageEventType){
          case window.WindowStageEventType.SHOWN: // 切到前台
            hilog.info(DOMAIN_NUMBER, TAG, `windowStage foreground. 切到前台`);
            break;
          case window.WindowStageEventType.ACTIVE: // 获取焦点
            hilog.info(DOMAIN_NUMBER, TAG, '%{public}s', 'windowStage inactive 窗口平台获取焦点');
            break;
          case window.WindowStageEventType.INACTIVE: // 失去焦点
            hilog.info(DOMAIN_NUMBER, TAG, '%{public}s', 'windowStage inactive 窗口平台失去焦点');
          case window.WindowStageEventType.HIDDEN: // 切到后台
            hilog.info(DOMAIN_NUMBER, TAG, `windowStage background. 切到后台`);
            break;
          case window.WindowStageEventType.RESUMED: // 前台可交互状态
            hilog.info(DOMAIN_NUMBER, TAG, `windowStage resumed. 前台可交互状态`);
            break;
          case window.WindowStageEventType.PAUSED: // 前台不可交互状态
            hilog.info(DOMAIN_NUMBER, TAG, `windowStage paused. 前台不可交互状态`);
            break;
          default:
            break;
        }
      })
    }catch(e){
      hilog.error(DOMAIN_NUMBER, TAG, 'Failed to load the content. Cause: %{public}s', JSON.stringify(e) ?? '');
    }
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    hilog.info(DOMAIN_NUMBER, TAG, '%{public}s', 'Ability onWindowStageDestroy 窗口平台销毁');
  }

  onForeground(): void {
    // Ability has brought to foreground
    hilog.info(DOMAIN_NUMBER, TAG, '%{public}s', 'Ability onForeground 切换至前台');
  }

  onBackground(): void {
    // Ability has back to background
    hilog.info(DOMAIN_NUMBER, TAG, '%{public}s', 'Ability onBackground 切换至后台');
  }
}
