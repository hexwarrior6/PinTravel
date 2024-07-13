import { ChatMessageClass } from '../model/ChatMessageClass';
import { ChatMessageList } from '../views/ChatMessageList';
import { Header } from '../views/Header';
import { TextBoxBar } from '../views/TextBoxBar';

@Preview
@Component
export struct ChatPage {
  @Provide chatMessages: Array<ChatMessageClass> = [
    // new ChatMessageClass(1, 'user', '你好'),
    // new ChatMessageClass(2,'assistant', '你好！很高兴帮助你制定旅行计划。为了更好地为你服务，够否请你提供一些关于旅行的只体信息呢？例如你怨去的地方是里？打算什么时间去呢？你在交证和住有上有没有特别的高求或者预片限制？这些信总会帮助我为你制定一个完美的旅行规划，'),
    // new ChatMessageClass(3, 'user', '我要去杭州玩'),
    // new ChatMessageClass(4, 'assistant', '好的，那么让我们一起制定一份详细的杭州旅行计划吧。你需要提供以下信息以便我为你制定行程安排：出发地、具体出行时间、交通方式、预算和具体的旅游偏好等。有了这些信息后，我将根据你的时间长度和哥求规划具体景点、行程路线和游玩内容等细节，同时提供费用预算和小贴士。请告诉我这些信息，以便我能为你制定一个完美的杭州旅行计划。'),
    // new ChatMessageClass(5, 'user', '我从上海出发'),
    // new ChatMessageClass(6, 'assistant', '好的，你计划什么时候出发去杭州呢？另外，你的预算大概是多少？是否有特定的景点或活动偏好？请告诉我这些信息，这样我可以为你制定一个更加贴合需求的旅行计划。'),
    // new ChatMessageClass(7, 'user', '你好'),
  ]

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

