@Preview
@Component
export struct Header {
  build() {
    Stack() {
      Row() {
        Text('Pin') //'Pin📍'
          .fontSize(25)
          .fontWeight('700')
          .fontFamily('HarmonyHeiTi-Bold')
          .lineHeight(33)
        Image($r('app.media.pin'))
          .height(25)
          .width(25)
      }
      .height(50)
      .borderRadius(20)
      .backgroundColor('#0C000000')
      .width('100%')
      .justifyContent(FlexAlign.Center)

      Row() {
        Button() {
          Image($r('app.media.arrow_counterclockwise_clock'))
            .width(25)
            .height(25)
            .margin(8)
        }
        .type(ButtonType.Circle)
        .backgroundColor('#0C000000')
      }
      .width('98%')
      .justifyContent(FlexAlign.End)
    }
    .width('90%')
  }
}

