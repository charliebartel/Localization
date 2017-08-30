//: Playground - noun: a place where people can play

import UIKit

@objc enum TPString: Int {
    case
    upgrade_to_Premium,
    athleteThresholdPowerChange,
    athleteThresholdPowerChange2,
    w_upper
}

@objc class TPStrings: NSObject {
    class func localize(_ tpString: TPString) -> String {
        switch tpString {
        case .upgrade_to_Premium:
            return NSLocalizedString("Upgrade_to_Premium",
                                     value: "Upgrade to Premium",
                                     comment: "The user can tap this button to upgrade to premium")
        case .athleteThresholdPowerChange:
            return NSLocalizedString("notification_athlete_threshold_power_change",
                                     value: "You set a new power threshold of %@ %@ on %@",
                                     comment: "This is a notification message to the athlete that he/she has set a new power threshold on a date")
        case .athleteThresholdPowerChange2:
            return NSLocalizedString("notification_athlete_threshold_power_change2",
                                     value: "Du hast am %3$@ einen neuen Leistungsschwellenwert von %1$@ %2$@ festgelegt.",
                                     comment: "This is a notification message to the athlete that he/she has set a new power threshold on a date")
        case .w_upper: return NSLocalizedString("W",
                                                value: "W",
                                                comment: "Abbreviation for watts")
        }
    }
}

func tpLocalize(_ string: TPString) -> String {
    return TPStrings.localize(string)
}

func tpLocalizeWithArguments(_ format: TPString, _ arguments: CVarArg...) -> String {
    return String(format: TPStrings.localize(format), locale: Locale.current, arguments: arguments)
}

func tpPrint(_ text: String?) {
    print("\(text ?? "")")
}

///---------------------

// Before and After
let label = UILabel()
label.text = "Upgrade to Premium"
label.text = NSLocalizedString("Upgrade_to_Premium", value: "Upgrade to Premium", comment: "The user can tap this button to upgrade to premium")
label.text = tpLocalize(.upgrade_to_Premium)

// Handling multiple arguments

// The wrong way! Allow the translator to rearrange the arguments if necessary, do not build sentences in code
label.text = String(format: "%@ %@ %@ %@ %@", arguments: ["You set a new power threshold of", "293", "W", "on", "June 1st"])
tpPrint(label.text)

label.text = tpLocalizeWithArguments(.athleteThresholdPowerChange, String(293), tpLocalize(.w_upper), DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .none))
tpPrint(label.text)

// In German
label.text = tpLocalizeWithArguments(.athleteThresholdPowerChange2, String(293), tpLocalize(.w_upper), DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .none))
tpPrint(label.text)

public struct TPDateFormatter {
    public static let longFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateStyle = .full
        formatter.timeStyle = .full
        return formatter
    }()
}

label.text = TPDateFormatter.longFormatter.string(from: Date())
tpPrint(label.text)

let formatter = TPDateFormatter.longFormatter
formatter.locale = Locale(identifier: "DE")
label.text = formatter.string(from: Date())
tpPrint(label.text)

let numberFormatter = NumberFormatter()
numberFormatter.numberStyle = .decimal
numberFormatter.locale = Locale(identifier:"US")
label.text = numberFormatter.string(from: 25.443)
tpPrint(label.text)

let numberFormatter2 = NumberFormatter()
numberFormatter2.numberStyle = .decimal
numberFormatter2.locale = Locale(identifier:"DE")
label.text = numberFormatter2.string(from: 25.443)
tpPrint(label.text)

let stringValue2 = "25,443"
let number3 = Double(stringValue2)
let number4 = numberFormatter.number(from: stringValue2)
let number5 = numberFormatter2.number(from: stringValue2)

var components = PersonNameComponents()
components.givenName = "Charles"
components.familyName = "Bartel"
let nameFormatter = PersonNameComponentsFormatter()
label.text = nameFormatter.string(from: components)
tpPrint(label.text)







