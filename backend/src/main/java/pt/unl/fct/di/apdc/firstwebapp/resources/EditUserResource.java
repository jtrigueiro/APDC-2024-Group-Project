package pt.unl.fct.di.apdc.firstwebapp.resources;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.google.cloud.datastore.*;

import pt.unl.fct.di.apdc.firstwebapp.util.NewPasswordData;
import pt.unl.fct.di.apdc.firstwebapp.util.NewUserData;
import pt.unl.fct.di.apdc.firstwebapp.resources.PermissionsResource.*;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.apache.commons.codec.digest.DigestUtils;

import java.util.logging.Logger;

@Path("/edit")
@Produces(MediaType.APPLICATION_JSON + ";charset=utf-8")
public class EditUserResource {
    private static final Logger LOG = Logger.getLogger(EditUserResource.class.getName());
    private final Datastore datastore = DatastoreOptions.getDefaultInstance().getService();
    private final KeyFactory userKeyFactory = datastore.newKeyFactory().setKind("User");
    private final KeyFactory tokenKeyFactory = datastore.newKeyFactory().setKind("Token");

    public EditUserResource() {
    }

    @PUT
    @Path("/user")
    @JsonCreator
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON + ";charset=utf-8")
    public Response changeAttributes(@JsonProperty("data") NewUserData data) {
        Key userKey = userKeyFactory.newKey(data.token.username);
        Key targetUserKey = userKeyFactory.newKey(data.targetUsername);
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
        Entity targetUser = datastore.get(targetUserKey);
        boolean userExists;
        try {
            userExists = targetUser.getString("user_username").equals(data.targetUsername);
        } catch (Exception e) {
            userExists = false;
        }
        if (!userExists) {
            LOG.warning("Target user not found");
            return Response.status(Response.Status.FORBIDDEN).entity("Target's username doesn't exist.").build();
        }

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

        if (!PermissionsResource.canEditUser(user, targetUser)) {
            LOG.warning("User doesn't have permition to edit target's attributes");
            return Response.status(Response.Status.FORBIDDEN)
                    .entity("User doesn't have permition to edit target's attributes").build();
        } else {
            Transaction txn = datastore.newTransaction();

            try {
                Entity updatedTargetUser;
                if (user.getString("user_role").equals(Role.USER.toString())) {
                    updatedTargetUser = Entity.newBuilder(targetUserKey, targetUser)
                            .set("user_phone_number",
                                    getAttribute(targetUser.getString("user_phone_number"), data.phoneNumber))
                            .set("user_job", getAttribute(targetUser.getString("user_job"), data.job))
                            .set("user_work_place",
                                    getAttribute(targetUser.getString("user_work_place"), data.workPlace))
                            .set("user_address", getAttribute(targetUser.getString("user_address"), data.address))
                            .set("user_postal_code",
                                    getAttribute(targetUser.getString("user_postal_code"), data.postalCode))
                            .set("user_NIF", getAttribute(targetUser.getString("user_NIF"), data.NIF))
                            .set("user_is_private", data.isPrivate)
                            .build();
                } else {
                    updatedTargetUser = Entity.newBuilder(targetUserKey, targetUser)
                            .set("user_name", getAttribute(targetUser.getString("user_name"), data.name))
                            .set("user_phone_number",
                                    getAttribute(targetUser.getString("user_phone_number"), data.phoneNumber))
                            .set("user_email", getAttribute(targetUser.getString("user_email"), data.email))
                            .set("user_job", getAttribute(targetUser.getString("user_job"), data.job))
                            .set("user_work_place",
                                    getAttribute(targetUser.getString("user_work_place"), data.workPlace))
                            .set("user_address", getAttribute(targetUser.getString("user_address"), data.address))
                            .set("user_postal_code",
                                    getAttribute(targetUser.getString("user_postal_code"), data.postalCode))
                            .set("user_NIF", getAttribute(targetUser.getString("user_NIF"), data.NIF))
                            .set("user_is_private", data.isPrivate)
                            .build();
                }

                LOG.info("User " + data.token.username + " edited user " + data.targetUsername + " attributes");
                txn.update(updatedTargetUser);
                txn.commit();
                return Response
                        .ok("User " + data.token.username + " edited user " + data.targetUsername + " attributes")
                        .build();
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

    private String getAttribute(String userAttribute, String newAttribute) {
        if (newAttribute.equals(""))
            return userAttribute;
        else
            return newAttribute;
    }

    @PUT
    @Path("/password")
    @JsonCreator
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON + ";charset=utf-8") // produz sempre dados em json
    public Response changePassword(@JsonProperty("data") NewPasswordData data) {
        LOG.fine("Attempt to change password for user: " + data.token.username);
        Key userKey = userKeyFactory.newKey(data.token.username);
        Key tokenKey = tokenKeyFactory.newKey(data.token.username);

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
            LOG.warning("User not found");
            return Response.status(Response.Status.FORBIDDEN).entity("User logged in doesn't exist.").build();
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

        if (user.getString("user_state").equals(State.DISABLED.toString())) {
            LOG.warning("User account is disabled");
            return Response.status(Response.Status.FORBIDDEN).entity("User account is disabled.").build();
        }

        if (!user.getString("user_pwd").equals(DigestUtils.sha512Hex(data.password))) {
            LOG.warning("Current password is incorrect");
            return Response.status(Response.Status.FORBIDDEN).entity("Current password is incorrect.").build();
        }
        Transaction txn = datastore.newTransaction();

        try {
            Entity updatedUser = Entity.newBuilder(userKey, user)
                    .set("user_pwd", DigestUtils.sha512Hex(data.newPassword))
                    .build();
            txn.update(updatedUser);
            txn.commit();
            LOG.info("User " + data.token.username + " updated it's password");
            return Response.ok("User " + data.token.username + " updated it's password").build();

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
