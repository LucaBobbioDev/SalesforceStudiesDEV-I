public with sharing class OrderItemUtility {
    public OrderItemUtility() {}

    public static void addBonusBouquet(List<Order> ordersFromTrigger) {
        Product2 bonusProduct = new Product2();
        PricebookEntry entry = new PricebookEntry();
        List<OrderItem> newBouquets = new List<OrderItem>();
        List<Product2> bonusProductList = [SELECT Id, ProductCode FROM Product2 WHERE ProductCode = 'BOT-BB-12'];
        
        if(bonusProductList.size() > 0) {
            bonusProduct = bonusProductList[0];
            List<PricebookEntry> entryList = [
                SELECT Id, Product2Id 
                FROM PricebookEntry 
                WHERE Product2Id = :bonusProduct.Id
            ];

            if(entryList.size() > 0) {
                entry = entryList[0];
            }

            for(Order currentOrder : ordersFromTrigger) {
                if(currentOrder.Status == 'Activated') {
                    OrderItem freeBouquet = new OrderItem(
                        OrderId = currentOrder.id, 
                        PricebookEntryId = entry.id,
                        numberOfFlowers__c = 3,
                        description = 'FREE Bouquet',
                        Quantity = 1,
                        colorTheme__c = 'Spectacular Sunset',
                        percentOfOpening__c = 0,
                        UnitPrice = 0.00
                    );
                    newBouquets.add(freeBouquet);
                }
            }
            insert newBouquets;
        }
    }
}