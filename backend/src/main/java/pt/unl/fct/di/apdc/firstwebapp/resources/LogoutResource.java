package pt.unl.fct.di.apdc.firstwebapp.resources;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.google.cloud.datastore.*;
import pt.unl.fct.di.apdc.firstwebapp.util.NewUserData;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.util.logging.Logger;

@Path("/logout")
@Produces(MediaType.APPLICATION_JSON + ";charset=utf-8")
public class LogoutResource {
    private static final Logger LOG = Logger.getLogger(LogoutResource.class.getName());
    private final Datastore datastore = DatastoreOptions.getDefaultInstance().getService();
    private final KeyFactory userKeyFactory = datastore.newKeyFactory().setKind("User");
    private final KeyFactory tokenKeyFactory = datastore.newKeyFactory().setKind("Token");

    public LogoutResource() {
    }

    @DELETE
    @Path("/")
    @JsonCreator
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON + ";charset=utf-8")
    public Response doLogout(@JsonProperty("data") NewUserData data) {
        Key tokenKey = tokenKeyFactory.newKey(data.token.username);
        Key userKey = userKeyFactory.newKey(data.token.username);

        Entity user = datastore.get(userKey);
        Entity userToken = datastore.get(tokenKey);
        if (userToken == null) {
            LOG.warning("Token not found, no login made");
            return Response.status(Response.Status.FORBIDDEN).entity("Token not found, please login.").build();
        }

        boolean userExists;
        try {
            userExists = user.getString("user_username").equals(data.token.username);
        } catch (Exception e) {
            userExists = false;
        }
        if (!userExists) {
            LOG.warning("Target user not found");
            return Response.status(Response.Status.FORBIDDEN).entity("User logged in doesn't exist.").build();
        }

        if (!data.token.tokenID.equals(userToken.getString("token_id"))) {
            LOG.warning("User has an invalid token");
            return Response.status(Response.Status.FORBIDDEN).entity("Token id is invalid, please login again.")
                    .build();
        }

        Transaction txn = datastore.newTransaction();

        try {
            txn.delete(tokenKey);
            LOG.info("User " + data.token.username + " logged out");
            txn.commit();
            return Response.ok("User " + data.token.username + " logged out").build();
        } catch (Exception e) {
            txn.rollback();
            LOG.severe(e.getMessage());
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR).build();
        } finally {
            if (txn.isActive()) {
                txn.rollback();
                return Response.status(Response.Status.INTERNAL_SERVER_ERROR).build();
            }
        }

    }
}
