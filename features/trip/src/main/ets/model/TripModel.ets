import relationalStore from '@ohos.data.relationalStore';
import TripInfo from './TripInfo';

class TripModel {

  private rdbStore: relationalStore.RdbStore
  private tableName: string = 'TRIP'

  /**
   * 初始化任务表
   */
  initTripDB(context){
    // 1.rdb配置
    const config = {
      name: 'Trip.db',
      securityLevel: relationalStore.SecurityLevel.S1
    }
    // 2.初始化SQL语句
    const sql = `CREATE TABLE IF NOT EXISTS TRIP (
                  ID INTEGER PRIMARY KEY AUTOINCREMENT,
                  NAME TEXT NOT NULL,
                  FINISHED bit
                 )`
    // 3.获取rdb
    relationalStore.getRdbStore(context, config, (err, rdbStore) => {
      if(err){
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
  async getTripList(){
    // 1.构建查询条件
    let predicates = new relationalStore.RdbPredicates(this.tableName)
    // 2.查询
    let result = await this.rdbStore.query(predicates, ['ID', 'NAME', 'FINISHED'])
    // 3.解析查询结果
    // 3.1.定义一个数组，组装最终的查询结果
    let trips: TripInfo[] = []
    // 3.2.遍历封装
    while(!result.isAtLastRow){
      // 3.3.指针移动到下一行
      result.goToNextRow()
      // 3.4.获取数据
      let id = result.getLong(result.getColumnIndex('ID'))
      let name = result.getString(result.getColumnIndex('NAME'))
      let finished = result.getLong(result.getColumnIndex('FINISHED'))
      // 3.5.封装到数组
      trips.push({id, name, finished: !!finished})
    }
    console.log('testTag', '查询到数据：', JSON.stringify(trips))
    return trips
  }

  /**
   * 添加一个新的任务
   * @param name 任务名称
   * @returns 任务id
   */
  addTrip(name: string): Promise<number>{
    return this.rdbStore.insert(this.tableName, {name, finished: false})
  }

  /**
   * 根据id更新任务状态
   * @param id 任务id
   * @param finished 任务是否完成
   */
  updateTripStatus(id: number, finished: boolean) {
    // 1.要更新的数据
    let data = {finished}
    // 2.更新的条件
    let predicates = new relationalStore.RdbPredicates(this.tableName)
    predicates.equalTo('ID', id)
    // 3.更新操作
    return this.rdbStore.update(data, predicates)
  }

  /**
   * 根据id删除任务
   * @param id 任务id
   */
  deleteTripById(id: number){
    // 1.删除的条件
    let predicates = new relationalStore.RdbPredicates(this.tableName)
    predicates.equalTo('ID', id)
    // 2.删除操作
    return this.rdbStore.delete(predicates)
  }
}

let tripModel = new TripModel();

export default tripModel as TripModel;
