using DataBaseModels.Models;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace Contracts {
    public interface IEventService {
        Task<List<Event>> GetEvents();
        Task<Event> GetEvent(Guid id);
        Task Change(Event entity);
        Task Save(Event entity);
        Task Delete(Event entity);
        bool Exist(Guid id);
        void Subscribe(Event entity, string userId);
        void Unsubscribe(Guid entityId, string userId);
    }
}
