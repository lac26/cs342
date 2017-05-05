import java.util.Arrays;
import java.util.Map;

import oracle.kv.*;

/**
 * This program connects to kvlite on localhost, puts a single key-value pair,
 * reads/prints it, updates it and the deletes it. It is based on Oracle's
 * example:
 *
 * 		C:\Program Files\kv-3.0.9\examples\hello\HelloBigDataWorld.java
 *
 * You'll need to copy the code into a Java class/application file. See lab 13.1 for details.
 *
 * @author kvlinden
 * @version Summer, 2014
 */
public class HelloRecords {

    public static void main(String[] args) {

        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));


        //name
        Key key1 = Key.createKey(Arrays.asList("movie", "92616"), Arrays.asList("name"));
        Value value1 = Value.createValue("Dr. Strangelove".getBytes());
        store.put(key1, value1);

        String result = new String(store.get(key1).getValue().getValue());
        System.out.println(key1.toString() + " : " + result);

        //year
        Key key2 = Key.createKey(Arrays.asList("movie", "92616"), Arrays.asList("year"));
        Value value2 = Value.createValue("1964".getBytes());
        store.put(key2, value2);

        String result2 = new String(store.get(key2).getValue().getValue());
        System.out.println(key2.toString() + " : " + result2);

        //rating
        Key key3 = Key.createKey(Arrays.asList("movie", "92616"), Arrays.asList("rating"));
        Value value3 = Value.createValue("8.7".getBytes());
        store.put(key3, value3);

        String result3 = new String(store.get(key3).getValue().getValue());
        System.out.println(key3.toString() + " : " + result3);

        //multivalue get
        Key majorKeyPathOnly = Key.createKey(Arrays.asList("movie", "92616"));
        Map<Key, ValueVersion> fields = store.multiGet(majorKeyPathOnly, null, null);
        for (Map.Entry<Key, ValueVersion> field : fields.entrySet()) {
            String fieldName = field.getKey().getMinorPath().get(0);
            String fieldValue = new String(field.getValue().getValue().getValue());
            System.out.println("\t" + fieldName + "\t: " + fieldValue);
        }

        store.close();
    }

}