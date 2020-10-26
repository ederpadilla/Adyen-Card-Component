import UIKit
import Adyen

class ViewController: UIViewController, PaymentComponentDelegate {


    private var cardComponent : CardComponent!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewDidAppear(_ animated: Bool) {
        
        print("🚀🚀🚀🚀 ")
        let adyenDetails : [AdyenDetail] = [AdyenDetail(key: "encryptedCardNumber", type: "cardToken"),
                                            AdyenDetail(key: "encryptedSecurityCode", type: "cardToken"), AdyenDetail(key: "encryptedExpiryMonth", type: "cardToken"), AdyenDetail(key: "encryptedExpiryYear", type: "cardToken"), AdyenDetail(key: "holderName", type: "text")]
        let adyenPaymentMethod = AdyenPaymentMethod(name: "Tarjeta de Crédito", type: "scheme", brands: ["visa", "mc", "amex"], details: adyenDetails)
        
        let paymentMethods: [AdyenPaymentMethod] = [adyenPaymentMethod]
        let adyenPayments = AdyenPayments(paymentMethods: paymentMethods)

        if let cardPayment2 = adyenPaymentMethod.asCardPaymentMethod() {
            self.cardComponent = CardComponent(paymentMethod: cardPayment2,
            publicKey: "your-public-key")
            // Replace CardComponent with the payment method Component that you want to add.
            // Add additional required parameters if needed. For the CardComponent, you need the Client Encryption Public Key.
            cardComponent.delegate = self
            cardComponent.environment = .test
            // When you're ready to go live, change this to .live
            // or to other environment values described in https://adyen.github.io/adyen-ios/Docs/Structs/Environment.html
            cardComponent.payment = Payment(amount: Payment.Amount(value: .zero,
                                                                   currencyCode: "MXN"))
            
            // Optional. In this example, the Pay button will display 10 EUR.
            present(cardComponent.viewController, animated: true)
        }
    }

    func didSubmit(_ data: PaymentComponentData, from component: PaymentComponent) {
        cardComponent.stopLoading(withSuccess: true)
        print("🚀🚀🚀🚀 data \(data)")
        
    }
    
    func didFail(with error: Error, from component: PaymentComponent) {
        print("🚀🚀🚀 error \(error.localizedDescription)")
        cardComponent.stopLoading(withSuccess: false)
    }
    
    
    
}

