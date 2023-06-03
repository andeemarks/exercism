using System;

enum AccountType
{
    Guest,
    User,
    Moderator
}

[Flags]
enum Permission
{
    Read = 0b001,
    Write = 0b010,
    Delete = 0b100,
    None = 0b000,
    All = Read | Write | Delete

}

static class Permissions
{
    public static Permission Default(AccountType accountType)
    {
        return accountType switch
        {
            AccountType.Guest => Permission.Read,
            AccountType.User => Permission.Read | Permission.Write,
            AccountType.Moderator => Permission.All,
            _ => Permission.None
        };
    }

    public static Permission Grant(Permission current, Permission grant)
    {
        return current | grant;
    }

    public static Permission Revoke(Permission current, Permission revoke)
    {
        return current & ~revoke;
    }

    public static bool Check(Permission current, Permission check)
    {
        return current.HasFlag(check);
    }
}
