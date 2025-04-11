// WindowManager.ts
import window from '@ohos.window';
import { BusinessError } from '@ohos.base';
import common from '@ohos.app.ability.common';
import logger from "./print";

type EdgeInsets = { top: number; bottom: number; left: number; right: number };

export class WindowController {
  private static instance: WindowController;
  private currentWindow?: window.Window;
  public safeArea: EdgeInsets = { top: 0, bottom: 0, left: 0, right: 0 };
  public keyboardHeight: number = 0;

  private constructor() {}

  public static getInstance(): WindowController {
    if (!WindowController.instance) {
      WindowController.instance = new WindowController();
    }
    return WindowController.instance;
  }

  // 初始化窗口实例
  public async init(context: common.UIAbilityContext): Promise<void> {
    try {
      this.currentWindow = await window.getLastWindow(context);
    } catch (err) {
      this.handleError('窗口初始化失败', err as BusinessError);
      throw err;
    }
  }

  // 基础全屏控制
  public async setFullScreen(enable: boolean): Promise<void> {
    if (!this.currentWindow) {
      throw new Error('窗口未初始化');
    }

    try {
      await this.currentWindow.setWindowLayoutFullScreen(enable);
      await this.currentWindow.setWindowSystemBarEnable(
        enable ? [] : ['status', 'navigation']
      );
    } catch (err) {
      this.handleError('全屏设置失败', err as BusinessError);
      throw err;
    }
  }

  // 错误处理
  private handleError(context: string, err: BusinessError): void {
    logger.error(`${context}: [${err.code}] ${err.message}`)
  }

  // 扩展WindowController类
  public async calculateSafeArea(): Promise<void> {
    if (!this.currentWindow) return;

    try {
      const avoidArea = await this.currentWindow.getWindowAvoidArea(
        window.AvoidAreaType.TYPE_SYSTEM
      );

      this.safeArea = {
        top: avoidArea.topRect.height,
        bottom: avoidArea.bottomRect.height,
        left: avoidArea.leftRect.width,
        right: avoidArea.rightRect.width
      };
    } catch (err) {
      this.handleError('安全区域计算失败', err as BusinessError);
    }
  }
}