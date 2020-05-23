﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using DataBaseModels.Models;
using DataBaseContext;
using awesome_map_server.ViewModels;
using AutoMapper;

namespace awesome_map_server.Controllers {
    [Route("api/[controller]")]
    [ApiController]
    public class EventsController : ControllerBase {
        private readonly ApplicationDbContext _context;
        private IMapper _mapper;

        public EventsController(ApplicationDbContext context, IMapper autoMapper) {
            _context = context;
            _mapper = autoMapper;

        }

        // GET: api/Events
        [HttpGet]
        public async Task<ActionResult<IEnumerable<EventViewModel>>> GetEvents() {

            List<Event> events = await _context.Events
             .Include(x => x.Files)
             .Include(x => x.EventTypeEvents).ThenInclude(x => x.Type)
             .ThenInclude(x => x.Icon)
             .ToListAsync();
            List<EventViewModel> listViewModels = new List<EventViewModel>();
            foreach (var item in events) {
                EventViewModel viewModel = _mapper.Map<EventViewModel>(item);
                viewModel.EventTypes = item.EventTypeEvents.Select(x => x.Type).AsQueryable().ToList();
                viewModel.SubscribersCount = item.Subscribers.Count;
                listViewModels.Add(viewModel);
            }
            return listViewModels;
        }

        // GET: api/Events/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Event>> GetEvent(Guid id) {
            var @event = await _context.Events.FindAsync(id);

            if (@event == null) {
                return NotFound();
            }

            return @event;
        }

        // PUT: api/Events/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for
        // more details, see https://go.microsoft.com/fwlink/?linkid=2123754.
        [HttpPut("{id}")]
        public async Task<IActionResult> PutEvent(Guid id, Event @event) {
            if (id != @event.Id) {
                return BadRequest();
            }

            _context.Entry(@event).State = EntityState.Modified;

            try {
                await _context.SaveChangesAsync();
            } catch (DbUpdateConcurrencyException) {
                if (!EventExists(id)) {
                    return NotFound();
                } else {
                    throw;
                }
            }

            return NoContent();
        }

        // POST: api/Events
        // To protect from overposting attacks, enable the specific properties you want to bind to, for
        // more details, see https://go.microsoft.com/fwlink/?linkid=2123754.
        [HttpPost]
        public async Task<ActionResult<EventViewModel>> PostEvent(EventViewModel @event) {
            Event newEntity = _mapper.Map<Event>(@event);
            newEntity.CreateDate = DateTime.Now;

            foreach (var item in @event.EventTypes)
                newEntity.EventTypeEvents.Add(new EventTypeEvent() { Event = newEntity, TypeId = item.Id });

            _context.Events.Add(newEntity);
            await _context.SaveChangesAsync();

            EventViewModel loadedEntity = _mapper.Map<EventViewModel>(newEntity);
            loadedEntity.EventTypes = @event.EventTypes;
            loadedEntity.SubscribersCount = newEntity.Subscribers.Count;

            return CreatedAtAction("GetEvent", new { id = @event.Id }, @event);
        }

        // DELETE: api/Events/5
        [HttpDelete("{id}")]
        public async Task<ActionResult<Event>> DeleteEvent(Guid id) {
            var @event = await _context.Events.FindAsync(id);
            if (@event == null) {
                return NotFound();
            }

            _context.Events.Remove(@event);
            await _context.SaveChangesAsync();

            return @event;
        }

        private bool EventExists(Guid id) {
            return _context.Events.Any(e => e.Id == id);
        }
    }
}