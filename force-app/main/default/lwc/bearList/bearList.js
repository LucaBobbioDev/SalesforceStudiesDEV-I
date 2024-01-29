import { LightningElement, wire } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import { publish, MessageContext } from 'lightning/messageService';

import ursusResources from '@salesforce/resourceUrl/ursus_park';
import searchBears from '@salesforce/apex/BearController.searchBears';

import BEAR_LIST_UPDATE_MESSAGE from '@salesforce/messageChannel/BearListUpdate__c';

export default class BearList extends NavigationMixin(LightningElement) {
	searchTerm = '';
	bears;

    @wire(MessageContext) messageContext;
    @wire(searchBears, {searchTerm: '$searchTerm'})
    loadBears(result) {
		this.bears = result;
		if (result.data) {
			const message = { bears: result.data };
			publish(this.messageContext, BEAR_LIST_UPDATE_MESSAGE, message);
		}
    }

	appResources = {
		bearSilhouette: `${ursusResources}/standing-bear-silhouette.png`,
	};

	handleSearchTermChange(event) {
		window.clearTimeout(this.delayTimeout);
		const searchTerm = event.target.value;
		this.delayTimeout = setTimeout(() => {
			this.searchTerm = searchTerm;
		}, 300);
	}

	get hasResults() {
		return (this.bears.data.length > 0);
	}

    handleBearView(event) {
		const bearId = event.detail;
		this[NavigationMixin.Navigate]({
			type: 'standard__recordPage',
			attributes: {
				recordId: bearId,
				objectApiName: 'Bear__c',
				actionName: 'view',
			},
		});
	}
}