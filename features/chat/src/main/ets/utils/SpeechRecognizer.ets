import http from '@ohos.net.http'

let accessToken: string = '24.c0113047f9057725812e6846d9911301.2592000.1724035049.282335-96605172'

export async function SpeechRecognizer(recordedData: Uint8Array): Promise<string> {
  return new Promise((resolve, reject) => {
    let httpReq = http.createHttp();
    httpReq.request("https://aip.baidubce.com/rpc/2.0/ai_custom/v1/wenxinworkshop/chat/ernie_speed?access_token=" + accessToken,
      {
        method: http.RequestMethod.POST, // 可选，默认为http.RequestMethod.GET
        // 开发者根据自身业务需要添加header字段
        header: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        // 当使用POST请求时此字段用于传递内容
        extraData: {
          "format": "pcm",
          "rate": 16000,
          "dev_pid": 1537,
          "channel": 1,
          "token": accessToken,
          "cuid": "baidu_workshop",
          "len": 4096,
          "speech": recordedData,
        },
        connectTimeout: 60000, // 可选，默认为60s
        readTimeout: 60000, // 可选，默认为60s
      },
      (err, data) => {
        if (!err) {
          if (data.responseCode === 200) { // 假设200是成功的响应码
            let result = JSON.parse(`${data.result}`).result;
            resolve(result); // 使用Promise的resolve方法返回结果
          } else {
            reject(new Error('HTTP请求成功但返回了错误代码: ' + data.responseCode));
          }
        } else {
          reject(err); // 使用Promise的reject方法处理错误
        }
      }
    );
  }
  );
}