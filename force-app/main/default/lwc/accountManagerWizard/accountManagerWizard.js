import { 
    LightningElement , 
    track , 
    api,
    wire
    } from 'lwc';

import 
    CONTACT_OBJECT 
    from '@salesforce/schema/Contact';

import 
    ACCOUNT_OBJECT 
    from '@salesforce/schema/Account';

import 
    NAME_FIELD 
    from '@salesforce/schema/Account.Name';

import 
    OWNER_FIELD 
    from '@salesforce/schema/Account.OwnerId';

import 
    DESCRIPTION_FIELD 
    from '@salesforce/schema/Account.Description';

import 
    NUMBER_OF_CONTACTS 
    from '@salesforce/apex/AccountController.accountRecordsListCount';

import 
    listOfContactsRelatedToAccount 
    from '@salesforce/apex/AccountController.accountRecordsList';

import 
    {ACCOUNT_RELATED_CONTACTS_COLUMNS} 
    from './constants/accountManagerWizardConstants';

import { 
    refreshApex 
    } from '@salesforce/apex';
    

import {
    notifyRecordUpdateAvailable 
    } from 'lightning/uiRecordApi';


export default class AccountManagerWizard extends LightningElement 
{
    @api recordId;

    wiredContactResult;
    wiredCountResult;

    @track state = {
        ObjectApiName :   ACCOUNT_OBJECT,
        nameField : NAME_FIELD,
        ownerField : OWNER_FIELD,
        descriptionField : DESCRIPTION_FIELD,
        numberOfContacts : '',
        conObjectApiName : CONTACT_OBJECT,
        columns : ACCOUNT_RELATED_CONTACTS_COLUMNS,
        data : [],
        initialRecords : '',
        searchString : '',
        showModalPopUp: false,
    };

    connectedCallback() {
        console.log('Record ID' + this.recordId);
        
    }

    @wire(NUMBER_OF_CONTACTS, {accId: '$recordId'})
    wiredConCountFunction(result)
    {   
        console.log('Inside wire ');
        this.wiredCountResult = result;
        if(result.data)
        {
            this.state.numberOfContacts = result.data;
        }
        else if(result.error)
        {
            console.log('Error');
        }
    }
    @wire(listOfContactsRelatedToAccount, {accId : '$recordId'})
    wiredConListFunction(result)
    {

        //console.log('result',data);
        
        this.wiredContactResult = result;

        if(result.data)
        {
            //console.log('DATA',result.data);
            this.state.data = result.data;
            this.state.initialRecords = result.data;
            this.state.error = undefined;
        }
        else if(result.error)
        {
            console.log('Error');
            this.state.error = result.error;
            this.state.data = undefined;
        }

    }

    refreshDataTable(event) 
    {
        console.log('Refreshing Datatable...');
        refreshApex(this.wiredContactResult); 
        refreshApex(this.wiredCountResult);
    }

    handleClickCreateNewContact()
    {
        this.state.showModalPopUp = true;
        refreshApex(this.wiredContactVariable);
        notifyRecordUpdateAvailable({recordId : this.recordId});
    }

    handleCustomEvent(event) 
    {
        console.log('showModalPopUp', event.detail.showModalPopUp);
        this.state.showModalPopUp = event.detail.showModalPopUp;
        //this.state.showModalPopUp = false;
    }

    handleSearch(event) 
    {
        const searchKey = event.target.value.toLowerCase();
 
        if (searchKey) 
        {
            this.state.data = this.state.initialRecords;

            if (this.state.data) 
                {
                    let searchRecords = [];
    
                    for (let record of this.state.data) 
                        {
                            let valuesArray = Object.values(record);
        
                            for (let val of valuesArray) 
                                {
                                    console.log('val is ' + val);
                                    let strVal = String(val);
            
                                    if (strVal) 
                                        {
                                            if (strVal.toLowerCase().includes(searchKey)) 
                                                {
                                                    searchRecords.push(record);
                                                    break;
                                                }
                                        }
                                }
                        }
    
                    console.log('Matched Accounts are ' + JSON.stringify(searchRecords));
                    this.state.data = searchRecords;
                }
        } 
        else 
        {
            this.state.data = this.state.initialRecords;
        }
    }
}