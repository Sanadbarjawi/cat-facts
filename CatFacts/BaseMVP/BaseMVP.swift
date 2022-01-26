//
//  BaseMVP.swift
//  CatFacts
//
//  Created by sanad barjawi on 26/01/2022.
//

import UIKit

open class BaseMVPController<P: Presentable, V>: UIViewController {
    typealias View = V
    
    public private(set) var presenter: P?
    
    open func createPresenter() -> P? {
        return presenter
    }
    
    // MARK: - Initializers
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        presenter = createPresenter()
    }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        presenter = createPresenter()
    }
    
    // MARK: - Lifecycle
    open override func viewWillAppear(_ animated: Bool) {
        guard self is P.View else { //triggering a run time error if controller didn't implement the view protocol"
            preconditionFailure("MVP ViewController must implement the view protocol `\(View.self)`!")
        }
        super.viewWillAppear(animated)
    }

    
    deinit {//to avoid any memory leaks
        guard let _ = self as? P.View else {return}
        if let presenter = presenter {
            presenter.detachView()
        }
    }
    
}
