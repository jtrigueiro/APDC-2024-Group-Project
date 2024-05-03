package pt.unl.fct.di.apdc.firstwebapp.resources;

import com.google.cloud.datastore.Entity;

public class PermissionsResource {

    public PermissionsResource() {
    }

    public enum Role {
        SU(4), // Super-User
        GA(3), // Gestao da Aplicacao
        GBO(2), // Gestao Back Office
        USER(1); // Utilizador normal

        int permissionLevel;

        Role(int permissionLevel) {
            this.permissionLevel = permissionLevel;
        }
    }

    public enum State {
        ENABLED,
        DISABLED
    }

    public static boolean canChangeRole(Entity user, Entity targetUser) {
        try {
            Role role = Role.valueOf(user.getString("user_role"));
            Role targetRole = Role.valueOf(targetUser.getString("user_role"));

            switch (role) {
                case SU:
                    return true;
                case GA:
                    if (role.permissionLevel > targetRole.permissionLevel)
                        return true;
                    break;
                default:
                    return false;
            }
            return false;
        } catch (IllegalArgumentException e) {
            return false;
        }
    }

    public static boolean canChangeState(Entity user, Entity targetUser) {
        try {
            Role role = Role.valueOf(user.getString("user_role"));
            Role targetRole = Role.valueOf(targetUser.getString("user_role"));

            switch (role) {
                case SU:
                    return true;
                case GA:
                    if (role.permissionLevel > targetRole.permissionLevel)
                        return true;
                    break;
                case GBO:
                    if (role.permissionLevel > targetRole.permissionLevel)
                        return true;
                    break;
                default:
                    return false;
            }
            return false;
        } catch (IllegalArgumentException e) {
            return false;
        }
    }

    public static State changeState(Entity targetUser) {
        try {
            State state = State.valueOf(targetUser.getString("user_state"));
            if (state == State.ENABLED)
                return State.DISABLED;
            else
                return State.ENABLED;
        } catch (IllegalArgumentException e) {
            return State.DISABLED;
        }
    }

    public static boolean canRemoveUser(Entity user, Entity targetUser) {
        try {
            Role role = Role.valueOf(user.getString("user_role"));
            Role targetRole = Role.valueOf(targetUser.getString("user_role"));

            switch (role) {
                case SU:
                    return true;
                case GA:
                    if (role.permissionLevel > targetRole.permissionLevel)
                        return true;
                    break;
                case USER:
                    if (user.getString("user_username").equals(targetUser.getString("user_username")))
                        return true;
                    break;
                default:
                    return false;
            }
            return false;
        } catch (IllegalArgumentException e) {
            return false;
        }
    }

    public static boolean canEditUser(Entity user, Entity targetUser) {
        try {
            Role role = Role.valueOf(user.getString("user_role"));
            Role targetRole = Role.valueOf(targetUser.getString("user_role"));

            switch (role) {
                case SU:
                    return true;
                case GA:
                    if (role.permissionLevel > targetRole.permissionLevel)
                        return true;
                    break;
                case GBO:
                    if (role.permissionLevel > targetRole.permissionLevel)
                        return true;
                    break;
                case USER:
                    if (user.getString("user_username").equals(targetUser.getString("user_username")))
                        return true;
                    break;
                default:
                    return false;
            }
            return false;
        } catch (IllegalArgumentException e) {
            return false;
        }
    }

    public static boolean canListUsers(Entity user, Entity targetUser) {
        try {
            Role role = Role.valueOf(user.getString("user_role"));
            Role targetRole = Role.valueOf(targetUser.getString("user_role"));
            boolean targetIsPrivate = targetUser.getBoolean("user_is_private");
            switch (role) {
                case SU:
                    return true;
                case GA:
                    if (role.permissionLevel >= targetRole.permissionLevel)
                        return true;
                    break;
                case GBO:
                    if (role.permissionLevel > targetRole.permissionLevel)
                        return true;
                    break;
                case USER:
                    if (role.permissionLevel == targetRole.permissionLevel && targetIsPrivate == false)
                        return true;
                    break;
                default:
                    return false;
            }
            return false;
        } catch (IllegalArgumentException e) {
            return false;
        }
    }
}
