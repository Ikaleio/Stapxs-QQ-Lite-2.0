import Foundation
import Capacitor
import os

/**
 * https://capacitorjs.com/docs/plugins/ios
 */
@available(iOS 14.0, *)
@objc(OnebotPlugin)
public class OnebotPlugin: CAPPlugin, CAPBridgedPlugin {
    public let identifier = "OnebotPlugin"
    public let jsName = "Onebot"
    public let pluginMethods: [CAPPluginMethod] = [
        CAPPluginMethod(name: "connect", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "close", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "send", returnType: CAPPluginReturnPromise)
    ]
    private let implementation = Onebot()
    private let logger = Logger()

    override public func load() {
        super.load()
        logger.info(" _____ _____ _____ _____ __ __  ")
        logger.info("|   __|_   _|  _  |  _  |  |  | ")
        logger.info("|__   | | | |     |   __|-   -| ")
        logger.info("|_____| |_| |__|__|__|  |__|__| CopyRight © Stapx Steve")
        logger.info("=======================================================")
        logger.info("Capacitor Onebot 基础连接器加载完成")
        logger.info("当前执行平台：iOS / iPadOS")
        logger.info("** 此插件 swift 版本代码 95% 由 Github Copilot 及 OpenAI ChatGPT 4o 生成 **")
    }

    @objc func connect(_ call: CAPPluginCall) {
        // 注册 implementation 的 onEvent 回调，需要判断下有没有注册过
        if implementation.onEvent == nil {
            implementation.onEvent = { type, data in
                self.notifyListeners("onebot:event", data: [ "type": type, "data": data ])
            }
        }

        let url = call.getString("url") ?? ""
        call.resolve([
            "value": implementation.connect(url)
        ])
    }

    @objc func close(_ call: CAPPluginCall) {
        call.resolve([
            "value": implementation.close()
        ])
    }

    @objc func send(_ call: CAPPluginCall) {
        let data = call.getString("data") ?? ""
        call.resolve([
            "value": implementation.send(data)
        ])
    }

}
