import { LightningElement, wire, track } from 'lwc';
import getAccounts from '@salesforce/apex/AccountController.getAccounts';
import createAccount from '@salesforce/apex/AccountController.createAccount';
import createContact from '@salesforce/apex/AccountController.createContact';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import {ACCOUNT_COLUMNS} from './constants/lwcAssignmentConstants';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import CONTACT_OBJECT from '@salesforce/schema/Contact';

export default class LwcAssignment extends LightningElement 
{
    @track state = {
        columns : ACCOUNT_COLUMNS,
        accounts : [],
        isShowModal : false,
        showContactModal : false,
        newAccountId : '',
        newAccountName : '',
        accObjectApiName : ACCOUNT_OBJECT,
        conObjectApiName : CONTACT_OBJECT,
        newAccountData : {},
        newContactData : {},

    };
    
    showModalBox() 
    {  
        this.state.isShowModal = true;
    }

    hideModalBox() 
    {  
        this.state.isShowModal = false;
    }

    @wire(getAccounts)
    wiredAccounts({ error, data }) 
    {
        if (data) 
        {
            this.state.accounts = data;
        } 
        else if (error) 
        {
            console.error('Error fetching accounts:', error);
        }
    }
    
    handleAccountChange(event) 
    {
        this.state.newAccountData[event.target.name] = event.target.value;
    }
    
    saveAccount() 
    {
        createAccount({ accountData: this.state.newAccountData })
            .then((result) => {
                this.state.newAccountId = result.Id;
                this.state.newAccountName = result.Name;
                this.state.isShowModal = false;
                this.state.showContactModal = true;
                this.dispatchEvent(
                    new ShowToastEvent({ title: 'Success', message: 'Account Created', variant: 'success' })
                );
                return getAccounts();
            })
            .then(data => {
                this.state.accounts = data;
            })
            .catch(error => {
                console.error('Error creating account:', error);
            });
    }
    
    handleContactChange(event) 
    {
        this.state.newContactData[event.target.name] = event.target.value;
    }
    
    saveContact() 
    {
        this.state.newContactData.AccountId = this.state.newAccountId;
        createContact({ contactData: this.state.newContactData })
            .then(() => {
                this.state.showContactModal = false;
                this.dispatchEvent(
                    new ShowToastEvent({ title: 'Success', message: 'Contact Created', variant: 'success' })
                );
            })
            .catch(error => {
                console.error('Error creating contact:', error);
            });
    }

    closeContactModal()
    {
        this.state.showContactModal = false;
    }

    handleSuccess(event)
    {
        this.state.newAccountName = event.detail.id;
       //this.dispatchEvent(new CustomEvent('refreshdatatable'));
    }
}