using System;
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
using System.Security.Claims;
using Contracts;
using Microsoft.AspNetCore.Authorization;

namespace awesome_map_server.Controllers {
    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class EventsController : ControllerBase {
        private readonly ApplicationDbContext _context;
        private IMapper _mapper;
        private IEventService _eventService;

        public EventsController(ApplicationDbContext context, IMapper autoMapper, IEventService eventService) {
            _context = context;
            _mapper = autoMapper;
            _eventService = eventService;
        }

        // GET: api/Events
        [HttpGet]
        public async Task<IEnumerable<EventViewModel>> GetEvents() {

            List<Event> events = await _eventService.GetEvents();
            List<EventViewModel> listViewModels = new List<EventViewModel>();
            foreach (var item in events) {
                EventViewModel viewModel = _mapper.Map<EventViewModel>(item);
                viewModel.EventTypes = _mapper.ProjectTo<EventTypeViewModel>(item.EventTypeEvents.Select(x => x.Type).AsQueryable()).ToList();
                viewModel.SubscribersCount = item.Subscribers.Count;
                listViewModels.Add(viewModel);
            }
            return listViewModels;
        }

        // GET: api/Events/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Event>> GetEvent(Guid id) {
            var @event = await _eventService.GetEvent(id);

            if (@event == null) {
                return NotFound();
            }

            return @event;
        }

        // PUT: api/Events/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for
        // more details, see https://go.microsoft.com/fwlink/?linkid=2123754.
        [HttpPut("{id}")]
        public async Task<IActionResult> PutEvent(Guid id, EventViewModel @event) {
            if (id != @event.Id) {
                return BadRequest();
            }
            try {

                Event newEntity = _mapper.Map<Event>(@event);
                foreach (var item in @event.EventTypes)
                    newEntity.EventTypeEvents.Add(new EventTypeEvent() { Event = newEntity, TypeId = item.Id });

               await  _eventService.Change(newEntity);

                EventViewModel loadedEntity = _mapper.Map<EventViewModel>(newEntity);
                loadedEntity.EventTypes = @event.EventTypes;
                loadedEntity.SubscribersCount = newEntity.Subscribers.Count;

                return CreatedAtAction("GetEvent", new { id = @event.Id }, loadedEntity);

            } catch (DbUpdateConcurrencyException) {
                if (!_eventService.Exist(id)) {
                    return NotFound();
                } else {
                    throw;
                }
            }
        }

        // POST: api/Events
        // To protect from overposting attacks, enable the specific properties you want to bind to, for
        // more details, see https://go.microsoft.com/fwlink/?linkid=2123754.
        [HttpPost]
        public async Task<ActionResult<EventViewModel>> PostEvent(EventViewModel @event) {
            string userId = User.FindFirstValue(ClaimTypes.NameIdentifier);

            Event newEntity = _mapper.Map<Event>(@event);
            newEntity.OwnerId = userId;
            foreach (var item in @event.EventTypes)
                newEntity.EventTypeEvents.Add(new EventTypeEvent() { Event = newEntity, TypeId = item.Id });

            await _eventService.Save(newEntity);
            _eventService.Subscribe(newEntity, userId);

            EventViewModel loadedEntity = _mapper.Map<EventViewModel>(newEntity);
            loadedEntity.EventTypes = @event.EventTypes;
            loadedEntity.SubscribersCount = newEntity.Subscribers.Count;

            return CreatedAtAction("GetEvent", new { id = @event.Id }, loadedEntity);
        }

        // DELETE: api/Events/5
        [HttpDelete("{id}")]
        public async Task<ActionResult<Event>> DeleteEvent(Guid id) {
            var @event = await _eventService.GetEvent(id);
            if (@event == null) {
                return NotFound();
            }

            _context.Events.Remove(@event);
            await _context.SaveChangesAsync();

            return @event;
        }

        [HttpPost("Subscribe")]
        public IActionResult Subscribe([FromBody] Guid eventId) {
            string userId = User.FindFirstValue(ClaimTypes.NameIdentifier);

            Event entity = _context.Events.FirstOrDefault(x => x.Id == eventId);
            if (entity == null)
                return NotFound();
            try {
                _eventService.Subscribe(entity, userId);
            } catch (Exception e) {
                return BadRequest();
            }
            return Ok(true);
        }

        [HttpPost("Unsubscribe")]
        public IActionResult Unubscribe([FromBody] Guid eventId) {
            string userId = User.FindFirstValue(ClaimTypes.NameIdentifier);
            try {
                _eventService.Unsubscribe(eventId,userId);
            } catch (Exception e) {
                return BadRequest();
            }
            return Ok(true);
        }
    }
}
