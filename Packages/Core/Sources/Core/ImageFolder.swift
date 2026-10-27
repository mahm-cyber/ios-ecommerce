//
//  ImageFolderName.swift
//  Core
//
//  Created by NamaaIT Apple3 on 26/10/2026.
//

public enum ImageFolderName: String, Sendable {
    
    case uploads ,
         images ,
         products ,
         brands ,
         categories ,
         attributes ,
         advertisements ,
         generalImages ,
         choices ,
         offers ,
         articles ,
         pointsLevels ,
         ourClients ,
         payments
}

public enum ImageFolderType: String, Sendable {
    case    none = "",
            flag ,
            thumbnail,
            medium ,
            original ,
            payments
}
