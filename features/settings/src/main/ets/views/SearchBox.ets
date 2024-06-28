@Preview
@Component
export struct SearchBox {
  build() {
    Row() {
      Image($r('app.media.ic_search'))
        .width(20)
        .height(20)
        .objectFit(ImageFit.Contain)
        .margin({left: 11})

      Text($r('app.string.searchHint'))
        .fontSize(18)
        .lineHeight(24)
        .fontWeight(FontWeight.Regular)
        .fontColor($r('sys.color.ohos_id_color_text_secondary'))
        .margin({left: 6})
    }
    .borderRadius(20)
    .backgroundColor('#0C000000')
    .height(40)
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }
}