using LawConnect.Domain.Enums;

namespace LawConnect.Domain.Entities;

public class LawyerProfile
{
    public Guid Id { get; set; }
    public Guid UserId { get; set; }
    public string BarNumber { get; set; } = string.Empty;
    public int YearCalledToBar { get; set; }
    public string? Bio { get; set; }
    public string? LawFirm { get; set; }
    public decimal ConsultationFee15Min { get; set; }
    public decimal ConsultationFee30Min { get; set; }
    public bool IsAvailable { get; set; } = true;
    public string? AvailabilityHours { get; set; } // JSON
    public VerificationStatus VerificationStatus { get; set; } = VerificationStatus.Pending;
    public DateTime? VerifiedAt { get; set; }
    public Guid? VerifiedBy { get; set; }
    public double RatingAvg { get; set; }
    public int RatingCount { get; set; }
    public int TotalConsultations { get; set; }
    public decimal TotalEarnings { get; set; }
    public double ResponseTimeAvgMin { get; set; }
    public DateTime CreatedAt { get; set; }
    public DateTime UpdatedAt { get; set; }

    // Navigation
    public User User { get; set; } = null!;
    public ICollection<LawyerSpecialization> Specializations { get; set; } = new List<LawyerSpecialization>();
}
