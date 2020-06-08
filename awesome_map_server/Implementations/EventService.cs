using Contracts;
using DataBaseContext;
using DataBaseModels.Models;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Implementations {
    public class EventService : IEventService {
        private ApplicationDbContext _context;
        public EventService(ApplicationDbContext context) {
            _context = context;
        }

        public async Task Change(Event entity) {
            _context.Entry(entity).State = EntityState.Modified;
            await _context.SaveChangesAsync();
        }

        public async Task Delete(Event entity) {
            _context.Events.Remove(entity);
            await _context.SaveChangesAsync();
        }

        public bool Exist(Guid id) {
            return _context.Events.Any(e => e.Id == id);
        }

        public async Task<List<Event>> GetEvents() {
            return await _context.Events
          .Include(x => x.Files)
          .Include(x => x.Subscribers)
          .Include(x => x.EventTypeEvents).ThenInclude(x => x.Type)
          .ThenInclude(x => x.Icon)
          .ToListAsync();
        }

        public async Task<Event> GetEvent(Guid id) {
            return await _context.Events.FindAsync(id);
        }

        public async Task Save(Event entity) {
            entity.CreateDate = DateTime.Now;

            _context.Events.Add(entity);
            await _context.SaveChangesAsync();
        }

        public void Subscribe(Event entity, string userId) {
            entity.Subscribers.Add(new EventUser() { EventId = entity.Id, UserId = userId });
            _context.SaveChanges();
        }

        public void Unsubscribe(Guid entityId, string userId) {
            _context.EventUser.RemoveRange(_context.EventUser.Where(x => x.EventId == entityId && x.UserId == userId).ToList());
            _context.SaveChanges();
        }
    }
}
