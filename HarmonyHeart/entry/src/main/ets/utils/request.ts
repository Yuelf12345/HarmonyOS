// 引入包名
import { http } from "@kit.NetworkKit";
import { BusinessError } from "@kit.BasicServicesKit";
import logger from "./print";

// 定义 RequestMethod 枚举
enum RequestMethod {
  GET = "GET",
  POST = "POST",
  PUT = "PUT",
  DELETE = "DELETE",
}

class Request {
  private httpRequest = http.createHttp();

  public async send(url: string, method: RequestMethod = RequestMethod.GET, data?: any): Promise<any> {
    return new Promise((resolve, reject) => {
      this.httpRequest.request(
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
            // 取消订阅HTTP响应头事件。
            this.httpRequest.off("headersReceive");
            // 当该请求使用完毕时，开发者务必调用destroy方法主动销毁该JavaScript Object。
            this.httpRequest.destroy();
            resolve(data.result);
          } else {
            logger.error(err);
            // 取消订阅HTTP响应头事件。
            this.httpRequest.off("headersReceive");
            // 当该请求使用完毕时，开发者务必调用destroy方法主动销毁该JavaScript Object。
            this.httpRequest.destroy();
            reject(err);
          }
        }
      );
    });
  }
}

export default Request;
