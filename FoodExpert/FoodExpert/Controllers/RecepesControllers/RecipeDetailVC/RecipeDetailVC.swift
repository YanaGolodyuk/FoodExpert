import UIKit
import WebKit

class RecipeDetailVC: UIViewController {
    
    var recipes: Recipe?
    
    @IBOutlet weak var recipeImage: UIImageView!
    
    @IBOutlet weak var recipeNameLbl: UILabel!
    
    @IBOutlet weak var caloriesCountLbl: UILabel!
    @IBOutlet weak var proteinsCountLbl: UILabel!
    @IBOutlet weak var fatsCountLbl: UILabel!
    @IBOutlet weak var carbsCountLbl: UILabel!
    @IBOutlet weak var ingridientLineLbl: UILabel!
    
    @IBOutlet weak var recipeWebView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Recipe"
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        recipeImage.image = nil
        configure()
    }
    
    func configure() {
        guard let recipe = recipes else { return }
        recipeImage.sd_setImage(with: URL(string: recipe.image), placeholderImage: UIImage(named: "recipe_placeholder.png"))
        recipeNameLbl.text = recipe.label
        caloriesCountLbl.text = "\(Int(recipe.calories)) kcal"
        proteinsCountLbl.text = "\(Int(recipe.totalNutrients.PROCNT.quantity)) \(recipe.totalNutrients.PROCNT.unit)"
        fatsCountLbl.text = "\(Int(recipe.totalNutrients.FAT.quantity)) \(recipe.totalNutrients.FAT.unit)"
        carbsCountLbl.text = "\(Int(recipe.totalNutrients.CHOCDF.quantity)) \(recipe.totalNutrients.CHOCDF.unit)"
        ingridientLineLbl.text = recipe.ingredientLines.joined(separator: ",\n ")
        
        let url = URL (string: recipe.url)
        let request = URLRequest(url: url!)
        recipeWebView.load(request)
    }
}

