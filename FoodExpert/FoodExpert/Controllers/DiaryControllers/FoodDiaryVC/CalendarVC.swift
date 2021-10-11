import UIKit

class CalendarVC: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let date = CoreDataManger.shared.currentSelectedDate {
            datePicker.setDate(date, animated: false)
        }
        definesPresentationContext = true
        self.view.backgroundColor = .clear
        self.view.isOpaque = false
        self.view.tintColor = .clear
        modalPresentationStyle = .overCurrentContext
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch? = touches.first
        if touch?.view != datePicker {
            CoreDataManger.shared.updateNote(by: datePicker.date)
            dismiss(animated: true, completion: nil)
        }
    }

    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        CoreDataManger.shared.updateNote(by: sender.date)
        NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: "dateChanged"), object: nil)
    }

}
