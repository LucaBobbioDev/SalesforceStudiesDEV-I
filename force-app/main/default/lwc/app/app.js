import { LightningElement } from 'lwc';

export default class App extends LightningElement {
    ready = false;
    
    name = 'Electra X4';
    description = 'A sweet bike built for comfort.';
    category = 'Mountain';
    material = 'Steel';
    price = '$2,700';
    pictureUrl = 'https://s3-us-west-1.amazonaws.com/sfdc-demo/ebikes/electrax4.jpg';

    //lifecycle hook
    connectedCallback() {
        setTimeout(() => {
          this.ready = true;
        }, 3000);
    }
}