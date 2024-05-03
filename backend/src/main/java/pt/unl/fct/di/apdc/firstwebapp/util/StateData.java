package pt.unl.fct.di.apdc.firstwebapp.util;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;

public class StateData {
    public String targetUsername;
    public AuthToken token;

    public StateData() {
    }

    @JsonCreator
    public StateData(@JsonProperty("targetUsername") String targetUsername, @JsonProperty("token") AuthToken token) {
        this.targetUsername = targetUsername;
        this.token = token;
    }

}
