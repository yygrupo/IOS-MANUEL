//
//  WLoginView.h
//  Worcipe
//
//  Created by Manuel Alejandro on 14/09/16.
//
//

import Foundation

protocol WLoginViewInterface
{
    func stopLoadingView()
    func userNotFound()
    func wrongPassword()
}
