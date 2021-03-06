# AMM ![Travis CI](https://travis-ci.org/15cm/AMM.svg?branch=master)
Aria2 Menubar Monitor,  在 macOS 菜单栏上监控 Aria2 的工具。

# 功能
- 通过 Aria2 RPC 接口获取 Aria2 状态，显示在 menubar 中（走 websocket）
- 多服务器支持，可配置各个服务器状态和任务的刷新时间间隔
- 拖曳调整服务器顺序
- ws/wss(包括自签证书)支持
- 暗色主题
- 用于管理任务的控制模式
- 关联磁力链接

# 截图
## 亮色主题
![Screenshot Light](./screenshots/screenshot.png)

## 暗色主题
![Screenshot Dark](./screenshots/screenshot-dark.png)

# 运行环境
OS X 10.10+ or macOS 10.12.x

# 下载
见 [Release](https://github.com/15cm/AMM/releases)

# 测试、构建环境
- macOS Sierra 10.12.5
- Xcode 8.3.3 (8E3004b)
- Swift 3.1
- carthage 0.23.0

# 构建流程
``` sh
git clone https://github.com/15cm/AMM.git
cd AMM
carthage update --platform mac --no-use-binaries
open AMM.xcodeproj
```

然后在 **Xcode** 中按 Cmd-b 构建 **AMM**

# 感谢
- [aria2](https://github.com/aria2/aria2) 
- [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON)
- [Starscream](https://github.com/daltoniam/Starscream)
- [SwiftyUserDefaults](https://github.com/radex/SwiftyUserDefaults)
- [Maria](https://github.com/ShinCurry/Maria) （部分实现思路参考）

# 许可证书
GPL 3.0
