//导入请求
import http from '@ohos.net.http';
//响应格式
class  Response {
  /**
   * 响应码
   */
  code:number
  /**
   * 响应消息
   */
  message:string
  /**
   * 响应数据
   */
  data:any
}

//导出去一个请求函数 使用axios风格请求数据、参数可自行增加
export function request(url:string,method: 'POST'|'GET',data?:any): Promise<Response> {
  const BASE_URL =  "http://10.0.1.83:3000"
  let httpRequest = http.createHttp();
  console.info("开始请求");
  console.info("传递参数",data);

  let responseResult = httpRequest.request( BASE_URL+ url,{
    method: http.RequestMethod[`${method}`],
    //请求头设置
    header: {
      'Content-Type': 'application/json'
    },
    //携带额外参数
    extraData: JSON.stringify(data),
  });

  let response = new Response();
  // 处理数据，并返回
  return responseResult.then((result: http.HttpResponse) => {
    console.info("接口返回数据" + result.result)
    if (result.responseCode === 200) {
      let res: Response = JSON.parse(`${result.result}`);
      response.data = res.data;
      response.code = res.code;
      response.message = res.message;
    } else {
      response.message = '请求错误';
      response.code = 400;
    }
    return response;
  }).catch((err) => {
    console.info('error:' + JSON.stringify(err));
    // 当该请求使用完毕时，调用destroy方法主动销毁。
    httpRequest.destroy();
    response.message = '请求错误';
    response.code = 400;
    return response;
  });
}