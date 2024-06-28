/*
 * Copyright (c) 2022 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

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

      ListItem() {
        SearchBox()
      }
      .padding({ top: 8, bottom: 8 })
      .width('100%')

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