import { LightningElement, track, api } from 'lwc';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import PHONE_FIELD from '@salesforce/schema/Account.Phone';
import WEBSITE_FIELD from '@salesforce/schema/Account.Website';
import CONTACT_OBJECT from '@salesforce/schema/Contact';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class Assignment2ParentComponent extends LightningElement 
{
    @api recordId;

    @track isShowModal = false;

    @track State = {
        accObjectApiName           :   ACCOUNT_OBJECT  ,
        nameField               :   NAME_FIELD      ,
        phoneField              :   PHONE_FIELD     ,
        websiteField            :   WEBSITE_FIELD   ,
        conObjectApiName           :   CONTACT_OBJECT  ,
        onClickedButtonLabel    :   'Create Contact',
        cardVisible             :   false           ,
    };

    showModalBox() {  
        this.isShowModal = true;
    }

    hideModalBox() {  
        this.isShowModal = false;
    }

    handleSuccess(event)
    {
        console.log('handlesuccess');
        
        this.dispatchEvent(
            new ShowToastEvent({
            title: "Successful",
            message: "Contact Created",
            variant: 'success'
        })
    );

    this.hideModalBox();
}
}