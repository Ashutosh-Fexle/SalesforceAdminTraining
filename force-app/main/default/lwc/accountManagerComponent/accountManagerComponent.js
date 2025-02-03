import { LightningElement , track , wire } from 'lwc';
import accList from '@salesforce/apex/AccountController.accountRecordsList';

const columns = [
    { label: 'Name', fieldName : 'Name'},
    { label: 'Id' , fieldName: 'Id'},
    { label: 'Annual Revenue' , fieldName: 'AnnualRevenue'},
    { label: 'Phone' , fieldName: 'Phone'},
    { label: 'Type' , fieldName: 'Type'},
    { label: 'Website' , fieldName: 'Website'},
];

export default class AccountManagerComponent extends LightningElement 
{
    @track state = {
        columns: columns,
        data: [],
    };

    connectedCallback()
    {
        accList()
        .then(result => {
            this.state.data = result;
        })
        .catch( error => {
            console.log("error occured");
        })
    }
}