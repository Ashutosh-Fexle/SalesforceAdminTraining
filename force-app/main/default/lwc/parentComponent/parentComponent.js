// parentComponent.js
import { LightningElement, track } from "lwc";

export default class BindHTML extends LightningElement 
{
  @track state = {
    myValue : "Salesforce Bolt",
  };

  handleChange(event) 
  {
    this.state.myValue = event.target.value;
  }
}

/*

import { LightningElement , track} from 'lwc';


export default class ParentComponent extends LightningElement
{
    @track greeting = 'World, Dynamic Greeting From Parent Component';


    @track myValue;


    handleChange(event) {
      this.myValue = event.target.value;
      console.log('this.myValue', this.myValue);
    }
}

*/