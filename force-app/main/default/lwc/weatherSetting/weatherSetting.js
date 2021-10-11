import { LightningElement, wire, track } from "lwc";
import Setting from "@salesforce/apex/WeatherReview.getWeatherSetting";
import { ShowToastEvent } from "lightning/platformShowToastEvent";

export default class WeatherSettings extends LightningElement {
  @track recordId;
  @wire(Setting)
  getWeathers({ error, data }) {
    if (data) {
      this.recordId = data.Id;
    }
  }
  handleSuccess() {
    const event = new ShowToastEvent({
      title: "Success. Record " + this.recordId + " is saved.",
      message: "Setting saved",
      variant: "success",
      mode: "dismissable"
    });
    this.dispatchEvent(event);
  }
}
