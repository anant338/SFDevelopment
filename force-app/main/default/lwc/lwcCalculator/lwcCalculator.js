import { LightningElement, track } from 'lwc';

export default class LwcCalculator extends LightningElement {
    @track result;
    firstNum;
    secNum;
    resultHistory =[];
    showhistorychecked;

     numUpdate(event){
         const inputfield =event.target.name;
        if(inputfield ==="fNum"){
            this.firstNum =event.target.value;
        } else if(inputfield ==="sNum") {
            this.secNum = event.target.value;
        }
     };


    addNum() {
        const firstnbr =parseInt(this.firstNum);
        const secnbr = parseInt(this.secNum);
        this.result = `${firstnbr} + ${secnbr} = ${firstnbr + secnbr} `
        this.resultHistory.push(this.result )
    };

    subNum() {
        const firstnbr =parseInt(this.firstNum);
        const secnbr = parseInt(this.secNum);
        this.result = `${firstnbr} - ${secnbr} = ${firstnbr - secnbr} `
        this.resultHistory.push(this.result )
    };

    mulNum() {
        const firstnbr =parseInt(this.firstNum);
        const secnbr = parseInt(this.secNum);
        this.result = `${firstnbr} * ${secnbr} = ${firstnbr*secnbr} `
        this.resultHistory.push(this.result )
    };

    divNum() {
        const firstnbr =parseInt(this.firstNum);
        const secnbr = parseInt(this.secNum);
        if (secnbr===0) {
            this.result = `${firstnbr} / ${secnbr} = Divide by Zero Error`;  
        } else {
        this.result = `${firstnbr} / ${secnbr} = ${firstnbr / secnbr} `
        }
        this.resultHistory.push(this.result )
    }

    showHistory(event) {
        this.showhistorychecked= event.target.checked
    }

}