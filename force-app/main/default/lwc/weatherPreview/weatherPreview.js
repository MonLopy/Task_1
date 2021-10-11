import { LightningElement, wire, track } from "lwc";
import getWeatherDataReview from "@salesforce/apex/WeatherReview.getWeatherDataReview";
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
  // { label: "Name", fieldName: "Name", type: "text" },
  { label: "City name", fieldName: "city_name__c", type: "text" },
  { label: "Date", fieldName: " date__c" },
  { label: "Humidity", fieldName: " humidity__c" },
  { label: "Temperature", fieldName: "temperature__c" },
  { label: "Temp. feels like", fieldName: "temp_feels_like__c" },
  { label: "Description", fieldName: "weather_description__c", type: "text" },
  { label: "Pressue", fieldName: "pressure__c" },
  { label: "Latitude", fieldName: "latitude__c" },
  { label: "Longitude", fieldName: "longitude__c" }
];
export default class WeatherPreview extends LightningElement {
  @track areDetailsVisible = true;
  consData = [];
  columns = columns;
  test(event) {}
  @wire(getWeatherDataReview)
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
