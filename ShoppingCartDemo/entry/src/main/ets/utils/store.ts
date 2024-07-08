import preferences from '@ohos.data.preferences';

class PersistentStorage {
  preMap: Map<string, preferences.Preferences> = new Map();

  async loadPersistentStorage(content,name:string){
    try{
      let pref = await preferences.getPreferences(content,name);
      this.preMap.set(name,pref);
      return pref;
    }catch(e){
      console.log("loadPersistentStorage error:"+e);
      return null;
    }
  }

  //   写数据
  async putPersistentStorage(name:string,key:string,value:preferences.ValueType){
    if(!this.preMap.get(name)){
      console.log(`putPersistentStorage error:${name} is not exist`)
      return;
    }
    try{
      let pref = this.preMap.get(name);
      //  写入数据
      await pref.put(key,value)
      // 刷新磁盘
      await pref.flush();
      console.log("putPersistentStorage success：",  name);
    }catch(e){
      console.log("putPersistentStorage error:"+e);
    }
  }

  //   获取数据
  async getPersistentStorage(name:string,key:string,defaultValue:preferences.ValueType){
    if(!this.preMap.get(name)){
      console.log(`getPersistentStorage error:${name} is not exist`)
      return null;
    }
    try{
      let pref = this.preMap.get(name);
      //  获取数据
      let value = await pref.get(key,defaultValue);
      console.log("getPersistentStorage success：",  name);
      return value;
    }catch(e){
      console.log("getPersistentStorage error:"+e);
    }
  }
}

const persistentStorage = new PersistentStorage();
export default persistentStorage;