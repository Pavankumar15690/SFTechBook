import { LightningElement } from 'lwc';

export default class MySecondWebComponent extends LightningElement {
 name='';
 role=''; 
    displayName(event)
    {
        this.name = event.target.value;
    }
    displayRole(event)
    {
        this.role = event.target.value;
    }
    handleClick(event)
    {
        console.log('inside');
          
        console.log('name--'+this.name);
        console.log('role---'+this.role);

    }
}