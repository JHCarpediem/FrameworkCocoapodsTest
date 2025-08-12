//
//  UIControl+TDExtension.swift
//  TDBasis
//
//  Created by fench on 2023/8/1.
//

import UIKit

fileprivate var kUIControlBlockTarget: Void?
fileprivate class TDUIControlBlockTarget: NSObject {
    var block: ((Any)->Void)?
    var events: UIControl.Event!
    
    required convenience init(block: ((Any)->Void)?, events: UIControl.Event) {
        self.init()
        self.block = block
        self.events = events
    }
    
    @objc func invoke(_ sender: Any) {
        self.block?(sender)
    }
}

extension UIControl {
    fileprivate var _allUIControlBlockTargets: [TDUIControlBlockTarget] {
        get {
            guard let targes = objc_getAssociatedObject(self, &kUIControlBlockTarget) as? [TDUIControlBlockTarget] else {
                let resulet: [TDUIControlBlockTarget] = []
                objc_setAssociatedObject(self, &kUIControlBlockTarget, resulet, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return resulet
            }
            return targes
        }
        set {
            objc_setAssociatedObject(self, &kUIControlBlockTarget, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

extension UIControl: TDCompatible {}
extension TDBasisWrap where Base: UIControl {
    
    /// Removes all targets and actions for a particular event (or events) from an internal dispatch table.
    public func removeAllTargets() {
        base.removeAllTargets()
    }
    
    /// Adds or replaces a target and action for a particular event (or events) to an internal dispatch table.
    public func setTarget(_ target: Any?, action: Selector, for event:UIControl.Event) {
        base.setTarget(target, action: action, for: event)
    }
    
    /// Adds a block for a particular event (or events) to an internal dispatch table. It will cause a strong reference to @a block.
    public func addblock(for controlEvents: UIControl.Event, block: ((_ sender: Any)->Void)?) {
        base.addblock(for: controlEvents, block: block)
    }
    
    /// Adds or replaces a block for a particular event (or events) to an internal dispatch table. It will cause a strong reference to @a block.
    public func setBlock(for controlEvents: UIControl.Event, block: ((_ sender: Any)->Void)?) {
        base.setBlock(for: controlEvents, block: block)
    }
    
    /// Removes all blocks for a particular event (or events) from an internal dispatch table.
    public func removeAllBlocks(for controlEvents: UIControl.Event) {
        base.removeAllBlocks(for: controlEvents)
    }
}

extension UIControl {
    @objc(td_removeAlltargets)
    /// Removes all targets and actions for a particular event (or events) from an internal dispatch table.
    public func removeAllTargets(){
        allTargets.forEach { self.removeTarget($0, action: nil, for: .allEvents) }
        _allUIControlBlockTargets.removeAll()
    }
    
    @objc(td_setTarget:action:forControlEvent:)
    /// Adds or replaces a target and action for a particular event (or events) to an internal dispatch table.
    public func setTarget(_ target: Any?, action: Selector, for event:UIControl.Event) {
        guard let target = target else {
            return
        }
        allTargets.forEach { currentTarget in
            let actions = actions(forTarget: currentTarget, forControlEvent: event)
            actions?.forEach { currentAction in
                removeTarget(currentTarget, action: NSSelectorFromString(currentAction), for: event)
            }
        }
        addTarget(target, action: action, for: event)
    }
    
    @objc(td_addBlockForControlEvents:block:)
    /// Adds a block for a particular event (or events) to an internal dispatch table. It will cause a strong reference to @a block.
    public func addblock(for controlEvents: UIControl.Event, block: ((_ sender: Any)->Void)?) {
        let target = TDUIControlBlockTarget(block: block, events: controlEvents)
        addTarget(target, action: #selector(TDUIControlBlockTarget.invoke(_:)), for: controlEvents)
        _allUIControlBlockTargets.append(target)
    }
    
    @objc(td_setBlockForControlEvents:block:)
    /// Adds or replaces a block for a particular event (or events) to an internal dispatch table. It will cause a strong reference to @a block.
    public func setBlock(for controlEvents: UIControl.Event, block: ((_ sender: Any)->Void)?) {
        removeAllBlocks(for: controlEvents)
        addblock(for: controlEvents, block: block)
    }
    
    @objc(td_removeAllBlocksForControlEvents:)
    /// Removes all blocks for a particular event (or events) from an internal dispatch table.
    public func removeAllBlocks(for controlEvents: UIControl.Event) {
        var removes: [TDUIControlBlockTarget] = []
        _allUIControlBlockTargets.forEach { target in
            let newEvent = target.events.rawValue & (~controlEvents.rawValue)
            if newEvent == 0 {
                removeTarget(target, action: #selector(TDUIControlBlockTarget.invoke(_:)), for: target.events)
                removes.append(target)
            } else {
                removeTarget(target, action: #selector(TDUIControlBlockTarget.invoke(_:)), for: target.events)
                target.events = UIControl.Event(rawValue: newEvent)
                addTarget(target, action: #selector(TDUIControlBlockTarget.invoke(_:)), for: target.events)
            }
        }
        _allUIControlBlockTargets.removeAll(where: { removes.contains($0) })
    }
}
