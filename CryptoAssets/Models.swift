//
//  Models.swift
//  CryptoAssets
//
//  Created by Ben Seferidis on 11/10/22.
//

import Foundation


//
//struct CryptoAssets:Codable{
//
////    let next:String
////    let previous = NSNull()
//    let assets: [Crypto]
//}

struct Crypto:Codable{

    let id:Int
    let image_url:String
    let name:String
 
}

struct Icons:Codable{
    let image_url:String
}

//struct Crypto:Codable{
//
//    let name:String
//    let id:String
//    let image:URL
//
//
//
//}
//
////struct CryptoassetsItem:Codable{
////
////    let id:Int
////    let image_thumbnail_url:URL
////    let name:String
////
////}

