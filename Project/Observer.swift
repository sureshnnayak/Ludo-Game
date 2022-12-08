//
//  Observer.swift
//  Project
//
//  Created by Raasa on 08/12/22.
//

import Foundation

protocol Publisher{
    func registerSubscriber(sub:Subscriber)
    func removeSubscriber(sub:Subscriber)
    func notifySubscribers(message: String)
}

protocol Subscriber{
    func update(message: String)
}

class EventManager : Publisher {
    
    //Gives the list of current listeners
    var listeners : [Subscriber] = []

    // New subscriber is added to list of listeners using this method
    func registerSubscriber(sub:Subscriber) {
        listeners.append(sub);
    }

    // A subscriber is removed from list of listeners using this method
    func removeSubscriber(sub:Subscriber) {
        listeners.remove(at: 0)
    }

    // All subscribers are notified of any event using this method
    func notifySubscribers( message: String) {
        for obv in listeners{
            obv.update(message:message);
        }
    }
}
