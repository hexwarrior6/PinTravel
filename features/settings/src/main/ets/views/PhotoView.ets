@Preview
@Component
export struct PhotoView {
  build() {
    Column() {
      Image($r('app.media.person_crop_circle_fill_1'))
        .width(100)
        .height(100)
        .objectFit(ImageFit.Contain)

      Text('我')
        .fontSize(20)
        .lineHeight(21)
        .fontColor($r('sys.color.ohos_id_color_text_secondary'))
        .margin({ top: 10 })
    }
    .borderRadius(20)
    .backgroundColor('#0C000000')
    .height(200)
    .width('100%')
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
  }
}