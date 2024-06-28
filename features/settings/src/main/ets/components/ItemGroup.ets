@Component
export struct ItemGroup {
  @BuilderParam noParam: () => void;

  build() {
    Column() {
      this.noParam()
    }
    .width('100%')
    .borderRadius(24)
    .backgroundColor($r('sys.color.ohos_id_color_foreground_contrary'))
    .padding(4)
  }
}