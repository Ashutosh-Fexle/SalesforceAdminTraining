import { 
    LightningElement , 
    track
    } from 'lwc';

import 
    CONTACT_OBJECT 
    from '@salesforce/schema/Contact';

import {
    ShowToastEvent 
    } from 'lightning/platformShowToastEvent';

export default class ContactSaveForm extends LightningElement 
{
    @track state = {
        conObjectApiName : CONTACT_OBJECT,
        isShowModal : false,
        value: '',
    };

    handleChange(event) 
    {
        event.preventDefault();
        const name = event.target.value;
        console.log('name', name);
        const selectEvent = new CustomEvent('mycustomevent', {
            detail:{
                showModalPopUp: false
            }
        });
       this.dispatchEvent(selectEvent);
       
    }


    validateEmail(event) 
    {
        event.preventDefault(); // Prevent default form submission

        // Get the email field value
        const emailField = this.template.querySelector('.email lightning-input-field');

        if (emailField) 
        {
            const emailValue = emailField.value;

            // Validation conditions
            if (!emailValue) 
                {
                    this.showToast('Error', 'Email field cannot be empty', 'error');
                    return;
                } 
            else if (!emailValue.includes('@') || !emailValue.endsWith('.com')) 
                {
                    this.showToast('Error', 'Invalid email format! Email must contain "@" and end with ".com"', 'error');
                    return;
                }

            // If validation passes, submit the form
            this.template.querySelector('lightning-record-edit-form').submit();
        }
    }

    showToast(title, message, variant) 
    {
        const event = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant
        });
        this.dispatchEvent(event);
    }

    showModalBox() {  
        this.state.isShowModal = true;
    }

    hideModalBox() {  
        this.state.isShowModal = false;
    }

    handleSuccess(event)
    {
        console.log('handlesuccess@@@@');

        const event1 = new ShowToastEvent({
            title: 'Successful',
            message: 'Contact Created',
            variant: 'success'
        });
        this.dispatchEvent(event1);

        const selectEvent = new CustomEvent('mycustomevent', {
            detail:{
                showModalPopUp: false
            }
        });
       this.dispatchEvent(selectEvent);

       this.dispatchEvent(new CustomEvent('refreshdatatable'));

    }

    handleClick()
    {
        console.log('@@##@@');
    }

    get options()
    {
        return [
            {label : 'Acc1', value : 'New Acc-1'},
            {label : 'Acc2', value : 'New Acc-2'},
            {label : 'Acc3', value : 'New Acc-3'},
            {label : 'Acc4', value : 'New Acc-4'},
            {label : 'Acc5', value : 'New Acc-5'},
        ]
    }
}