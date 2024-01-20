@IsTest
public with sharing class LeadProcessorTest {
    @IsTest
    static void testLeadProcessor() {
        List<Lead> leadRecordsList = new List<Lead>();

        for(Integer i = 0; i < 200; i++ ){
            leadRecordsList.add(
                new Lead(
                    FirstName = 'Test Lead ' + i, 
                    LastName = 'Record ' + i, 
                    LeadSource = 'TestSource',
                    Company = 'CompanyForce' + i
            ));
        }

        insert leadRecordsList;

        Test.startTest();
            LeadProcessor leadBatch = new LeadProcessor();
            Database.executeBatch(leadBatch);
        Test.stopTest();

        List<Lead> updatedLeadRecords = [
            SELECT Id, FirstName, LastName, LeadSource, Company 
            FROM Lead
            WHERE LeadSource = 'Dreamforce'
        ];

        System.assertEquals(200, updatedLeadRecords.size());
    }
}