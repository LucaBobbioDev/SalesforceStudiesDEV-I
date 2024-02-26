@IsTest
private class ExternalSearchTests {
    @IsTest
    static void testPositiveMocking() {
        HTTPMockFactory mock = new HTTPMockFactory(
            200,
            'OK',
            'I found it!',
            new Map<String, String>()
        );

        Test.setMock(HttpCalloutMock.class, mock);
        Test.startTest();
            String result = ExternalSearch.googleIt('epic search');
        Test.stopTest();
        
        Assert.areEqual('I found it!', result, 'Expected to receive mock response');
    }

    @IsTest
    static void testNegativeMocking() {
        HTTPMockFactory mock = new HTTPMockFactory(
            500,
            'Error',
            'Internal Server Error',
            new Map<String, String>()
        );

        try {
             Test.setMock(HttpCalloutMock.class, mock);
            Test.startTest();
                ExternalSearch.googleIt('');
            Test.stopTest();
            Assert.fail('An exception should have been thrown');
        } catch (ExternalSearch.ExternalSearchException e) {
            System.assertEquals(
                'Did not receive a 200 status code: 500',
                e.getMessage(),
                'Exception message does not match: ' + e.getMessage()
            );
        }
       
        
        //Assert.areEqual('Internal Server Error', result, 'Expected to receive mock response');
    }
}