//
//  Models.swift
//  CryptoAssets
//
//  Created by Ben Seferidis on 11/10/22.
//

import Foundation

struct Crypto:Codable{

    let id:Int
    let image_url:String
    let name:String
 
}

struct Icon:Codable{
    let image_url:String
}
