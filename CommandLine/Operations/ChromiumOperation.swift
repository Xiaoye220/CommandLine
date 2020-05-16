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
        let setupGNOption = BoolOption(longFlag: "gn",
                                       helpMessage: "Chromium setup GN")

        let startGomaOption = BoolOption(longFlag: "goma",
                                         helpMessage: "Chromium start Goma")

        options.append(MyOption(option: setupGNOption, sel: #selector(setupGN)))
        options.append(MyOption(option: startGomaOption, sel: #selector(startGoma)))
    }
    
    @objc func setupGN() {
        let process = Process()
        process.launchPath = "/bin/zsh"

        let cmd = """
        vpython ~/Desktop/anaheim/src/ios/build/tools/setup-gn.py
        """

        process.arguments = ["-c", cmd]
        process.launch()
        process.waitUntilExit()
    }

    @objc func startGoma() {
        let process = Process()
        process.launchPath = "/bin/zsh"

        let cmd = """
        vpython ~/Desktop/anaheim/tools/goma-mac/goma_ctl.py ensure_start
        """

        process.arguments = ["-c", cmd]
        process.launch()
        process.waitUntilExit()
    }
}
