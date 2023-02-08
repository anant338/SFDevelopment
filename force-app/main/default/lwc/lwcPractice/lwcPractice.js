import { LightningElement,track } from 'lwc';

export default class LwcPractice extends LightningElement {
@track showtext =false;
@track cityList =['Patna','Delhi','Mumbai']
setBoolean(event){
    this.showtext =event.target.checked
}
}