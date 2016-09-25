//
//  WSearchView.h
//  Worcipe
//
//  Created by Manuel Alejandro on 13/09/16.
//
//

import Foundation

protocol WSearchViewInterface
{
    func updateViewWithCategories(categories: [WCategory])
    func stopLoadingView()
}
