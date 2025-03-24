// 示例文件：example.ts
import { request } from '../utils/request';

export const apiGetData = ():Promise<any> => {
  return request('https://jsonplaceholder.typicode.com/users',"GET");
};