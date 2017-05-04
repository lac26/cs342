import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import models.PersonEntity;
import models.HouseholdEntity;
import models.TeamEntity;


import java.util.List;
import java.util.Map;


/**
 * This stateless session bean serves as a RESTful resource handler for the CPDB.
 * It uses a container-managed entity manager.
 *
 * @author kvlinden
 * @version Spring, 2017
 */
@Stateless
@Path("cpdb")
public class CPDBResource {

    /**
     * JPA creates and maintains a managed entity manager with an integrated JTA that we can inject here.
     *     E.g., http://wiki.eclipse.org/EclipseLink/Examples/REST/GettingStarted
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
     * GET an individual person record.
     *
     * @param id the ID of the person to retrieve
     * @return a person record
     */
    @GET
    @Path("person/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public PersonEntity getPerson(@PathParam("id") long id) {
        return em.find(PersonEntity.class, id);
    }

    /**
     * GET all people using the criteria query API.
     * This could be refactored to use a JPQL query, but this entitymanager-based approach
     * is consistent with the other handlers.
     *
     * @return a list of all person records
     */
    @GET
    @Path("people")
    @Produces(MediaType.APPLICATION_JSON)
    public List<PersonEntity> getPeople() {
        return em.createQuery(em.getCriteriaBuilder().createQuery(PersonEntity.class)).getResultList();
    }

    /*
    DELETE deletes a person by its id
    @param id of the person to delete
    @return a message specifying if delete was successful
     */
    @DELETE
    @Path("person/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public String deletePersonById( @PathParam("id") long id)    {
        if(em.find(PersonEntity.class,id) == null) {
            return "Person does not exist - please try another person.  Person id: " + id;
        }
        else {
            em.remove(em.find(PersonEntity.class,id));
            return "Person successfully deleted from the database.  Person id: " + id;
        }
    }

    /* PUT reads person in JSON format and updates existing person with that persons data
    @param id is the id of the person to update
    @param newPerson is the updated person information in the request formatted in JSON
    @return either an error message or the updated person record
     */
    @PUT
    @Path("person/{id}")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public Response putPerson(PersonEntity newPerson, @PathParam("id") long id){
        PersonEntity toUpdate = em.find(PersonEntity.class, id);
        HouseholdEntity toUpateHousehold = toUpdate.getHouseHold();
        HouseholdEntity newHousehold = newPerson.getHouseHold();
        if (toUpdate.getId() != id){
            return Response.serverError().entity("please enter id of existing person").build();
        }
        //update all of the values of the person to update with the values of new person
        toUpdate.setTitle(newPerson.getTitle());
        toUpdate.setFirstname(newPerson.getFirstname());
        toUpdate.setLastname(newPerson.getLastname());
        toUpdate.setBirthdate(newPerson.getBirthdate());
        toUpdate.setMembershipstatus(newPerson.getMembershipstatus());
        toUpdate.setGender(newPerson.getGender());
        toUpdate.setBirthdate(newPerson.getBirthdate());
        toUpdate.setHouseholdrole(newPerson.getHouseholdrole());
        toUpdate.setHomegrouprole(newPerson.getHomegrouprole());

        //only update household if valid household id
        if (em.find(HouseholdEntity.class, newHousehold.getId()) != null){ //if household exists
            //if the new household id is different than the old one, set all of the variables of the household to the variables that match that id
            if(toUpateHousehold.getId() != newHousehold.getId()){ //id not same, move data over
                toUpdate.setHouseHold(em.find(HouseholdEntity.class, newHousehold.getId()));
            }
            else{ //id of the household is the same so rest of data should still be the same
                toUpdate.setHouseHold(toUpdate.getHouseHold());
            }
        }
        else{ //else household does not exist and through error
            return Response.serverError().entity("the new household id does not exist").build();
        }

        //store the teams in a list and check to see if they are valid
        List<TeamEntity> updateTeams = newPerson.getTeams();
        for (TeamEntity te: updateTeams){
            if ((em.find(TeamEntity.class, te.getName())) == null){
                return Response.serverError().entity("please enter a team that exists").build();
            }
        }

        toUpdate.setTeams(newPerson.getTeams());
        em.merge(toUpdate);
        return Response.ok(em.find(PersonEntity.class,id), MediaType.APPLICATION_JSON).build();
    }

    /* POST reads in a new person and creates a corresponding entry for the person
    @param newPerson is new person data formatted in JSON in the request
    @return response with new person that has been added to the database
     */
    @POST
    @Path("people")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public Response postPerson(PersonEntity newPerson){
        PersonEntity myPerson = new PersonEntity();
        myPerson.setTitle(newPerson.getTitle());
        myPerson.setFirstname(newPerson.getFirstname());
        myPerson.setLastname(newPerson.getLastname());
        myPerson.setBirthdate(newPerson.getBirthdate());
        myPerson.setMembershipstatus(newPerson.getMembershipstatus());
        myPerson.setGender(newPerson.getGender());
        myPerson.setBirthdate(newPerson.getBirthdate());
        myPerson.setHouseholdrole(newPerson.getHouseholdrole());
        myPerson.setHomegrouprole(newPerson.getHomegrouprole());

        //set person to existing household with the ID in the passed person entity
        //id in passed person entity
        long passedId = newPerson.getId();
        //get the corresponding household
        HouseholdEntity correspondingHouse = em.find(HouseholdEntity.class, passedId);
        //assuming the household record for the id exists so not doing error checking

        //set the household id to the appropriate id
        myPerson.setHouseHold(correspondingHouse);

        List<TeamEntity> updateTeams = newPerson.getTeams();
        for (TeamEntity te: updateTeams){
            if ((em.find(TeamEntity.class, te.getName())) == null){
                return Response.serverError().entity("please enter a team that exists").build();
            }
        }

        myPerson.setTeams(newPerson.getTeams());
        em.persist(myPerson);
        return Response.ok(newPerson, MediaType.APPLICATION_JSON).build();
    }



}