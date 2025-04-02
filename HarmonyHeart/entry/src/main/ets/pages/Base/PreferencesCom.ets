import { preferences } from '@kit.ArkData'
import { LengthMetrics } from '@kit.ArkUI'
import { BusinessError } from '@kit.BasicServicesKit'
import logger from '../../utils/print'

@Entry
@Component
struct PreferencesCom {
  @State message: string = 'PreferencesCom';
  dataPreferences: preferences.Preferences | null = null

  aboutToAppear(): void {
    let options: preferences.Options = { name: 'myStore' }
    this.dataPreferences = preferences.getPreferencesSync(getContext(this), options)
  }

  build() {
    Flex({justifyContent: FlexAlign.Center,direction: FlexDirection.Column,alignItems: ItemAlign.Center, space:{main: LengthMetrics.px(20)}}) {
      Text(this.message)
        .id('PreferencesCom')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
      Button('put')
        .onClick(async () => {
          this.dataPreferences?.put('name', '张三', (err: BusinessError) => {
            if (err) {
              logger.error(`写入数据失败：code=${err.code}，message=${err.message}`)
              return
            }
            logger.info('写入数据成功')
          })
        })
      Button('get')
        .onClick(async () => {
          this.dataPreferences?.get('name', '默认值', (err: BusinessError, val: preferences.ValueType) => {
            if (err) {
              logger.error(`获取数据失败：code=${err.code}，message=${err.message}`)
              return
            }
            logger.info(`获取数据成功： val=${val}`)
          })
        })
      Button('getAll')
        .onClick(async () => {
          this.dataPreferences?.getAll((err: BusinessError, val: preferences.ValueType) => {
            if (err) {
              logger.error(`获取数据失败：code=${err.code}，message=${err.message}`)
              return
            }
            logger.info(`获取数据成功： val=${val}`)
          })
        })
      Button('has')
        .onClick(async () => {
          this.dataPreferences?.has('name', (err: BusinessError, flag: boolean) => {
            if (err) {
              logger.error(`检查失败： code=${err.code}, message=${err.message}`)
              return
            }
            logger.info('检查的key值是否存在：' + flag)
          })
        })
      Button('delete')
        .onClick(() => {
          this.dataPreferences?.delete('name', (err: BusinessError) => {
            if (err) {
              logger.error(`删除失败： code=${err.code}, message=${err.message}`)
              return
            }
            logger.info('删除成功')
          })
          this.dataPreferences?.flush()
        })
      Button('clear')
        .onClick(() => {
          this.dataPreferences?.clear((err: BusinessError) => {
            if (err) {
              logger.error(`删除所有数据失败： code=${err.code}, message=${err.message}`)
            }
            logger.info('删除所有数据成功')
          })
        })
    }
    .height('100%')
    .width('100%')
  }
}