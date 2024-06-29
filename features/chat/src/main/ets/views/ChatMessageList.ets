import { ChatMessageClass } from '../model/ChatMessageClass';
import ChatMessageModel from '../model/ChatMessageModel';

@Preview
@Component
export struct ChatMessageList {
  // aboutToAppear(): void {
  //   this.getTutorialDataFromJSON();
  // }
  //
  // getTutorialDataFromJSON() {
  //   getContext(this).resourceManager.getRawFileContent('TutorialData.json').then(value => {
  //     this.tutorialList = JSON.parse(bufferToString(value.buffer)) as ArticleClass[];
  //   })
  // }

  @Consume chatMessages: Array<ChatMessageClass>

  aboutToAppear() {
    console.log('testTag', '初始化组件，查询行程列表')
    ChatMessageModel.getChatMessageList()
      .then(chatMessages => {
        this.chatMessages = chatMessages
      })
  }

  build() {
    List({ space: 12 }) {
      ForEach(this.chatMessages, (item: ChatMessageClass) => {
        ListItem() {
          ChatMessageItem({ chatMessageItem: item })
            .padding({ left: 10, right: 10 })
        }
      })
    }
    .padding({ top: 10, left: 16, right: 16 })
  }
}

// @Preview
@Component
struct ChatMessageItem {
  @ObjectLink chatMessageItem: ChatMessageClass;

  build() {
    if (this.chatMessageItem.role == 'user') {
      Row() {
        Row() {
          Text(this.chatMessageItem.content)
            .fontSize(18)
            .textAlign(TextAlign.Start)
            .fontWeight(400)
            .margin({ top: 4 })
        }
        .borderRadius({ topLeft: 15, topRight: 15, bottomLeft: 15 })
        .backgroundColor('#bad7df')
        .padding({ top: 5, bottom: 10, left: 10, right: 10 })
        .alignItems(VerticalAlign.Top)
        .justifyContent(FlexAlign.End)
      }
      .width('100%')
      .justifyContent(FlexAlign.End)
    } else {
      Row() {
        Text(this.chatMessageItem.content)
          .fontSize(18)
          .textAlign(TextAlign.Start)
          .fontWeight(400)
          .margin({ top: 4 })
      }
      .borderRadius({ topLeft: 15, topRight: 15, bottomRight: 15 })
      .backgroundColor('#ffe2e2')
      .padding({ top: 5, bottom: 10, left: 10, right: 10 })
      .alignItems(VerticalAlign.Top)
      .justifyContent(FlexAlign.Start)
    }
  }
}