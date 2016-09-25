//
//  WMapView.h
//  Worcipe
//
//  Created by Manuel Alejandro on 14/09/16.
//
//

import Foundation

protocol WMapViewInterface
{
    func updateViewWithLocal(locals: [WLocal])
    func stopLoadingView()
}
