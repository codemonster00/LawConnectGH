using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using LawConnect.Application.DTOs.Auth;
using LawConnect.Application.Interfaces;
using LawConnect.Domain.Entities;
using LawConnect.Domain.Enums;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;

namespace LawConnect.API.Controllers;

/// <summary>Authentication endpoints for OTP-based login and registration.</summary>
[ApiController]
[Route("api/v1/auth")]
public class AuthController : ControllerBase
{
    private readonly IApplicationDbContext _db;
    private readonly IConfiguration _config;

    public AuthController(IApplicationDbContext db, IConfiguration config)
    {
        _db = db;
        _config = config;
    }

    /// <summary>Request an OTP code for login.</summary>
    [HttpPost("request-otp")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    public async Task<IActionResult> RequestOtp([FromBody] RequestOtpDto dto)
    {
        var user = await _db.Users.FirstOrDefaultAsync(u => u.PhoneNumber == dto.PhoneOrEmail || u.Email == dto.PhoneOrEmail);
        if (user == null)
            return NotFound(new { message = "User not found. Please register first." });

        var otp = new OtpCode
        {
            UserId = user.Id,
            PhoneOrEmail = dto.PhoneOrEmail,
            Code = Random.Shared.Next(100000, 999999).ToString(),
            Purpose = OtpPurpose.Login,
            ExpiresAt = DateTime.UtcNow.AddMinutes(5)
        };
        _db.OtpCodes.Add(otp);
        await _db.SaveChangesAsync();

        // TODO: Send OTP via SMS/Email service
        return Ok(new { message = "OTP sent successfully", expiresAt = otp.ExpiresAt });
    }

    /// <summary>Verify OTP and return JWT token.</summary>
    [HttpPost("verify-otp")]
    [ProducesResponseType(typeof(AuthResponse), StatusCodes.Status200OK)]
    public async Task<IActionResult> VerifyOtp([FromBody] VerifyOtpDto dto)
    {
        var otp = await _db.OtpCodes
            .Include(o => o.User)
            .FirstOrDefaultAsync(o => o.PhoneOrEmail == dto.PhoneOrEmail && o.Code == dto.Code && !o.IsUsed && o.ExpiresAt > DateTime.UtcNow);

        if (otp == null)
            return Unauthorized(new { message = "Invalid or expired OTP" });

        otp.IsUsed = true;
        otp.User.LastLoginAt = DateTime.UtcNow;
        await _db.SaveChangesAsync();

        return Ok(GenerateAuthResponse(otp.User));
    }

    /// <summary>Refresh an expired JWT token.</summary>
    [HttpPost("refresh")]
    [ProducesResponseType(typeof(AuthResponse), StatusCodes.Status200OK)]
    public IActionResult Refresh()
    {
        // TODO: Implement refresh token logic
        return Ok(new { message = "Refresh token endpoint - implement with secure refresh tokens" });
    }

    /// <summary>Register a new client account.</summary>
    [HttpPost("register/client")]
    [ProducesResponseType(typeof(AuthResponse), StatusCodes.Status201Created)]
    public async Task<IActionResult> RegisterClient([FromBody] RegisterClientRequest dto)
    {
        if (await _db.Users.AnyAsync(u => u.PhoneNumber == dto.PhoneNumber))
            return Conflict(new { message = "Phone number already registered" });

        var user = new User
        {
            PhoneNumber = dto.PhoneNumber,
            FullName = dto.FullName,
            Email = dto.Email,
            Region = dto.Region,
            City = dto.City,
            PreferredLanguage = dto.PreferredLanguage,
            Role = UserRole.Client
        };
        _db.Users.Add(user);
        await _db.SaveChangesAsync();

        return CreatedAtAction(nameof(VerifyOtp), GenerateAuthResponse(user));
    }

    /// <summary>Register a new lawyer account.</summary>
    [HttpPost("register/lawyer")]
    [ProducesResponseType(typeof(AuthResponse), StatusCodes.Status201Created)]
    public async Task<IActionResult> RegisterLawyer([FromBody] RegisterLawyerRequest dto)
    {
        if (await _db.Users.AnyAsync(u => u.PhoneNumber == dto.PhoneNumber))
            return Conflict(new { message = "Phone number already registered" });

        var user = new User
        {
            PhoneNumber = dto.PhoneNumber,
            FullName = dto.FullName,
            Email = dto.Email,
            Role = UserRole.Lawyer
        };
        _db.Users.Add(user);

        var profile = new LawyerProfile
        {
            UserId = user.Id,
            BarNumber = dto.BarNumber,
            YearCalledToBar = dto.YearCalledToBar,
            Bio = dto.Bio,
            LawFirm = dto.LawFirm,
            ConsultationFee15Min = dto.ConsultationFee15Min,
            ConsultationFee30Min = dto.ConsultationFee30Min,
        };
        _db.LawyerProfiles.Add(profile);

        foreach (var topicId in dto.SpecializationTopicIds)
            _db.LawyerSpecializations.Add(new LawyerSpecialization { LawyerProfileId = profile.Id, LegalTopicId = topicId });

        await _db.SaveChangesAsync();
        return CreatedAtAction(nameof(VerifyOtp), GenerateAuthResponse(user));
    }

    private AuthResponse GenerateAuthResponse(User user)
    {
        var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_config["Jwt:Key"] ?? "LawConnectGH-SuperSecret-Key-Change-In-Production-2024!"));
        var credentials = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);
        var expires = DateTime.UtcNow.AddDays(7);

        var claims = new[]
        {
            new Claim(ClaimTypes.NameIdentifier, user.Id.ToString()),
            new Claim(ClaimTypes.Role, user.Role.ToString()),
            new Claim(ClaimTypes.Name, user.FullName),
        };

        var token = new JwtSecurityToken(
            issuer: _config["Jwt:Issuer"] ?? "LawConnectGH",
            audience: _config["Jwt:Audience"] ?? "LawConnectGH",
            claims: claims,
            expires: expires,
            signingCredentials: credentials);

        return new AuthResponse
        {
            Token = new JwtSecurityTokenHandler().WriteToken(token),
            RefreshToken = Guid.NewGuid().ToString(),
            ExpiresAt = expires,
            UserId = user.Id,
            Role = user.Role.ToString()
        };
    }
}
