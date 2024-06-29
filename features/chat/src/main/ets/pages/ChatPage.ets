import { ChatMessageClass } from '../model/ChatMessageClass';
import { ChatMessageList } from '../views/ChatMessageList';
import { Header } from '../views/Header';
import { TextBoxBar } from '../views/TextBoxBar';

@Preview
@Component
export struct ChatPage {
  @Provide chatMessages: Array<ChatMessageClass> = []

  build() {
    Column() {
      Header()
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

