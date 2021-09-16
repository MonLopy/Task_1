import { LightningElement, api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class Task2 extends NavigationMixin(LightningElement) {
    @api recordId;
    handleSubmit(event){
        event.preventDefault();       // stop the form from submitting
        const fields = event.detail.fields;
        this.template.querySelector('lightning-record-edit-form').submit(fields);
        
     }
     handleSucess(event){
        this[NavigationMixin.Navigate]({
            type: 'standard__webPage',
            attributes: {
                url:'https://playful-raccoon-geo70l-dev-ed.lightning.force.com/lightning/o/Customer_report__c/list?filterName=Recent'
            },
        });
        const evt = new ShowToastEvent({
            title: 'Record updated',
            message: 'Opearion sucessful',
            variant: 'success',
            mode: 'dismissable'
        });
        this.dispatchEvent(evt);
     }
 }