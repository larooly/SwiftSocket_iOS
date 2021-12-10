//
//  AES256Util.swift
//  AngrySocketSwift
//
//  Created by active on 2021/08/10.
//

import Foundation
import CryptoSwift
import CommonCrypto


class AES256Util {
    //키값 32바이트: AES256(24bytes: AES192, 16bytes: AES128)
    private static let SECRET_KEY = "+CXu6KzgkUm?C4a=aSbRJFJh3$eCAkwT"//"01234567890123450123456789012345"
    private static var IV = "0000000000000000"//"0000000000000000"//0000/0000/0000/0000"0123456789012345"
    // 아니 저거 null이면 모두 0 인 값을 사용한다는데?
    
    
    static func encrypt(string: String) -> String {
        guard !string.isEmpty else { return "" }
        return try! getAESObject().encrypt(string.bytes).toBase64()
    }

    static func decrypt(encoded: String) -> String {
        let datas = Data(base64Encoded: encoded)

        guard datas != nil else {
            return ""
        }

        let bytes = datas!.bytes
        let decode = try! getAESObject().decrypt(bytes)

        return String(bytes: decode, encoding: .utf8) ?? ""
    }

    private static func getAESObject() -> AES{
        let keyDecodes : Array<UInt8> = Array(SECRET_KEY.utf8)
        let ivDecodes : Array<UInt8> = [UInt8](repeating: 0x00, count: 16) // Array(IV.utf8)// 그때 여기였나? 초기화 똑바로 안된곳이
        let aesObject = try! AES(key: keyDecodes, blockMode: CBC(iv: ivDecodes), padding: .pkcs5)

        return aesObject
    }
}
