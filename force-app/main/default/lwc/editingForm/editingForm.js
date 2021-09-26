import { LightningElement, api, wire } from "lwc";
import getContactFields from "@salesforce/apex/GetCustomFields.getContactFields";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
export default class Task2 extends LightningElement {
  @api recordId;
  @wire(getContactFields) wiredContactFields;
  handleSucess(event) {
    const evt = new ShowToastEvent({
      title: this.recordId,
      message: "Opearion sucessful",
      variant: "success",
      mode: "dismissable"
    });
    this.dispatchEvent(evt);
  }
}
