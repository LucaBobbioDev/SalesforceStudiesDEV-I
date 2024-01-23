trigger RestrictContactByName on Contact (before insert, before update) {
	for (Contact contact : Trigger.New) {
		if(contact.LastName == 'INVALIDNAME') {
			contact.AddError('The Last Name "' + contact.LastName + '" is not allowed for DML');
		}
	}
}