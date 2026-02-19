using LawConnect.Application.DTOs.Lawyers;
using LawConnect.Application.Interfaces;
using LawConnect.Domain.Enums;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace LawConnect.API.Controllers;

/// <summary>Admin endpoints for platform management.</summary>
[ApiController]
[Route("api/v1/admin")]
[Authorize(Roles = "Admin")]
public class AdminController : ControllerBase
{
    private readonly IApplicationDbContext _db;

    public AdminController(IApplicationDbContext db) => _db = db;

    /// <summary>Get lawyers pending verification.</summary>
    [HttpGet("lawyers/pending")]
    [ProducesResponseType(typeof(List<LawyerProfileDto>), StatusCodes.Status200OK)]
    public async Task<IActionResult> GetPendingLawyers()
    {
        var lawyers = await _db.LawyerProfiles
            .Include(lp => lp.User)
            .Include(lp => lp.Specializations).ThenInclude(s => s.LegalTopic)
            .Where(lp => lp.VerificationStatus == VerificationStatus.Pending)
            .Select(lp => new LawyerProfileDto
            {
                Id = lp.Id, UserId = lp.UserId, FullName = lp.User.FullName,
                BarNumber = lp.BarNumber, YearCalledToBar = lp.YearCalledToBar,
                Bio = lp.Bio, LawFirm = lp.LawFirm,
                ConsultationFee15Min = lp.ConsultationFee15Min, ConsultationFee30Min = lp.ConsultationFee30Min,
                VerificationStatus = lp.VerificationStatus.ToString(),
                Specializations = lp.Specializations.Select(s => s.LegalTopic.Name).ToList()
            }).ToListAsync();

        return Ok(lawyers);
    }

    /// <summary>Verify or reject a lawyer's profile.</summary>
    [HttpPut("lawyers/{id:guid}/verify")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    public async Task<IActionResult> VerifyLawyer(Guid id, [FromQuery] bool approve = true)
    {
        var profile = await _db.LawyerProfiles.FindAsync(id);
        if (profile == null) return NotFound();

        profile.VerificationStatus = approve ? VerificationStatus.Verified : VerificationStatus.Rejected;
        profile.VerifiedAt = DateTime.UtcNow;
        profile.UpdatedAt = DateTime.UtcNow;
        await _db.SaveChangesAsync();

        return Ok(new { message = $"Lawyer {(approve ? "verified" : "rejected")} successfully" });
    }
}
