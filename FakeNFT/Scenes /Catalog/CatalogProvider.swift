//
//  CatalogProvider.swift
//  FakeNFT
//
//  Created by Chingiz on 23.04.2024.
//

import Foundation

// MARK: - CatalogProvider

protocol CatalogProvider {
    func getCatalog(completion: @escaping ([CatalogModel]) -> Void)
}

// MARK: - CatalogProviderImpl

final class CatalogProviderImpl: CatalogProvider {
    
    func getCatalog(completion: @escaping ([CatalogModel]) -> Void) {
        DispatchQueue.main.async {
            completion(CatalogModel.mockCatalog)
        }
    }
}

// MARK: - Mock catalog extension

private extension CatalogModel {
    static var mockCatalog: [CatalogModel] {
        [
            CatalogModel(
                image: URL(string: "https://s3-alpha-sig.figma.com/img/727b/b319/2163ae99ca0449e797b557a9d12b3f70?Expires=1714953600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=J1w7iyAq82bT3qxQTRWby1pCfPXh2mXdU4zVP9r1Jz2Y5Ye12tEHoI7nOrzSJxjo7zmhbV7EXF2Wm3BSMBcNPcKZUEBTja7wA21iRnvKwxANaNGu7SYxO49f~ZOkXcaw-cqU3F243eVZn1gr~VsCwNsWti7xXT4QnNwJvNGbpXhs7cs6pcZS2LRH0V8d3-MUfF7fUbCO9a~rzol4ej6DloICktABi6~l-VlfnO8B-rVC7GqP1QYSj-skCELhXZ-5zaQODvpTbz6QuBEgZGSPgdxZHGLwAdX6rBXCQ8LNS36c69FLRD8CtAIJU0iA6X4i78nXgsVJ0bBqn9l34~0jiQ__")!,
                title: "First catalog",
                count: 11
            ),
            
            CatalogModel(
                image: URL(string: "https://s3-alpha-sig.figma.com/img/785b/10e1/a2f1bd29714ad4c0bae201c3ae0254ee?Expires=1714953600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=P3ZLSrt684Z~aF~fy8K1Gn-Ou0UOHnQFILEmQVFLfJdx9RnkN7QRKdJy8PXTLR9gP~NmlWE-IhLpxysejeDPrgpjiVtrxbnWRrYwIrS7G-s7S~mvKqOLlHEUD1-~5arQC58sdM8OkbucgF0Oy4lGGgdKUd1fhNRvPTrp7cgSrknwhUkJsd9bEAaHCvn2RPv2pAma8FNGmb5Vv~Rl37kLWof9EqLM3NZJntCTOHDvBq8gEBVfzpqY-VeDXjVxBaLGH0AJueFMx0pbFZiosFw2SdE~9vbS9RCoHiWNmc385KXYY1EVo4xb~w0ku9ApX2Ar0IhlApGHFMjkMHCkX~gY4g__")!,
                title: "Second catalog",
                count: 6
            ),
            
            CatalogModel(
                image: URL(string: "https://s3-alpha-sig.figma.com/img/084b/d305/7ae145555932a6a6ab3903b4c3144b50?Expires=1714953600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=dNtbfM2FFY5P-gQ8Hpgvz56MiAMMs6zgzeGeY9LxjyVDQg8SDYEoVk2RwOwrd4gg1HZYKOvQhCk6H-BQ1n13gIlVF68F997vXpTIOk7NvV2txxzynQDcVW2FalFTWdkOXHfnmUXScu8PZkb9Qcy4VcxRSH8xneout0QY-KD6DfjtIDCsU2QFOwaMfwSdmFKCIfI2RhfArWOOuyEWRjIY0BMTnPW-In5AWr4Jvb-afofQ2V7zsD4uhaxz8QMsO5E3Vir~HTcootwPJAPSseVwMr021RAvHz0FXUjRaiEkx8E0YM0Pn3pZmxgS-qwqpumbRevUSHCeQSQTofx4aNiMQg__")!,
                title: "First catalog",
                count: 8
            ),
            
            CatalogModel(
                image: URL(string: "https://s3-alpha-sig.figma.com/img/727b/b319/2163ae99ca0449e797b557a9d12b3f70?Expires=1714953600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=J1w7iyAq82bT3qxQTRWby1pCfPXh2mXdU4zVP9r1Jz2Y5Ye12tEHoI7nOrzSJxjo7zmhbV7EXF2Wm3BSMBcNPcKZUEBTja7wA21iRnvKwxANaNGu7SYxO49f~ZOkXcaw-cqU3F243eVZn1gr~VsCwNsWti7xXT4QnNwJvNGbpXhs7cs6pcZS2LRH0V8d3-MUfF7fUbCO9a~rzol4ej6DloICktABi6~l-VlfnO8B-rVC7GqP1QYSj-skCELhXZ-5zaQODvpTbz6QuBEgZGSPgdxZHGLwAdX6rBXCQ8LNS36c69FLRD8CtAIJU0iA6X4i78nXgsVJ0bBqn9l34~0jiQ__")!,
                title: "First catalog",
                count: 0
            ),
            
            CatalogModel(
                image: URL(string: "https://s3-alpha-sig.figma.com/img/785b/10e1/a2f1bd29714ad4c0bae201c3ae0254ee?Expires=1714953600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=P3ZLSrt684Z~aF~fy8K1Gn-Ou0UOHnQFILEmQVFLfJdx9RnkN7QRKdJy8PXTLR9gP~NmlWE-IhLpxysejeDPrgpjiVtrxbnWRrYwIrS7G-s7S~mvKqOLlHEUD1-~5arQC58sdM8OkbucgF0Oy4lGGgdKUd1fhNRvPTrp7cgSrknwhUkJsd9bEAaHCvn2RPv2pAma8FNGmb5Vv~Rl37kLWof9EqLM3NZJntCTOHDvBq8gEBVfzpqY-VeDXjVxBaLGH0AJueFMx0pbFZiosFw2SdE~9vbS9RCoHiWNmc385KXYY1EVo4xb~w0ku9ApX2Ar0IhlApGHFMjkMHCkX~gY4g__")!,
                title: "Second catalog",
                count: 999
            ),
            
            CatalogModel(
                image: URL(string: "https://s3-alpha-sig.figma.com/img/084b/d305/7ae145555932a6a6ab3903b4c3144b50?Expires=1714953600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=dNtbfM2FFY5P-gQ8Hpgvz56MiAMMs6zgzeGeY9LxjyVDQg8SDYEoVk2RwOwrd4gg1HZYKOvQhCk6H-BQ1n13gIlVF68F997vXpTIOk7NvV2txxzynQDcVW2FalFTWdkOXHfnmUXScu8PZkb9Qcy4VcxRSH8xneout0QY-KD6DfjtIDCsU2QFOwaMfwSdmFKCIfI2RhfArWOOuyEWRjIY0BMTnPW-In5AWr4Jvb-afofQ2V7zsD4uhaxz8QMsO5E3Vir~HTcootwPJAPSseVwMr021RAvHz0FXUjRaiEkx8E0YM0Pn3pZmxgS-qwqpumbRevUSHCeQSQTofx4aNiMQg__")!,
                title: "First catalog",
                count: 4
            )
        ]
    }
}
