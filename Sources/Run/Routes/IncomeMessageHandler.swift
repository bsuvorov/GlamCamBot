import Foundation

extension Droplet {
    
    func handleIncomeMessage(subscriber: Subscriber, incomingMessage: String? = nil) {
        analytics?.logDebug("Entered - existing user flow")
        if let message = incomingMessage {
            let lowercasedMessage = message.lowercased()
            analytics?.logIncomingMessage(subscriber: subscriber, message: message)
            if lowercasedMessage == "test payments" {
                let test = TestPayments(console: drop.console)
                do {
                    try test.run(arguments: [subscriber.fb_messenger_id])
                } catch let error {
                    analytics?.logError("Failed to proccess the payment: \(error)")
                    return
                }
            } else if lowercasedMessage == "test shopping" {
                let test = TestShopping(console: drop.console)
                do {
                    try test.run(arguments: [subscriber.fb_messenger_id])
                } catch let error {
                    analytics?.logError("Failed to proccess the shopping flow: \(error)")
                    return
                }
            }
//            self.send(message: "I'm not sure what you mean, try saying \"Go\"",
//                      senderId: subscriber.fb_messenger_id,
//                      messagingType: .RESPONSE)
            
        } else {
            analytics?.logDebug("Entered - incoming message is nil. Ignore this message.")
        }
    }
}
