import java.util.Arrays;

import oracle.kv.KVStore;
import oracle.kv.KVStoreConfig;
import oracle.kv.KVStoreFactory;
import oracle.kv.Key;
import oracle.kv.Value;

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
public class HelloKVLite {

    public static void main(String[] args) {

        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));

        // C(reate)
        // This initializes an arbitrary key-value pair and stores it in KVLite.
        // The key-value structure is /helloKey : $value
        String keyString = "helloKey", valueString = "Hello, Oracle NoSQL!";
        Key key = Key.createKey(Arrays.asList(keyString));
        Value value = Value.createValue(valueString.getBytes());
        store.put(key, value);

        //create 2nd key key-value pair
        String keyString2 = "helloKey2", valueString2 = "Hello again friend!";
        Key key2 = Key.createKey(Arrays.asList(keyString2));
        Value value2 = Value.createValue(valueString2.getBytes());
        store.put(key2, value2);


        // R(ead)
        // This queries KVLite using the same key.
        // The result, a byte array, is converted into a string.
        String result = new String(store.get(key).getValue().getValue());
        System.out.println(key.toString() + " : " + result);

        //read the 2nd key
        String result2 = new String(store.get(key2).getValue().getValue());
        System.out.println(key2.toString() + " : " + result2);

        // U(pdate)
        // This modifies the value, puts the new value, overwriting the old
        // value, and gets/prints it again.
        valueString = "Hello, KVLite!";
        value = Value.createValue(valueString.getBytes());
        store.put(key, value);
        result = new String(store.get(key).getValue().getValue());
        System.out.println(key.toString() + " : " + result);

        //update the 2nd key-value pair
        valueString2 = "Hello YET AGAIN friend!";
        value2 = Value.createValue(valueString2.getBytes());
        store.put(key2, value2);
        result2 = new String(store.get(key2).getValue().getValue());
        System.out.println(key.toString() + " : " + result2);

        // D(elete)
        // This deletes the key-value pair.
        store.delete(key);
        if (store.get(key) == null) {
            System.out.println("Good, key successfully deleted...");
        } else {
            System.out.println("Oops, key not deleted...");
        }

        //delete the 2nd key-value pair
        store.delete(key2);
        if(store.get(key2) == null){
            System.out.println("Good, 2nd key successfully deleted...");
        }
        else{
            System.out.println("Ooopos the 2nd key is NOT deleted");
        }


        store.close();
    }

}