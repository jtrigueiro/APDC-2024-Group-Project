package pt.unl.fct.di.apdc.firstwebapp.util;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;

public class ListData {
    public AuthToken token;

    public ListData() {
    }

    @JsonCreator
    public ListData(@JsonProperty("token") AuthToken token) {
        this.token = token;
    }
}