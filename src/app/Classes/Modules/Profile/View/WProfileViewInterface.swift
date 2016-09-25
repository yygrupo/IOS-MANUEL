//
//  WProfileView.h
//  Worcipe
//
//  Created by Manuel Alejandro on 14/09/16.
//
//

import Foundation

protocol WProfileViewInterface
{
    func stopLoadingView()
    func updateViewWithUser(user: WUser)
}
