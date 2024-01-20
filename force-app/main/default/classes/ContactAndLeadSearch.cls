public class ContactAndLeadSearch {
	public static List<List<sObject>> searchContactsAndLeads(String searchString) {
        List<List<sObject>> searchResults = new List<List<sObject>>();
        
        List<Contact> contactList = [
            SELECT Id, FirstName, LastName 
            FROM Contact 
            WHERE FirstName LIKE :searchString OR LastName LIKE :searchString
        ];
        List<Lead> leadList = [
            SELECT Id, FirstName, LastName 
            FROM Lead 
            WHERE FirstName LIKE :searchString OR LastName LIKE :searchString
        ];

        searchResults.add(contactList);
        searchResults.add(leadList);

        return searchResults;
    }
}