import { LightningElement, track, wire } from 'lwc';
import { publish, MessageContext, subscribe } from 'lightning/messageService';
import MESSAGE_CHANNEL from '@salesforce/messageChannel/MessageChannel_A_B__c';

export default class MessengerB extends LightningElement {
    @track messageToSend = '';
    @track receivedMessage = '';

    // Required for publishing and subscribing
    @wire(MessageContext) messageContext;

    connectedCallback() {
        this.subscribeToMessageChannel();
    }

    handleInputChange(event) {
        this.messageToSend = event.target.value;
    }

    sendMessage() {
        const message = { message: this.messageToSend };
        publish(this.messageContext, MESSAGE_CHANNEL, message);
    }

    subscribeToMessageChannel() {
        subscribe(this.messageContext, MESSAGE_CHANNEL, (message) => {
            this.handleMessage(message);
        });
    }

    handleMessage(message) {
        this.receivedMessage = message.message;
    }
}