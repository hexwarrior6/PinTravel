import { ChatPage } from '@ohos/chat';

@Entry
@Component
struct Index {
  private tabsController : TabsController = new TabsController();
  @State currentIndex: number = 0;

  @Builder
  tabBarBuilder(title: string, targetIndex: number, selectedIcon: Resource, unselectIcon: Resource) {
    Column() {
      Image(this.currentIndex === targetIndex ? selectedIcon : unselectIcon)
        .width(24)
        .height(24)
      Text(title)
        .fontFamily('HarmonyHeiTi-Medium')
        .fontSize(10)
        .fontColor(this.currentIndex === targetIndex ? '#0A59F7' : 'rgba(0,0,0,0.60)')
        .textAlign(TextAlign.Center)
        .lineHeight(14)
        .fontWeight(500)
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .onClick(() => {
      this.currentIndex = targetIndex;
      this.tabsController.changeIndex(targetIndex);
    })
  }

  build() {
    Tabs({ barPosition: BarPosition.End, controller: this.tabsController }) {
      TabContent() {
        // ChatPage()
      }
      .tabBar(this.tabBarBuilder('行程', 0, $r('app.media.calendar_fill'), $r('app.media.calendar')))

      TabContent() {
        ChatPage()
      }
      .tabBar(this.tabBarBuilder('对话', 1, $r('app.media.house_fill'), $r('app.media.house')))

      TabContent() {
        // KnowledgeMap()
      }
      .tabBar(this.tabBarBuilder('地图', 2, $r('app.media.satellite_map_fill'), $r('app.media.satellite_map')))

      TabContent() {
        // KnowledgeMap()
      }
      .tabBar(this.tabBarBuilder('设置', 3, $r('app.media.square_fill_grid_2x2'), $r('app.media.square_grid_2x2')))
    }
    .scrollable(false)
    .vertical(false)
    // .divider({
    //   strokeWidth: 0.5,
    //   color: '#0D182431'
    // })
    .backgroundColor('#F1F3F5')
    .padding({ top: 36, bottom: 28 })
  }
}