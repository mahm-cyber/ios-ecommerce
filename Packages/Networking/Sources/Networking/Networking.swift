// The Swift Programming Language
// https://docs.swift.org/swift-book

import Core


public struct NetworkingManager {
    let core: CoreManager
    
    init(core: CoreManager) {
        self.core = core
    }
}
