import {connection } from '@kit.NetworkKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { promptAction } from '@kit.ArkUI';
import logger from "./print";

export class ConnectionUtils {
  private netConnection:connection.NetConnection
  constructor() {
    this.netConnection   = connection.createNetConnection();
  }
  async isNetworkConnected():Promise<boolean>{
    let res: boolean = false;
    try {
      await connection.getDefaultNet().then(async (data: connection.NetHandle) => {
        if (data.netId === 0) {
          logger.info('network error');
          return;
        }
        await connection.getNetCapabilities(data).then(
          (data: connection.NetCapabilities) => {
            let bearerTypes: Set<number> = new Set(data.bearerTypes);
            let bearerTypesNum = Array.from(bearerTypes.values());
            for (let item of bearerTypesNum) {
              if (item === 0) {
                res = true;
                logger.info('BEARER_CELLULAR');
              } else if (item === 1) {
                res = true;
                logger.info('BEARER_WIFI');
              } else if (item === 3) {
                res = true;
                logger.info('BEARER_ETHERNET');
              } else {
                return;
              }
            }
          })
      })
    } catch (error) {
      logger.error(error);
    }
    return res
  }

  // 订阅指定网络状态变化的通知
  public openRegister() {
    this.netConnection.register((error: BusinessError) => {
      logger.info(JSON.stringify(error));
    });
  }
  // 订阅网络可用事件
  public registerNetworkAvailableStatus(){
    this.netConnection.on('netAvailable', () => {
      promptAction.showToast({
        message: '网络可用',
        duration: 2000
      });
    });
    this.netConnection.on('netUnavailable', () => {
      promptAction.showToast({
        message: '网络不可用',
        duration: 2000
      });
    });
    this.netConnection.on('netLost', () => {
      promptAction.showToast({
        message: '网络丢失',
        duration: 2000
      });
    });
  }
  // 取消订阅
  public closeRegister() {
    this.netConnection.unregister((error: BusinessError)=>{
      logger.info(JSON.stringify(error));
    });
  }
}

export default new ConnectionUtils();