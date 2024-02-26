@IsTest
public with sharing class OpportunityDiscountTests {
    @IsTest
    static void testPositiveStubbingLowPriority() {
        AccountWrapper mockAccountWrapper = (AccountWrapper)
        Test.createStub(AccountWrapper.class, new AccountWrapperMock());

        OpportunityDiscount od = new OpportunityDiscount(mockAccountWrapper);

        Test.startTest();
            Decimal result = od.getTotalDiscount();
        Test.stopTest();

        Assert.areEqual(.1, result, 'Expected to get .1');
    }

    @IsTest
    static void testPositiveStubbingHighPriority() {
        AccountWrapperMock.isHighPriorityReturn = true;
        AccountWrapper mockAccountWrapper = (AccountWrapper) Test.createStub(
        AccountWrapper.class, 
        new AccountWrapperMock()
        );

        OpportunityDiscount od = new OpportunityDiscount(mockAccountWrapper);

        Test.startTest();
            Decimal result = od.getTotalDiscount();
        Test.stopTest();
        
        Assert.areEqual(.25, result, 'Expected to get .25');
    }
}