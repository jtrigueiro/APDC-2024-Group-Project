package pt.unl.fct.di.apdc.firstwebapp.util;

import pt.unl.fct.di.apdc.firstwebapp.resources.PermissionsResource.Role;
import pt.unl.fct.di.apdc.firstwebapp.resources.PermissionsResource.State;

public class RegisterData {

    public String username, password, name, phoneNumber, email, job, workPlace, address, postalCode, NIF;
    public Role role;
    public State state;
    public boolean isPrivate;

    public RegisterData() {

    }

    public RegisterData(String username, String password, String name, String phoneNumber, String email, String job,
            String workPlace, String address, String postalCode, String NIF, boolean isPrivate, Role role,
            State state) {
        this.username = username;
        this.password = password;
        this.name = name;
        this.phoneNumber = phoneNumber;
        this.email = email;
        this.job = job;
        this.workPlace = workPlace;
        this.address = address;
        this.postalCode = postalCode;
        this.NIF = NIF;
        this.isPrivate = isPrivate;
        this.role = role;
        this.state = state;

    }

    public boolean validRegistration() {
        return !(username == null && password == null && email == null && phoneNumber == null);
    }

}
