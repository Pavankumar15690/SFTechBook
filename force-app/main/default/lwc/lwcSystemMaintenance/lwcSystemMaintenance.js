import {LightningElement, wire, api} from 'lwc';
import getRecord from '@salesforce/apex/SystemController.getRecord';
import SystemMaintenance from '@salesforce/label/c.SystemMaintenance';
export default class LwcSystemMaintenance extends LightningElement {
  label = {
    SystemMaintenance
  };
  @api recordId;
  
  @wire (getRecord) getRecord;
}