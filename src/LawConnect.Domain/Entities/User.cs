using LawConnect.Domain.Enums;

namespace LawConnect.Domain.Entities;

public class User
{
    public Guid Id { get; set; }
    public string PhoneNumber { get; set; } = string.Empty;
    public string? Email { get; set; }
    public string FullName { get; set; } = string.Empty;
    public UserRole Role { get; set; }
    public string? PasswordHash { get; set; }
    public string? AvatarUrl { get; set; }
    public string? Region { get; set; }
    public string? City { get; set; }
    public string PreferredLanguage { get; set; } = "en";
    public bool IsVerified { get; set; }
    public bool IsActive { get; set; } = true;
    public bool IsDeleted { get; set; }
    public DateTime? LastLoginAt { get; set; }
    public DateTime CreatedAt { get; set; }
    public DateTime UpdatedAt { get; set; }

    // Navigation properties
    public LawyerProfile? LawyerProfile { get; set; }
    public ICollection<OtpCode> OtpCodes { get; set; } = new List<OtpCode>();
    public ICollection<Consultation> ClientConsultations { get; set; } = new List<Consultation>();
    public ICollection<Consultation> LawyerConsultations { get; set; } = new List<Consultation>();
    public ICollection<Notification> Notifications { get; set; } = new List<Notification>();
}
