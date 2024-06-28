import { ChatMessageClass } from '../model/ChatMessageClass'
import { ChatEngine } from '../utils/ERNIE-SPEED-8k'

@Preview
@Component
export struct TextBoxBar {
  @Consume messageList: Array<ChatMessageClass>
  @Provide chatText: string = ''
  @State text: string = ''
  controller: TextInputController = new TextInputController()

  build() {
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
          this.messageList.push(new ChatMessageClass(true, tempText))
          this.text = ''
          this.messageList.push(new ChatMessageClass(false, await ChatEngine(tempText)))
        }
      })
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .padding({ top: 5, bottom: 5 })
  }
}