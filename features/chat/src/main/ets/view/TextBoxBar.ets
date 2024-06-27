@Preview
@Component
export struct TextBoxBar {
  @State text: string = ''
  controller: TextInputController = new TextInputController()
  build() {
    Row(){
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
        })
      Button("button2")
        .type(ButtonType.Circle)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceAround)
  }
}