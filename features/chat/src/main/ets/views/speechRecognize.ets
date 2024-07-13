// import { abilityAccessCtrl, Permissions } from '@kit.AbilityKit'
import audio from '@ohos.multimedia.audio'
import abilityAccessCtrl, { Permissions } from '@ohos.abilityAccessCtrl'
// import { speechRecognizer } from '@kit.CoreSpeechKit'
// import { audio } from '@kit.AudioKit'

// https://cloud.baidu.com/doc/SPEECH/s/Jlbxdezuf

@Entry
@Component
struct Index {
  audioCapturer: audio.AudioCapturer | null = null
  asrEngine: speechRecognizer.SpeechRecognitionEngine | null = null
  asrEngineId: string = 'QF'
  @State str: string = ""

  async requestPermissions(permissions: Permissions[]) {
    // 1. 创建应用权限管理器
    const atManager = abilityAccessCtrl.createAtManager()
    // 2. 向用户申请 user_grant 权限（温馨提示：首次申请时会弹窗，后续申请则不会再出现弹窗）
    const requestResult = await atManager.requestPermissionsFromUser(getContext(), permissions)
    // 通过 every 检查权限是否都成功授权
    const isAuth = requestResult.authResults.every(item => item === abilityAccessCtrl.GrantStatus.PERMISSION_GRANTED)
    // Promise.resolve()   返回 Promise 成功，await 后续代码，正常执行
    // Promise.reject()    返回 Promise 错误，Promise.reject() 的结果可被 catch 捕获
    return isAuth === true ? Promise.resolve(true) : Promise.reject(false)
  }

  // 开始录制
  async startRecord() {
    // 1. 初始化语音识别引擎
    this.asrEngine = await speechRecognizer.createEngine({
      language: 'zh-CN',
      online: 1
    })
    // 保存组件的 this，后续通过_this来使用组件
    const _this = this
    // 2. 给引擎设置回调(监听)，用来接收语音识别相关的回调信息
    this.asrEngine.setListener({
      onStart(sessionId: string, eventMessage: string) {
        console.info(`onStart, sessionId: ${sessionId} eventMessage: ${eventMessage}`);
      },
      onEvent(sessionId: string, eventCode: number, eventMessage: string) {
        console.info(`onEvent, sessionId: ${sessionId} eventCode: ${eventCode} eventMessage: ${eventMessage}`);
      },
      // !! 识别结果回调，包括中间结果和最终结果
      onResult(sessionId: string, result: speechRecognizer.SpeechRecognitionResult) {
        _this.str = result.result
        // _this.onChange(result.result)
        console.info(`onResult, sessionId: ${sessionId} sessionId: ${JSON.stringify(result)}`);
      },
      // 识别完成回调
      onComplete(sessionId: string, eventMessage: string) {
        // 录音完成，修改录音状态，更新视图，隐藏录音提示文案
        console.info(`onComplete, sessionId: ${sessionId} eventMessage: ${eventMessage}`);
      },
      onError(sessionId: string, errorCode: number, errorMessage: string) {
        console.error(`onError, sessionId: ${sessionId} errorCode: ${errorCode} errorMessage: ${errorMessage}`);
      }
    })

    // 3. 调用 startListening 方法，开始合成
    this.asrEngine?.startListening({
      sessionId: this.asrEngineId,
      audioInfo: {
        audioType: 'pcm',
        sampleRate: 16000,
        soundChannel: 1,
        sampleBit: 16
      }
    })
    // 开始录音
    const audioStreamInfo: audio.AudioStreamInfo = {
      samplingRate: audio.AudioSamplingRate.SAMPLE_RATE_16000,
      channels: audio.AudioChannel.CHANNEL_1,
      sampleFormat: audio.AudioSampleFormat.SAMPLE_FORMAT_S16LE,
      encodingType: audio.AudioEncodingType.ENCODING_TYPE_RAW
    }
    const audioCapturerInfo: audio.AudioCapturerInfo = {
      source: audio.SourceType.SOURCE_TYPE_MIC,
      capturerFlags: 0
    }
    const audioCapturerOptions: audio.AudioCapturerOptions = {
      streamInfo: audioStreamInfo,
      capturerInfo: audioCapturerInfo
    }
    // 4. 获取音频采集器
    this.audioCapturer = await audio.createAudioCapturer(audioCapturerOptions)
    this.audioCapturer.on('readData', (buffer) => {
      // 5. 调用 writeAudio 方法，开始写入音频流。读取音频文件时，开发者需预先准备一个pcm格式音频文件。
      this.asrEngine?.writeAudio(this.asrEngineId, new Uint8Array(buffer))
    })
    await this.audioCapturer.start()
  }

  // 停止录制
  async closeRecord() {
    this.audioCapturer?.stop()
    this.audioCapturer?.release()
    // 结束识别，调用 finish 方法
    this.asrEngine?.finish(this.asrEngineId)
    // 取消识别，调用 cancel 方法
    this.asrEngine?.cancel(this.asrEngineId)
    // 释放语音识别引擎资源，调用shutdown方法
    this.asrEngine?.shutdown()

  }

  aboutToAppear(): void {
    // 申请麦克风权限弹窗
    this.requestPermissions(["ohos.permission.MICROPHONE"])
  }

  build() {
    Column({ space: 20 }) {
      Text('结果:' + this.str)

      Button('开始识别')
        .onClick(() => {
          this.startRecord()
        })

      Button('识别结束')
        .onClick(() => {
          this.closeRecord()
        })
    }
    .width('100%')
    .height('100%')
  }
}