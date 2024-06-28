import { MainItem } from '../components/MainItem';
import { ItemGroup } from '../components/ItemGroup';
import { SearchBox } from '../views/SearchBox';
import { PhotoView } from '../views/PhotoView';
import { ItemWithToggle } from '../components/ItemWithToggle';

@Entry
@Component
export struct SettingPage {
  @Builder CustomDivider() {
    Divider()
      .strokeWidth('1px')
      .color('#F1F3F5')
      .margin({ left: 48, right: 8 })
  }

  build() {


    List({ space: 12 }) {
      ListItem() {
        PhotoView()
      }
      .margin({ top: 10 })

      // ListItem() {
      //   SearchBox()
      // }
      // .padding({ top: 8, bottom: 8 })
      // .width('100%')

      ListItem() {
        ItemGroup() {
          MainItem({
            title: $r('app.string.textSizeTab'),
            icon: $r('app.media.textformat_size_square'),
          })
        }
      }

      ListItem() {
        ItemGroup() {
          ItemWithToggle({
            title: $r('app.string.volumeControlTab'),
            icon: $r('app.media.volume'),
          })
        }
      }

      ListItem() {
        ItemGroup() {
          MainItem({
            title: $r('app.string.storageTab'),
            icon: $r('app.media.storage'),
          })

          this.CustomDivider()

          MainItem({
            title: $r('app.string.security'),
            icon: $r('app.media.security'),
          })

          this.CustomDivider()

          MainItem({
            title: $r('app.string.privacy'),
            icon: $r('app.media.privacy'),
          })
        }
      }

      ListItem() {
        ItemGroup() {
          MainItem({
            title: $r('app.string.usersAccountsTab'),
            icon: $r('app.media.userAccounts'),
          })
        }
      }

    }
    .padding({ left: 12, right: 12 })
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F3F5')
  }
}