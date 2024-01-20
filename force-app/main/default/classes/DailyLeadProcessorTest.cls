@IsTest
public with sharing class DailyLeadProcessorTest {
    public static String CRON_EXP = '0 0 0 15 3 ? 2042';

    @IsTest
    static void testScheduledJob() {
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
            String jobId = System.schedule('ScheduledApexTest', CRON_EXP, new DailyLeadProcessor());
        Test.stopTest();

        List<Lead> updatedLeadRecords = [
            SELECT Id, FirstName, LastName, LeadSource, Company 
            FROM Lead
            WHERE LeadSource = 'Dreamforce'
        ];

        System.assertEquals(200, updatedLeadRecords.size());
    }
}