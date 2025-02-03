import Website from '@salesforce/schema/Account.Website';
import { LightningElement, track } from 'lwc';
import {columns} from './constant/constant';



export default class AccountManager extends LightningElement 
{
    @track column = columns;


    data = [ 
        {Name: 'Acc-1', Phone: '794512', Total_Revenue__c: '5000', Website: 'www.acc1.com'},
        {Name: 'Acc-2', Phone: '74185', Total_Revenue__c: '6000', Website: 'www.acc2.com'},
        {Name: 'Acc-3', Phone: '5945', Total_Revenue__c: '7000', Website: 'www.acc3.com'},
        {Name: 'Acc-4', Phone: '7417896', Total_Revenue__c: '8000', Website: 'www.acc4.com'}
    ];
}