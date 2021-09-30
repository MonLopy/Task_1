import { LightningElement, wire, track } from "lwc";
import getOppRecords from "@salesforce/apex/OpportunityController.getOppRecords";
const columns = [
  {
    label: "Name",
    fieldName: "recordLink",
    type: "url",
    typeAttributes: {
      label: { fieldName: "Name" },
      tooltip: "Name",
      target: "_blank"
    }
  },
  { label: "Stage", fieldName: "StageName", type: "text" },
  { label: "Closed Date", fieldName: "CloseDate" },
  { label: "Amount", fieldName: "Amount", type: "currency" }
];

export default class TableForOpp extends LightningElement {
  @track areDetailsVisible = true;
  consData = [];
  columns = columns;
  test(event) {}
  @wire(getOppRecords)
  contacts({ error, data }) {
    if (data) {
      let tempConList = [];

      data.forEach((record) => {
        let tempConRec = Object.assign({}, record); //copy
        tempConRec.recordLink = "/" + tempConRec.Id;
        tempConList.push(tempConRec);
      });

      this.consData = tempConList;
      if (this.consData.length == 0) {
        this.areDetailsVisible = false;
      }
      this.error = undefined;
    } else if (error) {
      this.error = result.error;
    }
  }
}
