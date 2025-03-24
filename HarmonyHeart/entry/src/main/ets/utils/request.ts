// 引入包名
import { http } from "@kit.NetworkKit";
import { BusinessError } from "@kit.BasicServicesKit";
import logger from "./print";
let httpRequest = http.createHttp();
export const request = (url: string, method, data?): Promise<any> => {
  return new Promise((resolve, reject) => {
    httpRequest.request(
      url,
      {
        method,
        extraData: data,
        header: { Accept: "application/json" },
        readTimeout: 60000, // 可选，默认为60000ms。
        connectTimeout: 60000, // 可选，默认为60000ms。
      },
      (err: BusinessError, data: http.HttpResponse) => {
        if (!err) {
          // data.result为HTTP响应内容，可根据业务需要进行解析。
          logger.info(data.result);
          // logger.info(data.resultType);
          // logger.info(data.header); // data.header为HTTP响应头，可根据业务需要进行解析。
          // logger.info(data.cookies); // 自API version 8开始支持cookie。
          // 取消订阅HTTP响应头事件。
          httpRequest.off("headersReceive");
          // 当该请求使用完毕时，开发者务必调用destroy方法主动销毁该JavaScript Object。
          httpRequest.destroy();
          resolve(data.result);
        } else {
          logger.error(err);
          // 取消订阅HTTP响应头事件。
          httpRequest.off("headersReceive");
          // 当该请求使用完毕时，开发者务必调用destroy方法主动销毁该JavaScript Object。
          httpRequest.destroy();
          reject(err);
        }
      }
    );
  });
};
