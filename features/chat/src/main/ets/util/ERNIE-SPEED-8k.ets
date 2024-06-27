import http from '@ohos.net.http'

@Entry
@Component
struct ERNIE {
  @State text: string = '消息'

  async aboutToAppear() {
    this.text = await ChatEngine('30字介绍下北京');
  }

  build() {
    Row() {
      Column() {
        Text(this.text)
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
    }
    .height('100%')
  }
}

let accessToken: string = '24.b7b957a3f4d8a88bf7ebebd75a8e9b6c.2592000.1722088120.282335-87989891'

async function ChatEngine(chatText: string): Promise<string> {
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
          "messages": [
            {
              "role": "user",
              "content": chatText
            }
          ]
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
  });
}