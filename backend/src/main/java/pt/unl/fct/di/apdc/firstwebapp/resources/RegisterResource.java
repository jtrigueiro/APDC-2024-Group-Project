package pt.unl.fct.di.apdc.firstwebapp.resources;

import java.util.logging.Logger;

import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import com.google.cloud.Timestamp;
import com.google.cloud.datastore.*;

import org.apache.commons.codec.digest.DigestUtils;

import pt.unl.fct.di.apdc.firstwebapp.resources.PermissionsResource.Role;
import pt.unl.fct.di.apdc.firstwebapp.resources.PermissionsResource.State;

import pt.unl.fct.di.apdc.firstwebapp.util.RegisterData;

@Path("/register")
@Produces(MediaType.APPLICATION_JSON + ";charset=utf-8")
public class RegisterResource {
    /**
     * Logger Object
     */
    private static final Logger LOG = Logger.getLogger(RegisterResource.class.getName());

    private final Datastore datastore = DatastoreOptions.getDefaultInstance().getService();

    public RegisterResource() {

        // Check if there is a root user, if not add one
        Query<Entity> queryRoot = Query.newEntityQueryBuilder()
                .setKind("User")
                .setFilter(StructuredQuery.PropertyFilter.eq("user_username", "root"))
                .build();
        QueryResults<Entity> resultsRoot = datastore.run(queryRoot);
        if (!resultsRoot.hasNext())
            createRootUser();

    }

    @POST
    @Path("/")
    @Consumes(MediaType.APPLICATION_JSON)
    public Response doRegistration(RegisterData data) {
        LOG.fine("Attempt to register user:" + data.username);
        if (!data.validRegistration())
            return Response.status(Response.Status.BAD_REQUEST).entity("Missing or wrong parameter.").build();
        Transaction txn = datastore.newTransaction();
        try {
            // Creates an entity user form the data. THe key is username
            Key userKey = datastore.newKeyFactory().setKind("User").newKey(data.username);
            Entity user = txn.get(userKey);
            boolean userExists;
            try {
                userExists = user.getString("user_username").equals(data.username);
            } catch (Exception e) {
                userExists = false;
            }
            if (userExists) {
                txn.rollback();
                return Response.status(Response.Status.BAD_REQUEST).entity("Username already exists.").build();
            } else {
                // Check the number of existing users
                Query<Entity> query = Query.newEntityQueryBuilder()
                        .setKind("User")
                        .build();
                QueryResults<Entity> results = datastore.run(query);
                int userCount = 0;
                while (results.hasNext()) {
                    results.next();
                    userCount++;
                }

                if (userCount >= 4) {
                    return Response.status(Response.Status.BAD_REQUEST)
                            .entity("System maximum of 4 users reached.")
                            .build();
                }

                user = Entity.newBuilder(userKey)
                        .set("user_username", data.username)
                        .set("user_pwd", DigestUtils.sha512Hex(data.password))
                        .set("user_name", data.name)
                        .set("user_phone_number", data.phoneNumber)
                        .set("user_email", data.email)
                        .set("user_job", data.job)
                        .set("user_work_place", data.workPlace)
                        .set("user_address", data.address)
                        .set("user_postal_code", data.postalCode)
                        .set("user_NIF", data.NIF)
                        .set("user_is_private", data.isPrivate)
                        .set("user_role", Role.USER.toString())
                        .set("user_state", State.DISABLED.toString())
                        .set("user_creation_time", Timestamp.now())
                        .build();

                txn.add(user);
                LOG.info("User registered " + data.username);
                txn.commit();
                return Response.ok("User " + data.username + " was registered with success.").build();
            }

        } finally {
            if (txn.isActive()) {
                txn.rollback();
            }
        }

    }

    // Create a root user (the master admin)
    private void createRootUser() {
        Transaction txn = datastore.newTransaction();
        Key userKey = datastore.newKeyFactory().setKind("User").newKey("root");
        Entity user = txn.get(userKey);

        user = Entity.newBuilder(userKey)
                .set("user_username", "root")
                .set("user_pwd", DigestUtils.sha512Hex("root"))
                .set("user_name", "root")
                .set("user_phone_number", "")
                .set("user_email", "")
                .set("user_job", "")
                .set("user_work_place", "")
                .set("user_address", "")
                .set("user_postal_code", "")
                .set("user_NIF", "")
                .set("user_is_private", true)
                .set("user_role", Role.SU.toString())
                .set("user_state", State.ENABLED.toString())
                .set("user_creation_time", Timestamp.now())
                .build();

        txn.put(user);
        LOG.info("Root user registered");
        txn.commit();
    }

}
