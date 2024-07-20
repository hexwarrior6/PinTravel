import abilityAccessCtrl, { Permissions } from '@ohos.abilityAccessCtrl';
import common from '@ohos.app.ability.common';
import AudioCapture from '../utils/Recorder';
import promptAction from '@ohos.promptAction';
import { checkPermissions } from '../utils/Permission';
import audio from '@ohos.multimedia.audio';
import util from '@ohos.util';
import { SpeechRecognizer } from '../utils/SpeechRecognizer';

// 需要动态申请的权限
const permissions: Array<Permissions> = ['ohos.permission.MICROPHONE'];
// 获取程序的上下文
const context = getContext(this) as common.UIAbilityContext;

@Entry
@Component
export struct speechRecognizeButton {
  @State recordBtnImage: string = 'mic_fill.svg'
  @Provide speechResult: string = ''
  private recordedData: ArrayBuffer
  // 录音器
  private audioCapture?: AudioCapture;

  // 页面显示时
  async onPageShow() {
    // 判断是否已经授权
    let promise = checkPermissions(permissions[0])
    promise.then((result) => {
      if (result) {
        // 初始化录音器
        if (this.audioCapture == null) {
          this.audioCapture = new AudioCapture()
        }
      } else {
        this.reqPermissionsAndRecord(permissions)
      }
    })
  }

  // 页面隐藏时
  async onPageHide() {
    if (this.audioCapture != null) {
      this.audioCapture.release()
    }
  }

  build() {
    Button() {
      Image($rawfile(this.recordBtnImage)).width(25).margin(10)
    }
    .margin({ right: 20 })
    .type(ButtonType.Circle)
    .id("recordBtn")
    // .alignRules({
    //   bottom: { anchor: '__container__', align: VerticalAlign.Bottom },
    //   middle: { anchor: '__container__', align: HorizontalAlign.Center }
    // })
    .onTouch(async (event) => {
      switch (event.type) {
        case TouchType.Down:
          console.info('按下按钮')
        // 判断是否有权限
          let promise = checkPermissions(permissions[0])
          promise.then((result) => {
            if (result) {
              // 开始录音
              this.startRecord()
              this.recordBtnImage = 'mic_fill.svg'
            } else {
              // 申请权限
              this.reqPermissionsAndRecord(permissions)
            }
          })
          break
        case TouchType.Up:
          console.info('松开按钮')
        // 停止录音
          this.stopRecord()
          this.recordBtnImage = 'mic.svg'
          let base64 = new util.Base64Helper()
          this.speechResult = '111'
          const uint8Array = new Uint8Array(this.recordedData)
          let recorded64Data = base64.encodeSync(uint8Array)
          this.speechResult = await SpeechRecognizer(recorded64Data)
          break
      }
    })
  }

  // 开始录音
  startRecord() {
    this.audioCapture.start((state, data) => {
      if (state == audio.AudioState.STATE_STOPPED) {
        console.info('录音结束');
        this.recordedData = data
      }
    });
  }

  // 停止录音
  stopRecord() {
    if (this.audioCapture != null) {
      this.audioCapture.stop()
    }
  }

  // 申请权限
  reqPermissionsAndRecord(permissions: Array<Permissions>): void {
    let atManager = abilityAccessCtrl.createAtManager();
    // requestPermissionsFromUser会判断权限的授权状态来决定是否唤起弹窗
    atManager.requestPermissionsFromUser(context, permissions).then((data) => {
      let grantStatus: Array<number> = data.authResults;
      let length: number = grantStatus.length;
      for (let i = 0; i < length; i++) {
        if (grantStatus[i] === 0) {
          // 用户授权，可以继续访问目标操作
          console.info('授权成功')
          if (this.audioCapture == null) {
            this.audioCapture = new AudioCapture()
          }
        } else {
          promptAction.showToast({ message: '授权失败,需要授权才能录音' })
          return;
        }
      }
    }).catch((err) => {
      console.error(`requestPermissionsFromUser failed, code is ${err.code}, message is ${err.message}`);
    })
  }
}
