import { LightningElement, api, wire } from "lwc";
import CUSTOM_OBJECT_ACCOUNT from "@salesforce/schema/Customer_report__c.Account__c";
import CUSTOM_OBJECT_CODE from "@salesforce/schema/Customer_report__c.Code__c";
import CUSTOM_OBJECT_REPORT from "@salesforce/schema/Customer_report__c.Customer_Report__c";
import CUSTOM_OBJECT_NAME from "@salesforce/schema/Customer_report__c.Name";
import CUSTOM_OBJECT_DATA from "@salesforce/schema/Customer_report__c.Data_Source__c";
import CUSTOM_OBJECT_FREQUENCY from "@salesforce/schema/Customer_report__c.Frequency__c";
import CUSTOM_OBJECT_FTP from "@salesforce/schema/Customer_report__c.FTP__c";
import CUSTOM_OBJECT_ICO from "@salesforce/schema/Customer_report__c.ICO__c";
import CUSTOM_OBJECT_LASTMOD from "@salesforce/schema/Customer_report__c.LastModifiedById";
import CUSTOM_OBJECT_NOTE from "@salesforce/schema/Customer_report__c.Note__c";
import CUSTOM_OBJECT_OWNER from "@salesforce/schema/Customer_report__c.OwnerId";
import CUSTOM_OBJECT_PARCEL from "@salesforce/schema/Customer_report__c.Parcel__c";
import CUSTOM_OBJECT_REPTEMPLATE from "@salesforce/schema/Customer_report__c.ReportTemplateID__c";
import CUSTOM_OBJECT_SCHEDULE from "@salesforce/schema/Customer_report__c.Schedule__c";
import CUSTOM_OBJECT_TEMPLATE from "@salesforce/schema/Customer_report__c.Template__c";
import CUSTOM_OBJECT_TITLE from "@salesforce/schema/Customer_report__c.Title__c";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
export default class Task2 extends LightningElement {
  @api recordId;
  fields = [
    CUSTOM_OBJECT_ACCOUNT,
    CUSTOM_OBJECT_CODE,
    CUSTOM_OBJECT_REPORT,
    CUSTOM_OBJECT_NAME,
    CUSTOM_OBJECT_DATA,
    CUSTOM_OBJECT_FREQUENCY,
    CUSTOM_OBJECT_FTP,
    CUSTOM_OBJECT_ICO,
    CUSTOM_OBJECT_LASTMOD,
    CUSTOM_OBJECT_NOTE,
    CUSTOM_OBJECT_OWNER,
    CUSTOM_OBJECT_PARCEL,
    CUSTOM_OBJECT_REPTEMPLATE,
    CUSTOM_OBJECT_SCHEDULE,
    CUSTOM_OBJECT_TEMPLATE,
    CUSTOM_OBJECT_TITLE
  ];
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
