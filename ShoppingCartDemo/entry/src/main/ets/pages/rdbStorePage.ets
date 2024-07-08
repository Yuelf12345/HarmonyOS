import RdbStore from '../utils/rdbStore'

@Entry
@Component
struct  MainView {
  build(){
    Row(){
      Column(){
        Button('创建数据库表')
          .onClick(()=>{
            /**
             * @param sql 创建表的SQL语句
             * 若表不存在则创建，表包含以下字段：
             * ID：整数类型，主键，自动递增
             * NAME：文本类型，非空
             * AGE：整数类型
             * SALARY：实数类型
             * CODES：BLOB类型，用于存储二进制大对象
             */
            const SQL_CREATE_TABLE = 'CREATE TABLE IF NOT EXISTS EMPLOYEE (ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT NOT NULL, AGE INTEGER, SALARY REAL, CODES BLOB)';
            RdbStore.executeSql(SQL_CREATE_TABLE)
              .then((data)=>{
                openDialog('创建数据库表成功')
              })
              .catch((err)=>{
                openDialog('创建数据库表失败')
              })
          })
        Button('插入数据')
          .onClick(()=>{
            const valueBucket = {
              name: 'Tom',
              age: 20,
              salary: 10000,
              codes: new Uint8Array([1, 2, 3, 4, 5])
            }
            RdbStore.insert('EMPLOYEE', valueBucket)
              .then((data)=>{
                openDialog('插入数据成功')
              })
              .catch((err)=>{
                openDialog('插入数据失败')
              })
          })
        Button('查询数据')
          .onClick(()=>{
            RdbStore.queryAll()
              .then((employees: Array<Employee>)=>{
                openDialog('查询数据成功:'+JSON.stringify(employees))
              }).catch((err)=>{
              openDialog('查询数据失败')
            })
          })
        Button('更新数据')
          .onClick(()=>{
            const valueBucket = {
              name: 'Jack',
              age: 21,
              salary: 15000,
              codes:  new Uint8Array([6,7,8,9,10])
            }
            RdbStore.updateById(1, valueBucket).then((data)=>{
              openDialog('更新数据成功'+JSON.stringify(data))
            }).catch((err)=>{
              openDialog('更新数据失败')
            })
          })
        Button('删除数据')
          .onClick(()=>{
            RdbStore.deleteById(1).then((data)=>{
              openDialog('删除数据成功'+JSON.stringify(data))
            }).catch((err)=>{
              openDialog('删除数据失败')
            })
          })
      }
    }
  }
}

function openDialog(msg: string){
  AlertDialog.show({
    title: '提示',
    message: msg,
    autoCancel: true,
    alignment: DialogAlignment.Bottom,
    offset:{dx: 0, dy: -20}
  })
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