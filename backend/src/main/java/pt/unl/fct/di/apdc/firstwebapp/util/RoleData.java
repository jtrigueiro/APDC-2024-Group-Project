package pt.unl.fct.di.apdc.firstwebapp.util;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;

public class RoleData {
    public String targetUsername, newRole;
    public AuthToken token;

    public RoleData() {
    }

    @JsonCreator
    public RoleData(@JsonProperty("targetUsername") String targetUsername, @JsonProperty("newRole") String newRole,
            @JsonProperty("token") AuthToken token) {
        this.targetUsername = targetUsername;
        this.newRole = newRole;
        this.token = token;
    }
}