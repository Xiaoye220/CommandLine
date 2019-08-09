//
//  MyOption.swift
//  CommandLine
//
//  Created by YZF on 2019/8/9.
//  Copyright © 2019 Xiaoye. All rights reserved.
//

import Foundation

struct MyOption {
    var option: Option
    var sel: Selector
    
    var value: Any? {
        if let option = option as? StringOption {
            return option.value
        } else if let option = option as? BoolOption {
            return option.value
        } else if let option = option as? IntOption {
            return option.value
        } else if let option = option as? CounterOption {
            return option.value
        } else if let option = option as? DoubleOption {
            return option.value
        } else if let option = option as? MultiStringOption {
            return option.value
        }
        
        return nil
    }
}
