public class StringArrayTest {
    public static List<String> generateStringArray(Integer numberOfStrings){
        List<String> stringList = new List<String>();
        for (Integer i = 0; i < numberOfStrings; i++){
            stringList.add('Test ' + i);
        }
        return stringList;
    }
}