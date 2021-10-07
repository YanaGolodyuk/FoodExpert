import UIKit

class RecipeDetailVC: UIViewController {

    var recipes: Recipe?
    
    @IBOutlet weak var recipeImage: UIImageView!
    
    @IBOutlet weak var recipeNameLbl: UILabel!
    
    @IBOutlet weak var caloriesCountLbl: UILabel!
    @IBOutlet weak var proteinsCountLbl: UILabel!
    @IBOutlet weak var fatsCountLbl: UILabel!
    @IBOutlet weak var carbsCountLbl: UILabel!
    
    @IBOutlet weak var recipeTextLbl: UILabel!
    
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
        caloriesCountLbl.text = "\(Int(recipe.calories))"
        proteinsCountLbl.text = "\(Int(recipe.totalNutrients.PROCNT.quantity)) \(recipe.totalNutrients.PROCNT.unit)"
        fatsCountLbl.text = "\(Int(recipe.totalNutrients.FAT.quantity)) \(recipe.totalNutrients.FAT.unit)"
        carbsCountLbl.text = "\(Int(recipe.totalNutrients.CHOCDF.quantity)) \(recipe.totalNutrients.CHOCDF.unit)"
        recipeTextLbl.text = recipe.ingredientLines.joined(separator: ",\n ")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
