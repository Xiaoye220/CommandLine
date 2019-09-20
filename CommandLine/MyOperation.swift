//
//  MyOperation.swift
//  CommandLine
//
//  Created by YZF on 2019/8/9.
//  Copyright © 2019 Xiaoye. All rights reserved.
//

import Foundation

protocol MyOperation: NSObjectProtocol {
    var options: [MyOption] { get set }
    
    func addOptions(to cli: CommandLine)
    
    func performOptions()
}


extension MyOperation {
    
    func addOptions(to cli: CommandLine) {
        self.options.forEach { option in
            cli.addOptions(option.option)
        }
    }
    
    func performOptions() {
        self.options.forEach { myOption in
            if let boolOption = myOption.option as? BoolOption {
                if boolOption.value {
                    self.perform(myOption.sel, with: boolOption.value)
                }
            } else {
                if let value = myOption.value {
                    self.perform(myOption.sel, with: value)
                }
            }
        }
    }
    
}
