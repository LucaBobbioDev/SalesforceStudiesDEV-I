public with sharing class AccountListControllerLwc {
    @AuraEnabled(cacheable=true)
    public static List<Account> queryAccounts(Integer numberOfEmployees) {
        return [
            SELECT Name
            FROM Account
            WHERE NumberOfEmployees >= :numberOfEmployees
        ];
    }

    @AuraEnabled
    public static List<Account> queryAccountsByRevenue(Decimal annualRevenue) {
        return [
            SELECT Id, Name
            FROM Account
            WHERE AnnualRevenue >= :annualRevenue
        ];
    }
}