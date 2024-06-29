import { ChatMessageClass } from '../model/ChatMessageClass'
import ChatMessageModel from '../model/ChatMessageModel'
import { ChatEngine } from '../utils/ERNIE-SPEED-8k'

@Preview
@Component
export struct TextBoxBar {
  @Consume chatMessages: Array<ChatMessageClass>
  @Provide chatText: string = ''
  @State text: string = ''
  controller: TextInputController = new TextInputController()

  handleAddChatMessage(role: string, name: string) {
    // 1.新增任务
    ChatMessageModel.addChatMessage(role, name)
      .then(id => {
        // 回显到数组页面
        this.chatMessages.push(new ChatMessageClass(id, role, name))
      })
      .catch(error => console.log('testTag', '新增行程失败：', name, JSON.stringify(error)))
  }

  build() {
    Column() {
      Row() {
        Button('生成行程')
          .FloatButton()
          .fontColor(Color.Gray)
        Button('更改目的地')
          .FloatButton()
          .fontColor(Color.Gray)
        Button('更改日期')
          .FloatButton()
          .fontColor(Color.Gray)
      }
      .margin({ left: 5, bottom: 5 })
      .justifyContent(FlexAlign.SpaceEvenly)
      .width('100%')

      Row() {
        TextInput({ text: this.text, placeholder: '点按以开始聊天', controller: this.controller })
          .placeholderColor(Color.Grey)
          .placeholderFont({ size: 18, weight: 400 })
          .caretColor(Color.Blue)
          .width(300)
          .height(50)
          .fontSize(18)
          .fontColor(Color.Black)
          .onChange((value: string) => {
            this.text = value
            console.log(value)
          })
        Button() {
          Image($r('app.media.paperplane')).width(25).margin(10)
        }
        .margin({ left: 20 })
        .type(ButtonType.Circle)
        .onClick(async () => {
          if (this.text != '') {
            let tempText = this.text
            this.handleAddChatMessage('user', tempText)
            this.text = ''
            this.handleAddChatMessage('assistant', await ChatEngine(tempText))
          }
        })
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .padding({ top: 5, bottom: 5 })
    }
  }
}

@Styles function FloatButton() {
  .backgroundColor('#0C000000')
}