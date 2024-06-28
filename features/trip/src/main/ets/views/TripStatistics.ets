// 统一的卡片样式
@Styles function card(){
  .width('95%')
  .padding(20)
  .backgroundColor(Color.White)
  .borderRadius(15)
  .shadow({radius: 6, color: '#1F000000', offsetX: 2, offsetY: 4})
}

@Component
export default struct TripStatistics {
  @Prop totalTrip: number
  @Prop finishTrip: number

  build() {
    Row(){
      Text('任务进度：')
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
      Stack(){
        Progress({
          value: this.finishTrip,
          total: this.totalTrip,
          type: ProgressType.Ring
        })
          .width(100)
        Row(){
          Text(this.finishTrip.toString())
            .fontSize(24)
            .fontColor('#36D')
          Text(' / ' + this.totalTrip.toString())
            .fontSize(24)
        }
      }
    }
    .card()
    .margin({top: 5, bottom: 10})
    .justifyContent(FlexAlign.SpaceEvenly)
  }
}