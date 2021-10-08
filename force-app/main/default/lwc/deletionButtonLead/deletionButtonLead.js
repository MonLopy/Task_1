import { LightningElement, wire } from "lwc";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import coldLead from "@salesforce/apex/BatchApexProgress.executeBatchJob";
import confDelLead from "@salesforce/label/c.Conf_Del_Lead";
import toastLeadText from "@salesforce/label/c.Toast_Lead_Text";
import leadDeletion from "@salesforce/label/c.Lead_deletion";

export default class DeletionButtonLead extends LightningElement {
  SubmitHandler(event) {
    let con = confirm(confDelLead);
    if (con) {
      const toast = new ShowToastEvent({
        title: leadDeletion,
        message: toastLeadText,
        variant: "success",
        mode: "dismissable"
      });
      this.dispatchEvent(toast);
      coldLead();
    }
  }
}
