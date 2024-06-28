import TripList from '../views/TripList'
import TripStatistics from '../views/TripStatistics'

@Preview
@Component
export struct TripPage {
  @State totalTrip: number = 0
  @State finishTrip: number = 0

  build() {
    Column({ space: 10 }) {
      // 旅行进度卡片
      TripStatistics({ totalTrip: this.totalTrip, finishTrip: this.finishTrip }).margin({ left: 20, right: 20 })
      // 旅行列表
      TripList({ totalTrip: $totalTrip, finishTrip: $finishTrip })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F2F3')
  }
}
