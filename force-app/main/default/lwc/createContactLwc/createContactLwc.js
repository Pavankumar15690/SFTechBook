import { LightningElement } from 'lwc';
import createContact from '@salesforce/apex/CreateContactController.createContact';

export default class createContactLwc extends LightningElement {
    lastName='';
    email='';
    handlelNameChange(event){
        this.lastName = event.target.value;
        console.log('Lastname>>>>', this.lastName);
    }

    handleEmailChange(event){
        this.email = event.target.value;
        console.log('Email>>>>', this.email);
    }
    
    handleInsertContact(event){
        createContact({lastName : this.lastName, email : this.email})
    }
}