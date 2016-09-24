//
//  WLocalView.h
//  Worcipe
//
//  Created by Manuel Alejandro on 13/09/16.
//
//

import Foundation

protocol WLocalViewInterface
{
    func updateViewWithLocal(locals: [WLocal])
    func stopLoadingView()
}
