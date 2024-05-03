package pt.unl.fct.di.apdc.firstwebapp.util;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;

public class NewUserData {

    public String targetUsername, name, phoneNumber, email, job, workPlace, address, postalCode, NIF;
    public boolean isPrivate;
    public AuthToken token;

    public NewUserData() {

    }

    @JsonCreator
    public NewUserData(@JsonProperty("targetUsername") String targetUsername, @JsonProperty("name") String name,
            @JsonProperty("phoneNumber") String phoneNumber,
            @JsonProperty("email") String email, @JsonProperty("job") String job,
            @JsonProperty("workPlace") String workPlace, @JsonProperty("address") String address,
            @JsonProperty("postalCode") String postalCode, @JsonProperty("NIF") String NIF,
            @JsonProperty("isPrivate") boolean isPrivate, @JsonProperty("token") AuthToken token) {
        this.targetUsername = targetUsername;
        this.name = name;
        this.phoneNumber = phoneNumber;
        this.email = email;
        this.job = job;
        this.workPlace = workPlace;
        this.address = address;
        this.postalCode = postalCode;
        this.NIF = NIF;
        this.isPrivate = isPrivate;
        this.token = token;
    }
}
