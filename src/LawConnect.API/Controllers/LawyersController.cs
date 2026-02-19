using LawConnect.Application.DTOs.Lawyers;
using LawConnect.Application.Interfaces;
using LawConnect.Domain.Enums;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace LawConnect.API.Controllers;

/// <summary>Endpoints for searching and managing lawyer profiles.</summary>
[ApiController]
[Route("api/v1/lawyers")]
public class LawyersController : ControllerBase
{
    private readonly IApplicationDbContext _db;

    public LawyersController(IApplicationDbContext db) => _db = db;

    /// <summary>Search and browse verified lawyers.</summary>
    [HttpGet]
    [ProducesResponseType(typeof(LawyerSearchResponse), StatusCodes.Status200OK)]
    public async Task<IActionResult> Search([FromQuery] LawyerSearchRequest request)
    {
        var query = _db.LawyerProfiles
            .Include(lp => lp.User)
            .Include(lp => lp.Specializations).ThenInclude(s => s.LegalTopic)
            .Where(lp => lp.VerificationStatus == VerificationStatus.Verified)
            .AsQueryable();

        if (!string.IsNullOrEmpty(request.Query))
            query = query.Where(lp => lp.User.FullName.Contains(request.Query) || (lp.LawFirm != null && lp.LawFirm.Contains(request.Query)));
        if (request.TopicId.HasValue)
            query = query.Where(lp => lp.Specializations.Any(s => s.LegalTopicId == request.TopicId));
        if (!string.IsNullOrEmpty(request.Region))
            query = query.Where(lp => lp.User.Region == request.Region);
        if (request.MaxFee.HasValue)
            query = query.Where(lp => lp.ConsultationFee15Min <= request.MaxFee);
        if (request.MinRating.HasValue)
            query = query.Where(lp => lp.RatingAvg >= request.MinRating);
        if (request.IsAvailable.HasValue)
            query = query.Where(lp => lp.IsAvailable == request.IsAvailable);

        var total = await query.CountAsync();
        var items = await query
            .OrderByDescending(lp => lp.RatingAvg)
            .Skip((request.Page - 1) * request.PageSize)
            .Take(request.PageSize)
            .Select(lp => new LawyerProfileDto
            {
                Id = lp.Id,
                UserId = lp.UserId,
                FullName = lp.User.FullName,
                AvatarUrl = lp.User.AvatarUrl,
                BarNumber = lp.BarNumber,
                YearCalledToBar = lp.YearCalledToBar,
                Bio = lp.Bio,
                LawFirm = lp.LawFirm,
                ConsultationFee15Min = lp.ConsultationFee15Min,
                ConsultationFee30Min = lp.ConsultationFee30Min,
                IsAvailable = lp.IsAvailable,
                VerificationStatus = lp.VerificationStatus.ToString(),
                RatingAvg = lp.RatingAvg,
                RatingCount = lp.RatingCount,
                TotalConsultations = lp.TotalConsultations,
                ResponseTimeAvgMin = lp.ResponseTimeAvgMin,
                Specializations = lp.Specializations.Select(s => s.LegalTopic.Name).ToList()
            }).ToListAsync();

        return Ok(new LawyerSearchResponse { Items = items, TotalCount = total, Page = request.Page, PageSize = request.PageSize });
    }

    /// <summary>Get a specific lawyer's profile.</summary>
    [HttpGet("{id:guid}")]
    [ProducesResponseType(typeof(LawyerProfileDto), StatusCodes.Status200OK)]
    public async Task<IActionResult> GetById(Guid id)
    {
        var lp = await _db.LawyerProfiles
            .Include(l => l.User)
            .Include(l => l.Specializations).ThenInclude(s => s.LegalTopic)
            .FirstOrDefaultAsync(l => l.Id == id);

        if (lp == null) return NotFound();

        return Ok(new LawyerProfileDto
        {
            Id = lp.Id, UserId = lp.UserId, FullName = lp.User.FullName, AvatarUrl = lp.User.AvatarUrl,
            BarNumber = lp.BarNumber, YearCalledToBar = lp.YearCalledToBar, Bio = lp.Bio, LawFirm = lp.LawFirm,
            ConsultationFee15Min = lp.ConsultationFee15Min, ConsultationFee30Min = lp.ConsultationFee30Min,
            IsAvailable = lp.IsAvailable, VerificationStatus = lp.VerificationStatus.ToString(),
            RatingAvg = lp.RatingAvg, RatingCount = lp.RatingCount, TotalConsultations = lp.TotalConsultations,
            ResponseTimeAvgMin = lp.ResponseTimeAvgMin,
            Specializations = lp.Specializations.Select(s => s.LegalTopic.Name).ToList()
        });
    }

    /// <summary>Update the current lawyer's profile.</summary>
    [HttpPut("profile")]
    [Authorize(Roles = "Lawyer")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    public async Task<IActionResult> UpdateProfile([FromBody] LawyerProfileDto dto)
    {
        // TODO: Get current user ID from claims and update profile
        return Ok(new { message = "Profile update endpoint - implement with current user context" });
    }
}
