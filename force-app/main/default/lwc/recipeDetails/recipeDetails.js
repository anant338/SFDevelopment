import { LightningElement,api } from 'lwc';

export default class RecipeDetails extends LightningElement {
    @api image;
    @api title;
    @api price;
    @api readyInMinutes;
    @api summary;
}