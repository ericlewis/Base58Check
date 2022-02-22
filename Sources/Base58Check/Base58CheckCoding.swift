public protocol Base58CheckEncoding {
    func encode(bytes: [UInt8]) -> String
}

public protocol Base58CheckDecoding {
    func decode(string: String) throws -> [UInt8]
}

public typealias Base58CheckCoding = Base58CheckEncoding & Base58CheckDecoding
