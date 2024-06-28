import webview from '@ohos.web.webview';

@Component
export struct MapPage {
  private webviewController: webview.WebviewController = new webview.WebviewController();

  build() {
    Column() {
      Web({ src: 'https://map.baidu.com/mobile/webapp/index/index/#index/index/foo=bar/vt=map', controller: this.webviewController })
        .domStorageAccess(true)
    }
  }
}