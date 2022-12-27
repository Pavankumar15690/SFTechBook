import { LightningElement, track} from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
export default class Logout extends NavigationMixin(LightningElement){
    @track Home = false;
    @track Settings = false;
    @track FeedBack = false;
    @track LogOut = false;
    selectedItemValue;
    handleOnselect(event) {
        this.selectedItemValue = event.detail.value;
        if (this.selectedItemValue == 'Home'){
            this.Home = true;
            this[NavigationMixin.Navigate]({
                type: 'standard__webPage',
                attributes: {
                    url: 'https://raagvitech172-dev-ed.lightning.force.com/lightning/setup/SetupOneHome/home'
                }
            })
        }else{
            this.Home = false;
        }
        if (this.selectedItemValue == 'Settings'){
            this.Settings = true;
            this[NavigationMixin.Navigate]({
                type: 'standard__webPage',
                attributes: {
                    url: 'https://raagvitech172-dev-ed.lightning.force.com/lightning/settings/personal/PersonalInformation/home'
                }
            })
        }else{
            this.Settings = false;
        }
        if (this.selectedItemValue == 'FeedBack'){
            this.FeedBack = true;
            this[NavigationMixin.Navigate]({
                type: 'standard__webPage',
                attributes: {
                    url: 'https://www.salesforce.com/in/company/feedback/'
                }
            })
        }else{
            this.FeedBack = false;
        }
        if (this.selectedItemValue == 'LogOut'){
            this.LogOut = true;
            this[NavigationMixin.Navigate]({
                type: 'standard__webPage',
                attributes: {
                    url: 'https://raagvitech172-dev-ed.my.salesforce.com/'
                }
            })
        }else{
            this.LogOut = false;
        }
    }

}