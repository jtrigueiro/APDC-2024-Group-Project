package pt.unl.fct.di.apdc.firstwebapp.resources;

import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.google.cloud.datastore.*;
import com.google.gson.Gson;

import pt.unl.fct.di.apdc.firstwebapp.util.ListData;
import pt.unl.fct.di.apdc.firstwebapp.util.PermissionsData;
import pt.unl.fct.di.apdc.firstwebapp.util.UserData;
import pt.unl.fct.di.apdc.firstwebapp.resources.PermissionsResource.*;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

@Path("/list")
@Produces(MediaType.APPLICATION_JSON + ";charset=utf-8")
public class ListResource {

    private static final Logger LOG = Logger.getLogger(ListResource.class.getName());
    private final Datastore datastore = DatastoreOptions.getDefaultInstance().getService();
    private final KeyFactory userKeyFactory = datastore.newKeyFactory().setKind("User");
    private final KeyFactory tokenKeyFactory = datastore.newKeyFactory().setKind("Token");
    private final Gson g = new Gson();

    public ListResource() {
    }

    @POST
    @Path("/users")
    @JsonCreator
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON + ";charset=utf-8")
    public Response listUsers(@JsonProperty("data") ListData data) {
        Key userKey = userKeyFactory.newKey(data.token.username);
        Key tokenKey = tokenKeyFactory.newKey(data.token.username);

        Entity userToken = datastore.get(tokenKey);
        if (userToken == null) {
            LOG.warning("Token not found, no login made");
            return Response.status(Response.Status.FORBIDDEN).entity("Token not found, please login.").build();
        }

        if (!data.token.tokenID.equals(userToken.getString("token_id"))) {
            LOG.warning("User has an invalid token");
            return Response.status(Response.Status.FORBIDDEN).entity("Token id is invalid, please login again.")
                    .build();
        }

        if (System.currentTimeMillis() > userToken.getLong("token_expirationData")) {
            LOG.warning("Token time has expired");
            return Response.status(Response.Status.FORBIDDEN).entity("Token time has expired, please login again.")
                    .build();
        }

        Entity user = datastore.get(userKey);
        boolean userExists;
        try {
            userExists = user.getString("user_username").equals(data.token.username);
        } catch (Exception e) {
            userExists = false;
        }
        if (!userExists) {
            LOG.warning("User not found");
            return Response.status(Response.Status.FORBIDDEN).entity("User logged in doesn't exist.").build();
        }

        if (user.getString("user_state").equals(State.DISABLED.toString())) {
            LOG.warning("User account is disabled");
            return Response.status(Response.Status.FORBIDDEN).entity("User account is disabled.").build();
        }

        Query<Entity> query = Query.newEntityQueryBuilder()
                .setKind("User")
                .build();
        QueryResults<Entity> results = datastore.run(query);
        if (!results.hasNext()) {
            LOG.warning("No users found");
            return Response.status(Response.Status.BAD_REQUEST).entity("No users found.").build();
        } else {
            List<UserData> usersList = new ArrayList<>();
            while (results.hasNext()) {
                Entity targetUserEntity = results.next();
                if (PermissionsResource.canListUsers(user, targetUserEntity)) {
                    if (user.getString("user_role").equals(Role.USER.toString())) {
                        usersList.add(new UserData(targetUserEntity.getString("user_username"),
                                targetUserEntity.getString("user_email"), targetUserEntity.getString("user_name")));
                    } else {
                        usersList.add(new UserData(targetUserEntity.getString("user_username"),
                                targetUserEntity.getString("user_name"),
                                targetUserEntity.getString("user_phone_number"),
                                targetUserEntity.getString("user_email"),
                                targetUserEntity.getString("user_job"),
                                targetUserEntity.getString("user_work_place"),
                                targetUserEntity.getString("user_address"),
                                targetUserEntity.getString("user_postal_code"),
                                targetUserEntity.getString("user_NIF"),
                                targetUserEntity.getBoolean("user_is_private"),
                                targetUserEntity.getString("user_role"),
                                targetUserEntity.getString("user_state")));
                    }
                }
            }
            LOG.info("User " + data.token.username + " listed the users");
            return Response.ok(g.toJson(usersList)).build();
        }
    }

    @POST
    @Path("/user")
    @JsonCreator
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON + ";charset=utf-8")
    public Response listUserProfile(@JsonProperty("data") ListData data) {
        Key userKey = userKeyFactory.newKey(data.token.username);
        Key tokenKey = tokenKeyFactory.newKey(data.token.username);

        Entity userToken = datastore.get(tokenKey);
        if (userToken == null) {
            LOG.warning("Token not found, no login made");
            return Response.status(Response.Status.FORBIDDEN).entity("Token not found, please login.").build();
        }

        if (!data.token.tokenID.equals(userToken.getString("token_id"))) {
            LOG.warning("User has an invalid token");
            return Response.status(Response.Status.FORBIDDEN).entity("Token id is invalid, please login again.")
                    .build();
        }

        if (System.currentTimeMillis() > userToken.getLong("token_expirationData")) {
            LOG.warning("Token time has expired");
            return Response.status(Response.Status.FORBIDDEN).entity("Token time has expired, please login again.")
                    .build();
        }

        Entity user = datastore.get(userKey);
        boolean userExists;
        try {
            userExists = user.getString("user_username").equals(data.token.username);
        } catch (Exception e) {
            userExists = false;
        }
        if (!userExists) {
            LOG.warning("User not found");
            return Response.status(Response.Status.FORBIDDEN).entity("User logged in doesn't exist.").build();
        }

        if (user.getString("user_state").equals(State.DISABLED.toString())) {
            LOG.warning("User account is disabled");
            return Response.status(Response.Status.FORBIDDEN).entity("User account is disabled.").build();
        }

        List<UserData> userList = new ArrayList<>();

        if (user.getString("user_role").equals(Role.USER.toString())) {
            userList.add(new UserData(user.getString("user_username"),
                    user.getString("user_name"),
                    user.getString("user_phone_number"),
                    user.getString("user_email"),
                    user.getString("user_job"),
                    user.getString("user_work_place"),
                    user.getString("user_address"),
                    user.getString("user_postal_code"),
                    user.getString("user_NIF"),
                    user.getBoolean("user_is_private")));
        } else {
            userList.add(new UserData(user.getString("user_username"),
                    user.getString("user_name"),
                    user.getString("user_phone_number"),
                    user.getString("user_email"),
                    user.getString("user_job"),
                    user.getString("user_work_place"),
                    user.getString("user_address"),
                    user.getString("user_postal_code"),
                    user.getString("user_NIF"),
                    user.getBoolean("user_is_private"),
                    user.getString("user_role"),
                    user.getString("user_state")));
        }

        LOG.info("User " + data.token.username + " listed it's profile");
        return Response.ok(g.toJson(userList)).build();

    }

    @POST
    @Path("/user/permissions")
    @JsonCreator
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON + ";charset=utf-8")
    public Response listUserPermissions(@JsonProperty("data") ListData data) {
        Key userKey = userKeyFactory.newKey(data.token.username);
        Key tokenKey = tokenKeyFactory.newKey(data.token.username);

        Entity userToken = datastore.get(tokenKey);
        if (userToken == null) {
            LOG.warning("Token not found, no login made");
            return Response.status(Response.Status.FORBIDDEN).entity("Token not found, please login.").build();
        }

        if (!data.token.tokenID.equals(userToken.getString("token_id"))) {
            LOG.warning("User has an invalid token");
            return Response.status(Response.Status.FORBIDDEN).entity("Token id is invalid, please login again.")
                    .build();
        }

        if (System.currentTimeMillis() > userToken.getLong("token_expirationData")) {
            LOG.warning("Token time has expired");
            return Response.status(Response.Status.FORBIDDEN).entity("Token time has expired, please login again.")
                    .build();
        }

        Entity user = datastore.get(userKey);
        boolean userExists;
        try {
            userExists = user.getString("user_username").equals(data.token.username);
        } catch (Exception e) {
            userExists = false;
        }
        if (!userExists) {
            LOG.warning("User not found");
            return Response.status(Response.Status.FORBIDDEN).entity("User logged in doesn't exist.").build();
        }

        if (user.getString("user_state").equals(State.DISABLED.toString())) {
            LOG.warning("User account is disabled");
            return Response.status(Response.Status.FORBIDDEN).entity("User account is disabled.").build();
        }

        PermissionsData permissionsData = new PermissionsData(user.getString("user_role"),
                user.getString("user_state"));

        LOG.info("User " + data.token.username + " listed it's profile");
        return Response.ok(g.toJson(permissionsData)).build();
    }

}
