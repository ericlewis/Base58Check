import Foundation

public protocol Base58CheckEncoding {
    func encode(data: Data) -> String
}

public protocol Base58CheckDecoding {
    func decode(string: String) throws -> Data
}

public typealias Base58CheckCoding = Base58CheckEncoding & Base58CheckDecoding
