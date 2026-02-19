using LawConnect.Domain.Enums;

namespace LawConnect.Domain.Entities;

public class OtpCode
{
    public Guid Id { get; set; }
    public Guid UserId { get; set; }
    public string PhoneOrEmail { get; set; } = string.Empty;
    public string Code { get; set; } = string.Empty;
    public OtpPurpose Purpose { get; set; }
    public bool IsUsed { get; set; }
    public DateTime ExpiresAt { get; set; }
    public DateTime CreatedAt { get; set; }

    // Navigation
    public User User { get; set; } = null!;
}
