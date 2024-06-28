import fileIo from '@ohos.file.fs';
import fs from '@ohos.file.fs';
@Entry
@Component
struct ERNIE {
  aboutToAppear(){
    myjson();
  }

  @State text: string = '消息'

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

export function myjson(): void{
  // const jsonObj = {name: "John", age: 30, city: "New York"};
  // const jsonStr = JSON.stringify(jsonObj);
  // let ss = fs.createStreamSync('/data/test.json',"r");
  // // fs.listFileSync('/data/test.json', jsonStr, 'utf-8');
  // fileIo.write(ss, jsonStr, 'utf-8')
  // return jsonObj.name;


  let filePath = "C:\\test.txt";
  let ss= fs.createStreamSync(filePath, "r+");
  ss.write("hello, world", { offset: 5, length: 5, encoding :'utf-8'}, (err, bytesWritten) => {
    if (err) {
      console.info("write stream failed with error message: " + err.message + ", error code: " + err.code);
    } else {
      if (bytesWritten) {
        console.info("write succeed and size is:" + bytesWritten);
      }
    }
  });
}