import { ChatMessageClass } from '../model/ChatMessageClass';

@Preview
@Component
export struct ChatMessageList {
  @State messageList: Array<ChatMessageClass> = [
    new ChatMessageClass(false, "nihao"), new ChatMessageClass(true, "nihao"),    new ChatMessageClass(false, "nihao"), new ChatMessageClass(true, "nihao"),    new ChatMessageClass(false, "nihao"), new ChatMessageClass(true, "nihao"),    new ChatMessageClass(false, "nihao"), new ChatMessageClass(true, "nihao"),    new ChatMessageClass(false, "nihao"), new ChatMessageClass(true, "nihao"),    new ChatMessageClass(false, "nihao"), new ChatMessageClass(true, "nihao"),    new ChatMessageClass(false, "nihao"), new ChatMessageClass(true, "nihao"),    new ChatMessageClass(false, "nihao"), new ChatMessageClass(true, "nihao"),    new ChatMessageClass(false, "nihao"), new ChatMessageClass(true, "nihao"),    new ChatMessageClass(false, "nihao"), new ChatMessageClass(true, "nihao"),    new ChatMessageClass(false, "nihao"), new ChatMessageClass(true, "nihao"),    new ChatMessageClass(false, "nihao"), new ChatMessageClass(true, "nihao"),
  ];

  // aboutToAppear(): void {
  //   this.getTutorialDataFromJSON();
  // }
  //
  // getTutorialDataFromJSON() {
  //   getContext(this).resourceManager.getRawFileContent('TutorialData.json').then(value => {
  //     this.tutorialList = JSON.parse(bufferToString(value.buffer)) as ArticleClass[];
  //   })
  // }

  build() {
    List({ space: 12 }) {
      ForEach(this.messageList, (item: ChatMessageClass) => {
        ListItem() {
          ChatMessageItem({ chatMessageItem: item })
            .padding({left:10, right:10})
        }
      })
    }
    // .alignListItem(ListItemAlign.Start)
    .padding({ top: 10, left: 16, right: 16 })
  }
}

// @Preview
@Component
struct ChatMessageItem {
  @ObjectLink chatMessageItem: ChatMessageClass;

  build() {
    if (this.chatMessageItem.isme) {
      Row() {
        Row() {
          Text(this.chatMessageItem.text)
            .fontSize(18)
            .textAlign(TextAlign.Start)
            .fontWeight(400)
            .margin({ top: 4 })
          Image($r(this.chatMessageItem.imageSrc))
            .borderRadius(16)
            .objectFit(ImageFit.Cover)
        }
        .borderRadius({ topLeft: 10, topRight: 10, bottomLeft: 10 })
        .backgroundColor('#bad7df')
        .padding({ top: 0, bottom: 5, left: 10, right: 10 })
        .alignItems(VerticalAlign.Top)
        .justifyContent(FlexAlign.End)
      }
      .width('100%')
      .justifyContent(FlexAlign.End)
    } else {
      Row() {
        Text(this.chatMessageItem.text)
          .fontSize(18)
          .textAlign(TextAlign.Start)
          .fontWeight(400)
          .margin({ top: 4 })
        Image($r(this.chatMessageItem.imageSrc))
          .borderRadius(16)
          .objectFit(ImageFit.Cover)
      }
      .borderRadius({ topLeft: 10, topRight: 10, bottomRight: 10 })
      .backgroundColor('#ffe2e2')
      .padding({ top: 0, bottom: 5, left: 10, right: 10 })
      .alignItems(VerticalAlign.Top)
      .justifyContent(FlexAlign.Start)
    }
  }
}