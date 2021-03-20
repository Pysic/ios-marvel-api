//
//  CreateApiUrl.swift
//  marvel
//
//  Created by Pietro Rischi Nunes (E) on 18/03/21.
//

import Foundation
import var CommonCrypto.CC_MD5_DIGEST_LENGTH
import func CommonCrypto.CC_MD5
import typealias CommonCrypto.CC_LONG

struct ApiUrlUtils {
    static private var pageCount: Int = 0
    private let totalResults: Int = 8
    
    public func getPageCount() -> Int{
        let count = ApiUrlUtils.pageCount
        ApiUrlUtils.pageCount = count + totalResults
        return count
    }
    
    public func resetPageCount(){
        ApiUrlUtils.pageCount = 0
    }
    
    public func encodeMD5(concatenateStringKeys: String) -> Data {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        let messageData = concatenateStringKeys.data(using:.utf8)!
        var digestData = Data(count: length)

        _ = digestData.withUnsafeMutableBytes { digestBytes -> UInt8 in
            messageData.withUnsafeBytes { messageBytes -> UInt8 in
                if let messageBytesBaseAddress = messageBytes.baseAddress, let digestBytesBlindMemory = digestBytes.bindMemory(to: UInt8.self).baseAddress {
                    let messageLength = CC_LONG(messageData.count)
                    CC_MD5(messageBytesBaseAddress, messageLength, digestBytesBlindMemory)
                }
                return 0
            }
        }
        return digestData
    }
}
