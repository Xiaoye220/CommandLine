//
//  ChromiumOperation.swift
//  CommandLine
//
//  Created by YZF on 2019/12/25.
//  Copyright © 2019 Xiaoye. All rights reserved.
//

import Cocoa

class ChromiumOperation: NSObject, MyOperation {
    var options: [MyOption] = []
    
    override init() {
        let exportPathOption = BoolOption(shortFlag: "e",
                                           longFlag: "chromium_export_path",
                                        helpMessage: "Chromium 使用 depot_tools")
        
        options.append(MyOption(option: exportPathOption, sel: #selector(exportPath)))
    }
    
    @objc func exportPath() {
        let process = Process()
        process.launchPath = "/bin/bash"

        let cmd = """
        export PATH="$PATH:/Users/yezengfeng/Desktop/chromium/depot_tools"
        """

        process.arguments = ["-c", cmd]
        process.launch()
        process.waitUntilExit()
    }
}
