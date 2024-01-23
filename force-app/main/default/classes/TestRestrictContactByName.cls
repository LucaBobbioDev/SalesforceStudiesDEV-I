@IsTest
public class TestRestrictContactByName {
	@IsTest
    static void testInvalidLastName() {
        Contact invalidLastNameContact = new Contact(
            FirstName = 'John',
            LastName = 'INVALIDNAME',
            Email = 'john.doe@example.com'
        );

        Test.startTest();
        	List<Database.SaveResult> results = Database.insert(new List<Contact>{invalidLastNameContact}, false);
        Test.stopTest();

        System.assertEquals(1, results.size());
        System.assertEquals(false, results[0].isSuccess());
        System.assertEquals('The Last Name "INVALIDNAME" is not allowed for DML', results[0].getErrors()[0].getMessage());
    }

    @IsTest
    static void testValidLastName() {
        Contact validLastNameContact = new Contact(
            FirstName = 'John',
            LastName = 'Doe',
            Email = 'john.doe@example.com'
        );

        Test.startTest();
        	List<Database.SaveResult> results = Database.insert(new List<Contact>{validLastNameContact}, false);
        Test.stopTest();

        System.assertEquals(1, results.size());
        System.assertEquals(true, results[0].isSuccess());
        System.assertNotEquals(null, results[0].getErrors());
    }
}