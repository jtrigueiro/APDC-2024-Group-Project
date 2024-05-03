package pt.unl.fct.di.apdc.firstwebapp.util;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonProperty;

public class NewPasswordData {
    public String password, newPassword;
    public AuthToken token;

    public NewPasswordData() {
    }

    @JsonCreator
    public NewPasswordData(@JsonProperty("password") String password, @JsonProperty("newPassword") String newPassword,
            @JsonProperty("token") AuthToken token) {
        this.password = password;
        this.newPassword = newPassword;
        this.token = token;
    }
}