using System;

namespace Contracts {
    public interface IUserService {
        string Authenticate(string username, string password);
    }
}
