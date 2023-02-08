import { LightningElement } from 'lwc';
import getRandomRecipe from "@salesforce/apex/RecipieSearch.getRandomRecipe";
import getRecipeByIngredients from "@salesforce/apex/RecipieSearch.getRecipeByIngredients";
export default class RecipeSearch extends LightningElement {
    recipeList =[];
    searchRecipe(){

        getRandomRecipe() .then((data)=>{
            this.recipeList =JSON.parse(data) && JSON.parse(data).recipes
            ? JSON.parse(data).recipes
            : [];
           }
        ) .catch((error)=> {
            console.error(error);
        }
       );
    }

    searchRecipeByIngredient(){
      const ingredients = this.template.querySelector(".ingredient-input").value;
      getRecipeByIngredients({ingredients}) .then((data) =>{
        this.recipeList = JSON.parse(data);
      } ) .catch((error)=> {
        console.error(error);
    }
   );
    }
}