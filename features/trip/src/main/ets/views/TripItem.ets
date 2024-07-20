import TripModel from '../model/TripModel'
import TripInfo from '../model/TripInfo'
import router from '@ohos.router'

@Component
export default struct TripItem {
  @ObjectLink item: TripInfo
  onTripChange: (item: TripInfo) => void

  build() {
    Row() {
      if (this.item.finished) {
        Text(this.item.name)
          .fontSize(20)
          .maxLines(1)
          .finishedTrip()
      } else {
        Text(this.item.name)
          .fontSize(20)
          .maxLines(1)
      }
      Checkbox()
        .height(20)
        .select(this.item.finished)
        .onChange(async val => {
          // 1.更新当前任务状态
          TripModel.updateTripStatus(this.item.id, val)
            .then(() => {
              this.item.finished = val
              // 2.更新已完成任务数量
              this.onTripChange(this.item)
            })
            .catch(error => console.log('testTag', '更新任务状态失败, id = ', this.item.id, JSON.stringify(error)))

        })
    }
    .card()
    .justifyContent(FlexAlign.SpaceBetween)
    .onClick(() => {
      // router跳转
      router.pushUrl(
        {
          url: 'pages/MapPage',
          params: { name: this.item.name }
        },
        router.RouterMode.Single,
        err => {
          if (err) {
            console.log(`路由失败，errCode: ${err.code} errMsg:${err.message}`)
          }
        }
      )
    })
  }
}

// 任务完成样式
@Extend(Text) function finishedTrip() {
  .decoration({ type: TextDecorationType.LineThrough })
  .fontColor('#B1B2B1')
}

// 统一的卡片样式
@Styles function card() {
  .width('95%')
  .padding({ top: 15, bottom: 15, left: 20, right: 20 })
  .backgroundColor(Color.White)
  .borderRadius(20)
  .shadow({ radius: 6, color: '#1F000000', offsetX: 2, offsetY: 4 })
}