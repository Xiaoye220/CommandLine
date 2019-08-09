//
//  ShellOperation.swift
//  CommandLine
//
//  Created by YZF on 2019/8/9.
//  Copyright © 2019 Xiaoye. All rights reserved.
//

import Foundation


class ShellOperation: NSObject, MyOperation {
    
    public var options: [MyOption] = []
    
    override init() {
        let chmodOption = BoolOption(longFlag: "chmod",
                                       helpMessage: "--chmod")
        options.append(MyOption(option: chmodOption, sel: #selector(chmod)))
    }
    
    @objc func chmod() {
        print("输入文件路径:")
        // 读取用户输入的值
        let keyboard = FileHandle.standardInput
        let inputData = keyboard.availableData
        var strData = String(data: inputData, encoding: String.Encoding.utf8)!
        // 删除最后的换行符
        strData.removeLast()
        
        let process = Process()
        process.launchPath = "/bin/bash"

        let cmd = """
        path=\(strData)

        dir=${path%/*}
        file=${path##*/}

        cd $dir

        chmod a+x "./"$file
        """

        process.arguments = ["-c", cmd]
        process.launch()
        process.waitUntilExit()
    }
    
}
