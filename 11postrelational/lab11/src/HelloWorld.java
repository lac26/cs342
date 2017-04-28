import javax.ws.rs.*;

// The Java class will be hosted at the URI path "/helloworld"
@Path("/hello")
public class HelloWorld {
    // The Java method will process HTTP GET requests

    @Path("/api")
    @GET
    @Produces("text/plain")
    public String getMessage() {
        return "Getting...";
    }

    @Path("/api/{var1}")
    @PUT
    @Produces("text/plain")
    public String doPut(@PathParam("var1") Integer myNum){
        return "Putting  " + myNum;
    }

    @Path("/api/{stringVar}")
    @POST
    @Produces("text/plain")
    public String doPost(@PathParam("stringVar") String myString){
        return "string is " + myString;
    }

    @Path("/api/{delVar}")
    @DELETE
    @Produces("text/plain")
    public String doDelete(@PathParam("delVar") Integer toDelete){
        if(toDelete<0 || toDelete>9){
            return "please return a value between 0 and 9";
        }
        else {
            return "deleting " + toDelete;
        }
    }

}