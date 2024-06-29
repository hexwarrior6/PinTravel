import relationalStore from '@ohos.data.relationalStore';
import { ChatMessageClass } from './ChatMessageClass';

class ChatMessageModel {
  private rdbStore: relationalStore.RdbStore
  private tableName: string = 'ChatMessage'

  /**
   * 初始化任务表
   */
  initChatMessageDB(context) {
    // 1.rdb配置
    const config = {
      name: 'ChatMessage.db',
      securityLevel: relationalStore.SecurityLevel.S1
    }
    // 2.初始化SQL语句
    const sql = `CREATE TABLE IF NOT EXISTS ChatMessage (
                 ID INTEGER PRIMARY KEY AUTOINCREMENT,
                 ROLE TEXT NOT NULL,
                 CONTENT TEXT NOT NULL
                 )`
    // 3.获取rdb
    relationalStore.getRdbStore(context, config, (err, rdbStore) => {
      if (err) {
        console.log('testTag', '获取rdbStore失败！')
        return
      }
      // 执行Sql
      rdbStore.executeSql(sql)
      console.log('testTag', '创建Trip表成功！')
      // 保存rdbStore
      this.rdbStore = rdbStore
    })
  }

  /**
   * 查询任务列表
   */
  async getChatMessageList() {
    // 1.构建查询条件
    let predicates = new relationalStore.RdbPredicates(this.tableName)
    // 2.查询
    let result = await this.rdbStore.query(predicates, ['ID', 'ROLE', 'CONTENT'])
    // 3.解析查询结果
    // 3.1.定义一个数组，组装最终的查询结果
    let ChatMessages: ChatMessageClass[] = []
    // 3.2.遍历封装
    while (!result.isAtLastRow) {
      // 3.3.指针移动到下一行
      result.goToNextRow()
      // 3.4.获取数据
      let id = result.getLong(result.getColumnIndex('ID'))
      let role = result.getString(result.getColumnIndex('ROLE'))
      let content = result.getString(result.getColumnIndex('CONTENT'))
      // 3.5.封装到数组
      ChatMessages.push({ id, role, content })
    }
    console.log('testTag', '查询到数据：', JSON.stringify(ChatMessages))
    return ChatMessages
  }

  /**
   * 添加一个新的任务
   * @param name 任务名称
   * @returns 任务id
   */
  addChatMessage(role: string, content: string): Promise<number> {
    return this.rdbStore.insert(this.tableName, { role, content })
  }

  // /**
  //  * 根据id更新任务状态
  //  * @param id 任务id
  //  * @param finished 任务是否完成
  //  */
  // updateChatMessageStatus(id: number, finished: boolean) {
  //   // 1.要更新的数据
  //   let data = { finished }
  //   // 2.更新的条件
  //   let predicates = new relationalStore.RdbPredicates(this.tableName)
  //   predicates.equalTo('ID', id)
  //   // 3.更新操作
  //   return this.rdbStore.update(data, predicates)
  // }
  //
  // /**
  //  * 根据id删除任务
  //  * @param id 任务id
  //  */
  // deleteTripById(id: number) {
  //   // 1.删除的条件
  //   let predicates = new relationalStore.RdbPredicates(this.tableName)
  //   predicates.equalTo('ID', id)
  //   // 2.删除操作
  //   return this.rdbStore.delete(predicates)
  // }
}

let chatMessageModel = new ChatMessageModel();

export default chatMessageModel as ChatMessageModel;
