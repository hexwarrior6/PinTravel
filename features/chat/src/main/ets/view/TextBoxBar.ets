import { ChatMessageClass } from '../model/ChatMessageClass'
@Preview
@Component
export struct TextBoxBar {
  @Consume messageList: Array<ChatMessageClass>
  @Provide chatText: string = ''
  @State text: string = ''
  controller: TextInputController = new TextInputController()

  build() {
    Row() {
      TextInput({ text: this.text, placeholder: 'input your word...', controller: this.controller })
        .placeholderColor(Color.Grey)
        .placeholderFont({ size: 14, weight: 400 })
        .caretColor(Color.Blue)
        .width(280)
        .height(40)
        .fontSize(14)
        .fontColor(Color.Black)
        .onChange((value: string) => {
          this.text = value
          console.log(value)
        })
      Button() {
        Image($r('app.media.paperplane')).width(20).margin(10)
      }
      .type(ButtonType.Circle)
      .onClick(() => {
        this.messageList.push(new ChatMessageClass(true, this.text))
        this.text = ''
      })
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceAround)
    .padding({ top: 5, bottom: 5 })
  }
}