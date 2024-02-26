@IsTest
private class PermissionsTests {
    @TestSetup
    static void testSetup() {
        Account a = TestFactory.getAccount('No view For You!', true);
        Private_Object__c po = new Private_Object__c(Account__c = a.id, Notes__c = 'foo');
        insert po;
    }

    @IsTest
    static void testNegativePermissionSet() {
        User u = new User(
            ProfileId = [SELECT Id FROM Profile WHERE Name = 'Standard User'].Id,
            LastName = 'last',
            Email = 'Cpt.Awesome@awesomesauce.com',
            UserName = 'Cpt.Awesome.' + DateTime.now().getTime() + '@awesomesauce.com',
            Alias = 'alias',
            TimeZoneSidKey = 'America/Los_Angeles',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US'
        );
        insert u;
        System.runAs(u) {
            Test.startTest();
                Private_Object__c[] pos = [
                    SELECT Id, Account__c, Notes__c 
                    FROM Private_Object__c
                ];
            Test.stopTest();
            Assert.areEqual(
                0,
                pos.size(),
                'A user without the permission set shouldn\'t see any records'
            );
        }
    }

    @IsTest
    static void testPositivePermissionSet() {
         User newUser = new User(
            ProfileId = [SELECT Id FROM Profile WHERE Name = 'Standard User'].Id,
            LastName = 'last',
            Email = 'Cpt.Awesome@awesomesauce.com',
            UserName = 'Cpt.Awesome.' + DateTime.now().getTime() + '@awesomesauce.com',
            Alias = 'alias',
            TimeZoneSidKey = 'America/Los_Angeles',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US'
        );
        insert newUser;
        PermissionSet ps = [
            SELECT Id
            FROM PermissionSet
            WHERE Name = 'Permission_Set_Name'
        ];

        insert new PermissionSetAssignment(
            AssigneeId = newUser.id,
            PermissionSetId = ps.Id
        );

        System.runAs(newUser) {
            Test.startTest();
                Private_Object__c[] pos = [
                    SELECT Id, Account__c, Notes__c 
                    FROM Private_Object__c
                ];
            Test.stopTest();
            Assert.areEqual(
                1,
                pos.size(),
                'A user with the permission set should see any records'
            );
        }
    }
}