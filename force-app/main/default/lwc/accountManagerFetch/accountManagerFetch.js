import { LightningElement , track , wire} from 'lwc';
import accList from '@salesforce/apex/AccountController.accountRecordsList';

const columns = [
    { label: 'Name', fieldName : 'Name'},
    { label: 'Id' , fieldName: 'Id'},
    { label: 'Annual Revenue' , fieldName: 'AnnualRevenue'},
    { label: 'Phone' , fieldName: 'Phone'},
    { label: 'Type' , fieldName: 'Type'},
    { label: 'Website' , fieldName: 'Website'},
];

export default class AccountManagerFetch extends LightningElement 
{
    @track state = {
        columns: columns,
        data: [],
    };

    @wire(accList)
    wiredFunction({data, error})
    {
        if(data)
        {
            this.state.data = data;
        }
        else if(error)
        {
            console.log("Error Occured");
        }
    }
}