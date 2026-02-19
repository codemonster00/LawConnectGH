using System.Security.Claims;
using LawConnect.Application.DTOs.Consultations;
using LawConnect.Application.Interfaces;
using LawConnect.Domain.Entities;
using LawConnect.Domain.Enums;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace LawConnect.API.Controllers;

/// <summary>Endpoints for managing legal consultations.</summary>
[ApiController]
[Route("api/v1/consultations")]
[Authorize]
public class ConsultationsController : ControllerBase
{
    private readonly IApplicationDbContext _db;

    public ConsultationsController(IApplicationDbContext db) => _db = db;

    private Guid GetUserId() => Guid.Parse(User.FindFirstValue(ClaimTypes.NameIdentifier)!);

    /// <summary>Create a new consultation request.</summary>
    [HttpPost]
    [ProducesResponseType(typeof(ConsultationDto), StatusCodes.Status201Created)]
    public async Task<IActionResult> Create([FromBody] CreateConsultationRequest dto)
    {
        var consultation = new Consultation
        {
            ClientId = GetUserId(),
            LawyerId = dto.LawyerId,
            LegalTopicId = dto.LegalTopicId,
            Type = dto.Type,
            ProblemDescription = dto.ProblemDescription
        };
        _db.Consultations.Add(consultation);
        await _db.SaveChangesAsync();

        return CreatedAtAction(nameof(GetById), new { id = consultation.Id }, new ConsultationDto
        {
            Id = consultation.Id, ClientId = consultation.ClientId, Status = consultation.Status.ToString(),
            Type = consultation.Type.ToString(), ProblemDescription = consultation.ProblemDescription, CreatedAt = consultation.CreatedAt
        });
    }

    /// <summary>List consultations for the current user.</summary>
    [HttpGet]
    [ProducesResponseType(typeof(ConsultationListDto), StatusCodes.Status200OK)]
    public async Task<IActionResult> List()
    {
        var userId = GetUserId();
        var items = await _db.Consultations
            .Include(c => c.Client).Include(c => c.Lawyer).Include(c => c.LegalTopic)
            .Where(c => c.ClientId == userId || c.LawyerId == userId)
            .OrderByDescending(c => c.CreatedAt)
            .Select(c => new ConsultationDto
            {
                Id = c.Id, ClientId = c.ClientId, ClientName = c.Client.FullName,
                LawyerId = c.LawyerId, LawyerName = c.Lawyer != null ? c.Lawyer.FullName : null,
                LegalTopicName = c.LegalTopic != null ? c.LegalTopic.Name : null,
                Status = c.Status.ToString(), Type = c.Type.ToString(),
                DurationMinutes = c.DurationMinutes, ProblemDescription = c.ProblemDescription,
                StartedAt = c.StartedAt, EndedAt = c.EndedAt, ClientRating = c.ClientRating,
                TotalFee = c.TotalFee, CreatedAt = c.CreatedAt
            }).ToListAsync();

        return Ok(new ConsultationListDto { Items = items, TotalCount = items.Count });
    }

    /// <summary>Get a specific consultation by ID.</summary>
    [HttpGet("{id:guid}")]
    [ProducesResponseType(typeof(ConsultationDto), StatusCodes.Status200OK)]
    public async Task<IActionResult> GetById(Guid id)
    {
        var c = await _db.Consultations
            .Include(x => x.Client).Include(x => x.Lawyer).Include(x => x.LegalTopic)
            .FirstOrDefaultAsync(x => x.Id == id);
        if (c == null) return NotFound();

        return Ok(new ConsultationDto
        {
            Id = c.Id, ClientId = c.ClientId, ClientName = c.Client.FullName,
            LawyerId = c.LawyerId, LawyerName = c.Lawyer?.FullName,
            LegalTopicName = c.LegalTopic?.Name, Status = c.Status.ToString(), Type = c.Type.ToString(),
            DurationMinutes = c.DurationMinutes, ProblemDescription = c.ProblemDescription,
            StartedAt = c.StartedAt, EndedAt = c.EndedAt, ClientRating = c.ClientRating,
            TotalFee = c.TotalFee, CreatedAt = c.CreatedAt
        });
    }

    /// <summary>Mark a consultation as completed.</summary>
    [HttpPut("{id:guid}/complete")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    public async Task<IActionResult> Complete(Guid id)
    {
        var c = await _db.Consultations.FindAsync(id);
        if (c == null) return NotFound();
        c.Status = ConsultationStatus.Completed;
        c.EndedAt = DateTime.UtcNow;
        c.UpdatedAt = DateTime.UtcNow;
        await _db.SaveChangesAsync();
        return Ok(new { message = "Consultation completed" });
    }

    /// <summary>Cancel a consultation.</summary>
    [HttpPut("{id:guid}/cancel")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    public async Task<IActionResult> Cancel(Guid id)
    {
        var c = await _db.Consultations.FindAsync(id);
        if (c == null) return NotFound();
        c.Status = ConsultationStatus.Cancelled;
        c.UpdatedAt = DateTime.UtcNow;
        await _db.SaveChangesAsync();
        return Ok(new { message = "Consultation cancelled" });
    }
}
