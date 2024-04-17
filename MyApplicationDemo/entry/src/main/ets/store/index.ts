import preferences from '@ohos.data.preferences'

class PreferencesUtil {

  //map集合存储多个不同的preference
  preferencesMap: Map<string, preferences.Preferences> = new Map;

  //加载一个preference
  async loadPreference(context, name: string) {
    console.log('testTag', `开始加载Preference [${name}]`);

    try { //返回值是一个Promise包裹起来的preference，因此可以使用链式回调函数处理,也可以使用async/await
      let preference = await preferences.getPreferences(context, name)

      this.preferencesMap.set(name, preference)
      console.log('testTag', `加载Preference [${name}]成功`);

      return preference
    } catch (err) {
      console.log('testTag', `加载Preference [${name}]失败`, JSON.stringify(err));
      Promise.reject(`加载Preference [${name}]失败`)
    }

  }

  //获取指定preference并存入键值对数据
  async putPreferenceValue(name: string, key: string, value: preferences.ValueType) {
    if (!this.preferencesMap.has(name)) {
      console.log('testTag', `Preference[${name}]尚未初始化`);
      //结束异步
      Promise.reject("`Preference[${name}]尚未初始化`")
    }

    try {
      let preference = this.preferencesMap.get(name)

      //写入数据
      await preference.put(key, value)

      //刷新磁盘
      preference.flush()

      console.log('testTag', `保存Preferences[${name}:${key}=${value}]成功`)
    } catch (e) {
      console.log('testTag', `保存Preferences[${name}.${key}=${value}]失败`, JSON.stringify(e));
    }
  }

  //获取指定preference的指定数据
  async getPreferenceValue(name: string, key: string, defaultValue: preferences.ValueType) {
    if (!this.preferencesMap.has(name)) {
      console.log('testTag', `Preference[${name}]尚未初始化`);

      //结束异步
      Promise.reject("`Preference[${name}]尚未初始化`")
    }
    try {
      let preference = this.preferencesMap.get(name)

      //读数据
      let value = await preference.get(key, defaultValue)

      console.log('testTag', `获取Preferences[${name}:${key}=${value}]成功`)

      return value

    } catch (e) {
      console.log('testTag', `获取Preferences[${name}.${key}]失败`, JSON.stringify(e));
    }
  }

  //删除指定preference的指定数据
  async deletePreferenceValue(name: string, key: string) {
    isPreferencesHas(this.preferencesMap, name);

    try {
      let preference = this.preferencesMap.get(name)

      //删除数据
      preference.delete(key)

      console.log('testTag', `删除Preferences[${name}.${key}]成功`)

      return

    } catch (err) {
      console.log('testTag', `删除Preferences[${name}.${key}]失败`)
    }
  }
}

const isPreferencesHas = function (preferenceMap: Map<string, preferences.Preferences>, name) {
  if (!this.preferencesMap.has(name)) {
    console.log('testTag', `Preference[${name}]尚未初始化`);

    //结束异步
    Promise.reject("`Preference[${name}]尚未初始化`")
  }
}


const preferencesUtil = new PreferencesUtil()

export default preferencesUtil as PreferencesUtil