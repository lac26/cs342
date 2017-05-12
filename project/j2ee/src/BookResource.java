import modules.*;
import modules.ConditionEntity;

import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.util.List;


/**
 * This stateless session bean serves as a RESTful resource handler for the BookDB.
 * It uses a container-managed entity manager.
 *
 * @author lac26
 * @version Spring, 2017
 */
@Stateless
@Path("bookDB")
public class BookResource {

    /**
     * JPA creates and maintains a managed entity manager with an integrated JTA that we can inject here.
     * E.g., http://wiki.eclipse.org/EclipseLink/Examples/REST/GettingStarted
     */
    @PersistenceContext
    private EntityManager em;

    /**
     * GET a default message.
     *
     * @return a static hello-world message
     */
    @GET
    @Path("hello")
    @Produces("text/plain")
    public String getClichedMessage() {
        return "Hello, JPA!";
    }

    /**
     * GET an individual book record.
     *
     * @param id the ID of the book to retrieve
     * @return a book record
     */
    @GET
    @Path("book/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public BookEntity getBook(@PathParam("id") long id) {
        return em.find(BookEntity.class, id);
    }

    /**
     * GET all books using the criteria query API.
     * This could be refactored to use a JPQL query, but this entitymanager-based approach
     * is consistent with the other handlers.
     *
     * @return a list of all book records
     */
    @GET
    @Path("books")
    @Produces(MediaType.APPLICATION_JSON)
    public List<BookEntity> getBooks() {
        return em.createQuery(em.getCriteriaBuilder().createQuery(BookEntity.class)).getResultList();
    }

    /*
        DELETE deletes a book by its id
        @param id of the book to delete
        @return a message specifying if delete was successful
      */
    @DELETE
    @Path("book/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public String deletePersonById(@PathParam("id") long id) {
        if (em.find(BookEntity.class, id) == null) {
            return "Person does not exist - please try another person.  Book id: " + id;
        } else {
            em.remove(em.find(BookEntity.class, id));
            return "Person successfully deleted from the database.  Book id: " + id;
        }
    }

    /* PUT reads person in JSON format and updates existing book with that book's data
        @param id is the id of the book to update
        @param newBook is the updated book information in the request formatted in JSON
        @return either an error message or the updated book record
     */
    @PUT
    @Path("book/{id}")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public Response putBook(BookEntity newBook, @PathParam("id") long id) {
        BookEntity toUpdate = em.find(BookEntity.class, id);
        if (toUpdate == null || id != newBook.getId()) {
            return Response.serverError().entity("Invalid id!").build();
        }

        //set the condition adn the description text of the condition of the new book to correspond with the
        // condition as specified in the key 'cond'
        newBook.setCondition(em.find(ConditionEntity.class, newBook.getCondition().getCond()));

        //check to make sure the groups exist
        List<SharegroupEntity> updateGroups = newBook.getGroups();
        for (SharegroupEntity se : updateGroups) {
            if ((em.find(SharegroupEntity.class, se.getId())) == null) {
                return Response.serverError().entity("please enter a group that exists").build();
            }
        }

        //check to make sure the collections exist
        List<CollectionEntity> updateCollections  = newBook.getCollections();
        for (CollectionEntity ce : updateCollections) {
            if ((em.find(SharegroupEntity.class, ce.getId())) == null) {
                return Response.serverError().entity("please enter a group that exists").build();
            }
        }

        toUpdate = em.merge(newBook);

        return Response.ok(em.find(BookEntity.class, id), MediaType.APPLICATION_JSON).build();
    }

    /**
     * POST a new Book
     * @param newBook, the Book we want to Post
     * @return the Book
     */
    @POST
    @Path("/book")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public Response postPerson(BookEntity newBook) {

        BookEntity b = new BookEntity();
        b.setAuthor(b.getAuthor());
        b.setTitle(b.getTitle());
        b.setEdition(b.getEdition());

        //set the other condition fields to correspond to condition
        ConditionEntity bookCond = newBook.getCondition();
        ConditionEntity correspondingCond = em.find(ConditionEntity.class, bookCond.getCond());
        b.setCondition(correspondingCond);


        //check to make sure the groups exist
        List<SharegroupEntity> updateGroups = newBook.getGroups();
        for (SharegroupEntity se : updateGroups) {
            if ((em.find(SharegroupEntity.class, se.getId())) == null) {
                return Response.serverError().entity("please enter a group that exists").build();
            }
        }
        b.setGroups(newBook.getGroups());


        //check to make sure the collections exist
        List<CollectionEntity> updateCollections  = newBook.getCollections();
        for (CollectionEntity ce : updateCollections) {
            if ((em.find(SharegroupEntity.class, ce.getId())) == null) {
                return Response.serverError().entity("please enter a group that exists").build();
            }
        }
        b.setCollections(newBook.getCollections());


        //myPerson.setTeams(newPerson.getTeams());
        em.persist(b);
        return Response.ok(b, MediaType.APPLICATION_JSON).build();

    }
}