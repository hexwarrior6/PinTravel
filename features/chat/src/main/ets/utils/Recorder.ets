import audio from '@ohos.multimedia.audio';
import { delay } from './Utils';

export default class AudioCapturer {
  private audioCapturer: audio.AudioCapturer | undefined = undefined
  private isRecording: boolean = false
  private audioStreamInfo: audio.AudioStreamInfo = {
    samplingRate: audio.AudioSamplingRate.SAMPLE_RATE_16000, // 音频采样率
    channels: audio.AudioChannel.CHANNEL_1, // 录音通道数
    sampleFormat: audio.AudioSampleFormat.SAMPLE_FORMAT_S16LE,
    encodingType: audio.AudioEncodingType.ENCODING_TYPE_RAW  // 音频编码类型
  }
  private audioCapturerInfo: audio.AudioCapturerInfo = {
    // 音源类型，使用SOURCE_TYPE_VOICE_RECOGNITION会有减噪功能，如果设备不支持，该用普通麦克风：SOURCE_TYPE_MIC
    source: audio.SourceType.SOURCE_TYPE_VOICE_RECOGNITION,
    capturerFlags: 0 // 音频采集器标志
  }
  private audioCapturerOptions: audio.AudioCapturerOptions = {
    streamInfo: this.audioStreamInfo,
    capturerInfo: this.audioCapturerInfo
  }

  // 初始化，创建实例，设置监听事件
  constructor() {
    // 创建AudioCapturer实例
    audio.createAudioCapturer(this.audioCapturerOptions, (err, capturer) => {
      if (err) {
        console.error(`创建录音器失败, 错误码：${err.code}, 错误信息：${err.message}`)
        return
      }
      this.audioCapturer = capturer
      console.info('创建录音器成功')
    });
  }

  // 开始一次音频采集
  async start(callback: (state: number, data?: ArrayBuffer) => void) {
    // 当且仅当状态为STATE_PREPARED、STATE_PAUSED和STATE_STOPPED之一时才能启动采集
    let stateGroup = [audio.AudioState.STATE_PREPARED, audio.AudioState.STATE_PAUSED, audio.AudioState.STATE_STOPPED]
    if (stateGroup.indexOf(this.audioCapturer.state) === -1) {
      console.error('启动录音失败')
      callback(audio.AudioState.STATE_INVALID)
      return
    }
    // 启动采集
    await this.audioCapturer.start()
    this.isRecording = true
    let bufferSize = 1920
    // let bufferSize: number = await this.audioCapturer.getBufferSize();

    while (this.isRecording) {
      let buffer = await this.audioCapturer.read(bufferSize, true)
      if (buffer === undefined) {
        console.error('读取录音数据失败')
      } else {
        callback(audio.AudioState.STATE_RUNNING, buffer)
      }
    }
    callback(audio.AudioState.STATE_STOPPED)
  }

  // 停止采集
  async stop() {
    this.isRecording = false
    // 只有采集器状态为STATE_RUNNING或STATE_PAUSED的时候才可以停止
    if (this.audioCapturer.state !== audio.AudioState.STATE_RUNNING && this.audioCapturer.state !== audio.AudioState.STATE_PAUSED) {
      console.warn('Capturer is not running or paused')
      return
    }
    await delay(200)
    // 停止采集
    await this.audioCapturer.stop()
    if (this.audioCapturer.state.valueOf() === audio.AudioState.STATE_STOPPED) {
      console.info('录音停止')
    } else {
      console.error('录音停止失败')
    }
  }

  // 销毁实例，释放资源
  async release() {
    // 采集器状态不是STATE_RELEASED或STATE_NEW状态，才能release
    if (this.audioCapturer.state === audio.AudioState.STATE_RELEASED || this.audioCapturer.state === audio.AudioState.STATE_NEW) {
      return
    }
    // 释放资源
    await this.audioCapturer.release()
  }
}
