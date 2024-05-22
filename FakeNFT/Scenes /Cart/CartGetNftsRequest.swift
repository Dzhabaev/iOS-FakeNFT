import Foundation

struct CartGetNftsRequest: NetworkRequest {
    var httpMethod: HttpMethod = .get
    
    var dto: Encodable?
    
    var httpBody: String?
    
    var endpoint: URL?
    init(nftId: String) {
        guard let endpoint = URL(string: "https://d5dn3j2ouj72b0ejucbl.apigw.yandexcloud.net/api/v1/nft/\(nftId)") else { return }
        self.endpoint = endpoint
    }
}
