import relationalStore from '@ohos.data.relationalStore'

/**
 * RdbStore类用于操作关系型数据库。
 * 它提供了一系列静态方法，包括设置数据库实例、获取数据库实例、执行SQL语句以及插入数据。
 */
export default class RdbStore {
  private static rdbStore: relationalStore.RdbStore; // 静态属性，用于存储关系型数据库的实例

  /**
   * 设置数据库实例。
   * @param store - 关系型数据库的实例。
   */
  static setStore(store: relationalStore.RdbStore) {
    RdbStore.rdbStore = store;
  }

  /**
   * 获取数据库实例。
   * @returns 返回关系型数据库的实例。
   */
  static getStore(): relationalStore.RdbStore {
    return RdbStore.rdbStore;
  }

  /**
   * 执行SQL语句。
   * @param sql - 要执行的SQL语句。
   * @returns 返回一个Promise，当SQL执行完成时解析。
   */
  static executeSql(sql: string):Promise<void>{
    return RdbStore.getStore().executeSql(sql);
  }

  /**
   * 在指定的表中插入数据。
   * @param tableName - 要插入数据的表名。
   * @param values - 要插入的数据值。
   * @returns 返回一个Promise，解析为插入操作影响的行数。
   */
  static async insert(tableName: string, values: relationalStore.ValuesBucket): Promise<number> {
    return RdbStore.getStore().insert(tableName, values);
  }
  /**
   * 查询表中的所有数据。
   * @returns 返回一个Promise，解析为包含Employee对象的数组。
   */
  static queryAll(): Promise<Array<Employee>> {
    let predicates = new relationalStore.RdbPredicates('EMPLOYEE');
    return new Promise<Array<Employee>>((resolve, reject) => {
      RdbStore.getStore().query(predicates).then((result) => {
        let employees = new Array<Employee>();
        while (result.goToNextRow()) {
          let employee = new Employee(
            result.getLong(0),
            result.getString(1),
            result.getLong(2),
            result.getDouble(3),
            result.getBlob(4)
          );
          employees.push(employee);
        }
        resolve(employees);
      }).catch((error) => {
        reject(error)
      })
    })
  }

  static deleteById(id: number){
    let predicates = new relationalStore.RdbPredicates('EMPLOYEE');
    predicates.equalTo('id', id.toString());
    return RdbStore.getStore().delete(predicates);
  }

  static updateById(id:number, values: relationalStore.ValuesBucket){
    let predicates = new relationalStore.RdbPredicates('EMPLOYEE');
    predicates.equalTo('id', id.toString());
    return RdbStore.getStore().update(values, predicates);
  }
}


class Employee {
  id: number; // 员工ID
  name: string; // 姓名
  age: number | null; // 年龄，允许为null
  salary: number | null; // 工资，允许为null
  codes: Uint8Array | null; // 二进制数据，用于存储 BLOB 类型，允许为null

  constructor(id: number, name: string, age: number | null, salary: number | null, codes: Uint8Array | null) {
    this.id = id;
    this.name = name;
    this.age = age;
    this.salary = salary;
    this.codes = codes;
  }
}