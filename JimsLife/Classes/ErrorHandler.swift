//
//  ErrorHandler.swift
//  JimsLife
//
//  Created by Henrik Schnettler on 12.02.23.
//

import Foundation

final class ErrorHandler: ObservableObject {
    enum Error: LocalizedError {
        case linkSupplementValidation
        case removeSupplementValidation

        var errorDescription: String? {
            switch self {
            case .linkSupplementValidation:
                return NSLocalizedString("Error while adding supplement", comment: "")
            case .removeSupplementValidation:
                return NSLocalizedString("Error while removing supplement", comment: "")
            }
        }

        var recoverySuggestion: String? {
            switch self {
            case .linkSupplementValidation:
                return NSLocalizedString("the supplement couldnt be added to your supplements", comment: "")
            case .removeSupplementValidation:
                return NSLocalizedString("the supplement couldnt be removed from your supplements", comment: "")
            }
            
        }
    }

    @Published var title: String = ""
    @Published var error: Swift.Error?
    
    func selectError(ErrorCase: Error) {
        error = ErrorCase
    }
}
