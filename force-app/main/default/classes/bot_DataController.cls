global without sharing class bot_DataController {


    @InvocableMethod(label='Load Sample Data' description='Load Sample Data for this App. Will delete previously loaded data!!')
    public static void loadSampleData () {
        System.debug('loadSampleData Invoked!');

        // Activate Standard Pricebook
        if (Test.isRunningTest()!=true) {
            activatePricebook();
        }
        

        Account a = insertAccount();
        List < Product2 > productsToInsert = insertProducts();
        List <PricebookEntry> pricebookEntries = insertPriceBookEntries(productsToInsert);
        Order myOrder = insertOrder(a.Id);

    }

    private static List <PricebookEntry> insertPriceBookEntries(List < Product2 > productsToInsert) {
         // Load Pricebook Entries
        // Get default Pricebook ID
        String pricebookId = getStandardPriceBookId();
        System.debug('pricebookId '+pricebookId);

        // We'll be loading two of each.  ond for the dstandard 
        List <PricebookEntry> pricebookEntries = new List <PricebookEntry>();
        for (Product2 p: productsToInsert) {
            if (p.ProductCode=='BOT-WW-12') {
                PricebookEntry entry = new PricebookEntry(IsActive=true,UnitPrice=80,Product2Id=p.Id,Pricebook2Id=pricebookId);
                pricebookEntries.add(entry);
            } else if (p.ProductCode=='BOT-BB-12') {
                PricebookEntry entry = new PricebookEntry(IsActive=true,UnitPrice=50,Product2Id=p.Id,Pricebook2Id=pricebookId);
                pricebookEntries.add(entry);
            } else if (p.ProductCode=='BOT-SS-24') {
                PricebookEntry entry = new PricebookEntry(IsActive=true,UnitPrice=150,Product2Id=p.Id,Pricebook2Id=pricebookId);
                pricebookEntries.add(entry);
            }
        }
        // Testing with Pricebooks is a pain, circumventing for demo purposes only.  NOT PRODUCTION APPROPRIATE CODE
        if (Test.isRunningTest()!=true) {
            insert pricebookEntries;
        }
        
        return pricebookEntries;
    }

    private static Account insertAccount() {
        // Load the Account
        Account a = new Account();
        a.Name = 'Alsarraf Enterprises';
        a.Type = 'Customer - Direct';
        a.Phone = '555-222-2222';
        a.AnnualRevenue = 1000000;
        a.NumberOfEmployees = 2000;
        a.First_Name__c = 'Shaiyma';
        a.Last_Name__c = 'Alsarraf';
        a.Top_Account__c = true;
        a.Founding_Date__c = Date.newInstance(2019, 05, 15);
        insert a;

        return a;
    }

    private static List < Product2 > insertProducts() {
        //Products
        String jsonProducts = '[{"NAME":"Beautiful Blue Enhanced Bouquet","PRODUCTCODE":"BOT-BB-24","ISACTIVE":false,"COLORTHEME__C":"Beautiful Blue","NUMBEROFFLOWERS__C":24,"PERCENTOFOPENING__C":0},{"NAME":"Wonderfully White Enhanced Bouquet","PRODUCTCODE":"BOT-WW-24","ISACTIVE":false,"COLORTHEME__C":"Wonderful White","NUMBEROFFLOWERS__C":24,"PERCENTOFOPENING__C":0},{"NAME":"Beautiful Blue Standard Bouquet","PRODUCTCODE":"BOT-BB-12","ISACTIVE":true,"COLORTHEME__C":"Beautiful Blue","NUMBEROFFLOWERS__C":12,"PERCENTOFOPENING__C":0},{"NAME":"Wonderful White Standard Bouquet","PRODUCTCODE":"BOT-WW-12","ISACTIVE":false,"COLORTHEME__C":"Wonderful White","NUMBEROFFLOWERS__C":12,"PERCENTOFOPENING__C":0},{"NAME":"Spectacular Sunset Enhanced Bouquet","PRODUCTCODE":"BOT-SS-24","ISACTIVE":false,"COLORTHEME__C":"Spectacular Sunset","NUMBEROFFLOWERS__C":24,"PERCENTOFOPENING__C":0},{"NAME":"Spectacular Sunset Standard Bouquet","PRODUCTCODE":"BOT-SS-12","ISACTIVE":false,"COLORTHEME__C":"Spectacular Sunset","NUMBEROFFLOWERS__C":12,"PERCENTOFOPENING__C":0},{"NAME":"Pretty Pink Standard Bouquet","PRODUCTCODE":"BOT-PP-12","ISACTIVE":false,"COLORTHEME__C":"Pretty Pink","NUMBEROFFLOWERS__C":12,"PERCENTOFOPENING__C":0}]';
        List < Product2 > productsToInsert = (List <Product2>)JSON.deserialize(jsonProducts, List <Product2>.class);
        insert productsToInsert;

        return productsToInsert;

    }

    private static Order insertOrder(String accountId) {
        Order myOrder = new Order();
        myOrder.AccountId = accountId;
        myOrder.EffectiveDate = Date.newInstance(2019, 07, 22);
        myOrder.Status = 'Draft';
        insert myOrder;
        return myOrder;
    }

    private static String getStandardPriceBookId() {
        if (Test.isRunningTest()) {
            return Test.getStandardPricebookId();
        } else {
            return [SELECT ID FROM Pricebook2 WHERE IsStandard=true LIMIT 1].Id;
        }
    }

    private static void activatePricebook() {
        Pricebook2 pb = [SELECT ID, IsActive FROM Pricebook2 WHERE IsStandard=true LIMIT 1];
        pb.IsActive=true;
        update pb;
    }
}