package pt.unl.fct.di.apdc.firstwebapp.resources;

import java.util.logging.Logger;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.*;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.HttpHeaders;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import com.google.cloud.Timestamp;
import com.google.cloud.datastore.*;
import com.google.gson.Gson;
import org.apache.commons.codec.digest.DigestUtils;
import pt.unl.fct.di.apdc.firstwebapp.resources.PermissionsResource.State;
import pt.unl.fct.di.apdc.firstwebapp.util.AuthToken;
import pt.unl.fct.di.apdc.firstwebapp.util.LoginData;

@Path("/login")
@Produces(MediaType.APPLICATION_JSON + ";charset=utf-8")
public class LoginResource {

    private static final Logger LOG = Logger.getLogger(LoginResource.class.getName());
    private final Gson g = new Gson();
    private final Datastore datastore = DatastoreOptions.getDefaultInstance().getService();
    private final KeyFactory userKeyFactory = datastore.newKeyFactory().setKind("User");

    public LoginResource() {
    }

    @POST
    @Path("/")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON + ";charset=utf-8")
    public Response doLogin(LoginData data, @Context HttpServletRequest request,
            @Context HttpHeaders headers) {
        LOG.fine("Attempt to login user: " + data.username);
        // Keys should be generated outside transactions
        // Construct the key from the username
        Key userKey = userKeyFactory.newKey(data.username);
        Key ctrsKey = datastore.newKeyFactory().addAncestor(PathElement.of("User", data.username))
                .setKind("UserStats").newKey("counters");
        // Generate automatically a key
        Key logKey = datastore.allocateId(
                datastore.newKeyFactory().addAncestor(PathElement.of("User", data.username))
                        .setKind("UserLog").newKey());
        // Generate automatically token key
        Key tokenKey = datastore.newKeyFactory().setKind("Token").newKey(data.username);

        Transaction txn = datastore.newTransaction();
        try {
            Entity user = txn.get(userKey);
            boolean userExists;
            try {
                userExists = user.getString("user_username").equals(data.username);
            } catch (Exception e) {
                userExists = false;
            }
            if (!userExists) {
                // Username does not exist
                LOG.warning("Failed login attempt for username: " + data.username);
                return Response.status(Response.Status.FORBIDDEN).entity("Username does not exist").build();
            }
            // check if the user is disabled
            if (user.getString("user_state").equals(State.DISABLED.toString())) {
                LOG.warning("Failed login attempt for username: " + data.username + " - user is disabled");
                return Response.status(Response.Status.FORBIDDEN).entity("User is not enabled!").build();
            }

            // We get the suer stats from the storage
            Entity stats = txn.get(ctrsKey);
            if (stats == null) {
                stats = Entity.newBuilder(ctrsKey)
                        .set("user_stats_logins", 0L)
                        .set("user_stats_failed", 0L)
                        .set("user_first_login", Timestamp.now())
                        .set("user_last_login", Timestamp.now())
                        .build();
            }
            String hashedPWD = (String) user.getString("user_pwd");
            if (hashedPWD.equals(DigestUtils.sha512Hex(data.password))) {

                Entity tokenEntity = txn.get(tokenKey);
                AuthToken token;
                // If the token is not in the storage (Datastore) or it is expired
                if (tokenEntity == null || System.currentTimeMillis() > tokenEntity.getLong("token_expirationData")) {
                    token = new AuthToken(data.username);
                    // Create or update token
                    tokenEntity = Entity.newBuilder(tokenKey)
                            .set("token_id", token.tokenID)
                            .set("token_creationData", token.creationData)
                            .set("token_expirationData", token.expirationData)
                            .build();
                    txn.put(tokenEntity);
                } else {
                    token = new AuthToken(data.username, tokenEntity.getString("token_id"),
                            tokenEntity.getLong("token_creationData"), tokenEntity.getLong("token_expirationData"));
                }

                // Password is correct
                // Construct the logs
                Entity log = Entity.newBuilder(logKey)
                        .set("user_login_ip", request.getRemoteAddr())
                        .set("user_login_host", request.getRemoteHost())
                        .set("user_login_latlon",
                                // Does not index this property value
                                StringValue.newBuilder(headers.getHeaderString("X-AppEngine-CityLatLong"))
                                        .setExcludeFromIndexes(true).build())
                        .set("user_login_city", headers.getHeaderString("X-AppEngine-City"))
                        .set("user_login_country", headers.getHeaderString("X-AppEngine-Country"))
                        .set("user_login_time", Timestamp.now())
                        .build();
                // Get the user statistics and update it
                // Copying information every time a user logins maybe is not a good solution
                // (why?)
                Entity ustats = Entity.newBuilder(ctrsKey)
                        .set("user_stats_logins", 1L + stats.getLong("user_stats_logins"))
                        .set("user_stats_failed", 0L)
                        .set("user_first_login", stats.getTimestamp("user_first_login"))
                        .set("user_last_login", Timestamp.now())
                        .build();

                // Batch operation
                txn.put(log, ustats);
                txn.commit();

                // Return token
                LOG.info("User '" + data.username + "' logged in successfully with the token "
                        + (String) tokenEntity.getString("token_id"));
                return Response.ok(g.toJson(token)).build();

            } else {
                // Incorrect passowrd
                Entity ustats = Entity.newBuilder(ctrsKey)
                        .set("user_stats_logins", stats.getLong("user_stats_logins"))
                        .set("user_stats_failed", 1L + stats.getLong("user_stats_failed"))
                        .set("user_first_login", stats.getTimestamp("user_first_login"))
                        .set("user_last_login", stats.getTimestamp("user_last_login"))
                        .set("user_last_attempt", Timestamp.now())
                        .build();
                txn.put(ustats);
                txn.commit();
                LOG.warning("Wrong password for username: " + data.username);
                return Response.status(Response.Status.FORBIDDEN).entity("Wrong password.").build();
            }

        } catch (Exception e) {
            txn.rollback();
            LOG.severe(e.toString());
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR).build();
        } finally {
            if (txn.isActive()) {
                txn.rollback();
                return Response.status(Response.Status.INTERNAL_SERVER_ERROR).build();
            }
        }

    }

}
