import oracle.kv.*;
import java.sql.SQLException;


/**
 * Created by lac26 on 5/9/2017.
 */
public class GetMovieActorRoles {

    public static void main(String[] args) throws SQLException {
        KVStore store = KVStoreFactory.getStore(new KVStoreConfig("kvstore", "localhost:5000"));
        store.close();
    }

}
