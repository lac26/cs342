/**
 * Created by lac26 on 5/10/2017.
 * This class is useful for storing information related to a movie and thus makes sorting easier.
 * (another implementation for sorting would have been a hashtable, but since there were duplicate years I would have had to make the value an array,
 * this seemed just (if not more) efficient)
 * Movie stores and provides getters for year,title, and id
 */
public class Movie {
    private Integer year;
    private String title;
    private String id;

    public Movie(Integer year, String title, String id){
        this.year = year;
        this.title = title;
        this.id = id;
    }

    public Integer getYear(){
        return  year;
    }

    public String getTitle(){
        return title;
    }

    public String getId(){
        return id;
    }

}
