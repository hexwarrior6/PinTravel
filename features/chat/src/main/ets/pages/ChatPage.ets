import { ChatMessageClass } from '../model/ChatMessageClass';
import { ChatMessageList } from '../view/ChatMessageList';
import { TextBoxBar } from '../view/TextBoxBar';

@Preview
@Component
export struct ChatPage {
  @Provide messageList: Array<ChatMessageClass> = [new ChatMessageClass(false, "你好，我是你的行程规划管家，请问有什么需要帮助的")]
  build() {
    Column() {
      Text('Pin📍')
        .fontSize(24)
        .fontWeight('700')
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ left: 16 })
        .fontFamily('HarmonyHeiTi-Bold')
        .lineHeight(33)
      Scroll() {
        ChatMessageList()
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .align(Alignment.Top)

      Row() {
        TextBoxBar()
      }
      .backgroundColor('#F1F3F5')
    }
    .height('100%')
    .width('100%')
    .backgroundColor('#F1F3F5')
  }
}

