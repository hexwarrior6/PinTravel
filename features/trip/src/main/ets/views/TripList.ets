import TripInfo from '../model/TripInfo'
import TripItem from './TripItem'
import TripModel from '../model/TripModel'

@Component
export default struct TripList {
  // 总任务数量
  @Link totalTrip: number
  @Link finishTrip: number
  // 任务数组
  @State trips: TripInfo[] = []
  idx: number = 1
  // 任务信息弹窗
  dialogController: CustomDialogController = new CustomDialogController({
    builder: TripInfoDialog({ onTripConfirm: this.handleAddTrip.bind(this) }),
  })

  aboutToAppear() {
    // 查询任务列表
    console.log('testTag', '初始化组件，查询行程列表')
    TripModel.getTripList()
      .then(trips => {
        this.trips = trips
        // 更新任务状态
        this.handleTripChange()
      })
  }

  handleTripChange() {
    // 1.更新任务总数量
    this.totalTrip = this.trips.length
    // 2.更新已完成任务数量
    this.finishTrip = this.trips.filter(item => item.finished).length
  }

  handleAddTrip(name: string) {
    // 1.新增任务
    TripModel.addTrip(name)
      .then(id => {
        // 回显到数组页面
        this.trips.push(new TripInfo(id, name))
        // 2.更新任务完成状态
        this.handleTripChange()
        // 3.关闭对话框
        this.dialogController.close()
      })
      .catch(error => console.log('testTag', '新增行程失败：', name, JSON.stringify(error)))
  }

  build() {
    Column() {
      // 1.新增任务按钮
      Button('新增行程')
        .fontSize(18)
        .width(200)
        .margin({ bottom: 20 })
        .onClick(() => {
          // 打开新增表单对话框
          this.dialogController.open()
        })

      // 2.任务列表
      List({ space: 10 }) {
        ForEach(
          this.trips,
          (item: TripInfo, index) => {
            ListItem() {
              TripItem({ item: item, onTripChange: this.handleTripChange.bind(this) })
            }
            .swipeAction({ end: this.DeleteButton(index, item.id) })
          }
        )
      }
      .width('100%')
      .layoutWeight(1)
      .alignListItem(ListItemAlign.Center)
    }
  }

  @Builder DeleteButton(index: number, id: number) {
    Button() {
      Image($r('app.media.trash_fill'))
        .fillColor(Color.White)
        .width(25)
    }
    .width(45)
    .height(45)
    .type(ButtonType.Circle)
    .backgroundColor(Color.Red)
    .margin(10)
    .onClick(() => {
      // 删除任务
      TripModel.deleteTripById(id)
        .then(() => {
          this.trips.splice(index, 1)
          console.log('testTag', `尝试删除行程，index: ${index}`)
          this.handleTripChange()
        })
        .catch(error => console.log('testTag', '删除行程失败，id = ', id, JSON.stringify(error)))

    })
  }
}

@CustomDialog
struct TripInfoDialog {
  name: string = ''
  onTripConfirm: (name: string) => void
  controller: CustomDialogController

  build() {
    Column({ space: 20 }) {
      TextInput({ placeholder: '输入目的地' })
        .fontSize(18)
        .onChange(val => this.name = val)
        .placeholderFont({ size: 18, weight: 400 })
      Row() {
        Button('确定')
          .onClick(() => {
            if (this.name != '') this.onTripConfirm(this.name)
          })
        Button('取消')
          .backgroundColor(Color.Grey)
          .onClick(() => {
            this.controller.close()
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
    }
    .width('100%')
    .padding(20)
  }
}