@Preview
@Component
export struct MainItem {
  private title: string | Resource = '';
  private tag: string | Resource = '';
  private icon: string | Resource = '';
  private label: string = '';
  @LocalStorageLink('selectedLabel') selectedLabel: string = '';
  @LocalStorageProp('isSplitMode') isSplitMode: boolean = false;
  @State isTouched: boolean = false;

  isActivated(): boolean {
    if (this.isSplitMode) {
      return this.label !== '' && this.label === this.selectedLabel;
    }
    return this.isTouched;
  }

  build() {
    Row() {
      Image(this.icon)
        .width(28)
        .height(28)

      Text(this.title)
        .fontSize(18)
        .lineHeight(22)
        .fontWeight(FontWeight.Medium)
        .fontFamily('HarmonyHeiTi')
        .fontColor($r('sys.color.ohos_id_color_text_primary'))
        .align(Alignment.Start)
        .margin({ left: 16 })

      Blank()

      Text(this.tag)
        .fontSize(18)
        .lineHeight(19)
        .fontWeight(FontWeight.Regular)
        .fontFamily('HarmonyHeiTi')
        .fontColor($r('sys.color.ohos_id_color_text_primary'))

      Image($r('app.media.ic_settings_arrow'))
        .width(14)
        .height(26)
        .margin({left: 4})
        .fillColor($r('sys.color.ohos_id_color_fourth'))
    }
    .alignItems(VerticalAlign.Center)
    .width('100%')
    .height(56)
    .borderRadius(20)
    .padding({left: 8, right: 8})
    .backgroundColor(this.isActivated() ? $r('app.color.itemActivated') : $r('app.color.itemInactivated'))
    .onTouch((event: TouchEvent) => {
      if (event.type === TouchType.Down) {
        this.isTouched = true;
      } else if (event.type === TouchType.Up) {
        this.isTouched = false;
      }
    })
  }
}