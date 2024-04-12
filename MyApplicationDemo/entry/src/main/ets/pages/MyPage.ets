
@Component
export default struct MyComponent{
  private title = "第二期"
  private content = "/会议信息"

  build() {
    Column(){
      Text(this.title)
      Text(this.content)
    }.padding(10)
  }
}