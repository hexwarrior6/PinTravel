// 统一的卡片样式
@Styles function card() {
  .width('95%')
  .padding(20)
  .backgroundColor(Color.White)
  .borderRadius(15)
  .shadow({ radius: 6, color: '#1F000000', offsetX: 2, offsetY: 4 })
}

@Component
export default struct TripStatistics {
  @State title: string = "杭州之旅"
  @Prop totalTrip: number
  @Prop finishTrip: number

  build() {
    Column() {
      Text(this.title)
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
        .padding({ top: 10, bottom: 10 })
      Progress({
        value: this.finishTrip,
        total: this.totalTrip,
        type: ProgressType.Linear
      }).style({ strokeWidth: 20 })
      // Stack() {
      //   Progress({
      //     value: this.finishTrip,
      //     total: this.totalTrip,
      //     type: ProgressType.Ring
      //   })
      //     .width(100)
      //   Row() {
      //     Text(this.finishTrip.toString())
      //       .fontSize(24)
      //       .fontColor('#36D')
      //     Text(' / ' + this.totalTrip.toString())
      //       .fontSize(24)
      //   }
      // }
    }
    .margin({ top: 5, bottom: 10 })
    .borderRadius(20)
    .backgroundColor('#0C000000')
    .height(120)
    .width('100%')
    .justifyContent(FlexAlign.SpaceEvenly)
  }
}