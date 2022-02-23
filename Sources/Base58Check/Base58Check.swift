import Foundation
import CryptoKit
import Base58

public struct Base58Check {
    private static let checksumLength = 4

    private let base58: Base58Coding

    public init(base58: Base58Coding = Base58()) {
        self.base58 = base58
    }
}

// MARK: - Base58CheckEncoding
extension Base58Check: Base58CheckEncoding {
    public func encode(data: Data) -> String {
        base58.encode(
            data: data + checksum(data: data)
        )
    }
}

// MARK: - Base58CheckDecoding
extension Base58Check: Base58CheckDecoding {
    public func decode(string: String) throws -> Data {
        do {
            let decodedData = try base58.decode(string: string)
            let decodedChecksum = decodedData.suffix(Self.checksumLength)
            let decodedDataWithoutChecksum = decodedData.dropLast(Self.checksumLength)
            guard decodedChecksum == checksum(data: decodedDataWithoutChecksum) else {
                throw Base58CheckError.invalidDecoding
            }
            return decodedDataWithoutChecksum
        } catch {
            throw Base58CheckError.invalidDecoding
        }
    }
}

// MARK: - Helpers
fileprivate extension Base58Check {
    func sha256(data: Data) -> Data {
        .init(SHA256.hash(data: data))
    }

    func doubleSHA256(data: Data) -> Data {
        sha256(data: sha256(data: data))
    }

    func checksum(data: Data) -> Data {
        doubleSHA256(data: data).prefix(Self.checksumLength)
    }
}
