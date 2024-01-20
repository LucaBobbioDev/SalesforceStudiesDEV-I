import { LightningElement, wire} from 'lwc';
import queryAccountsByRevenue from '@salesforce/apex/AccountListControllerLwc.queryAccountsByRevenue';
export default class AccountFinder extends LightningElement {
    annualRevenue = null;
    accounts = []

    handleChange(event){
        this.annualRevenue = event.detail.value;
    }

    @wire(queryAccountsByRevenue, {annualRevenue:'$annualRevenue'})
    wiredAccountsByRevenue({ error, data }) {
        if (data) {
            this.accounts = data;
        } else if(error) {
            console.log('error =>' + error);
        }
    }

    reset(){
        this.annualRevenue = null;
        this.accounts = [];
    }
}