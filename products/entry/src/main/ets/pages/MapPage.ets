import webview from '@ohos.web.webview';
import router from '@ohos.router';

@Entry
@Component
export struct MapPage {
  private webviewController: webview.WebviewController = new webview.WebviewController();
  @State params: any = router.getParams()


  build() {
    Column() {
      Web({ src: 'https://map.baidu.com/mobile/webapp/search/search/qt=s&da_src=shareurl&wd=' + this.params.name, controller: this.webviewController })
        .domStorageAccess(true)
    }
  }
}