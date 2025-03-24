// request.ts
import http from '@ohos.net.http';

class Request {
  private httpRequest: http.HttpRequest;

  constructor() {
    this.httpRequest = http.createHttp();
  }

  private sendRequest(options: http.HttpRequestOptions): Promise<http.HttpResponse> {
    return new Promise((resolve, reject) => {
      this.httpRequest.request(options, (err, data) => {
        if (err) {
          reject(err);
        } else {
          resolve(data);
        }
      });
    });
  }

  public async get(url: string, headers: http.HttpHeader = {}): Promise<http.HttpResponse> {
    const options: http.HttpRequestOptions = {
      method: http.RequestMethod.GET,
      url: url,
      header: headers
    };
    try {
      const response = await this.sendRequest(options);
      return response;
    } catch (error) {
      throw error;
    }
  }

  public async post(url: string, data: any, headers: http.HttpHeader = {}): Promise<http.HttpResponse> {
    const options: http.HttpRequestOptions = {
      method: http.RequestMethod.POST,
      url: url,
      header: headers,
      extraData: JSON.stringify(data)
    };
    try {
      const response = await this.sendRequest(options);
      return response;
    } catch (error) {
      throw error;
    }
  }
}

const requestInstance = new Request();

export default requestInstance;