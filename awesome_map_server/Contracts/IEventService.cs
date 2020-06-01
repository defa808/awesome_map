using DataBaseModels.Models;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace Contracts {
    public interface IEventService {
        Task<List<Event>> GetEvents();
        Task<Event> GetEvent(Guid id);
        void Change(Event entity);
        void Save(Event entity);
        void Delete(Event entity);
        bool Exist(Guid id);
        void Subscribe(Event entity, string userId);
        void Unsubscribe(Guid entityId, string userId);
    }
}
