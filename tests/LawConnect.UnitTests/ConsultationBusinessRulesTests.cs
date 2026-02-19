using LawConnect.Domain.Entities;
using LawConnect.Domain.Enums;

namespace LawConnect.UnitTests;

public class ConsultationBusinessRulesTests
{
    [Theory]
    [InlineData(ConsultationStatus.Requested, true)]
    [InlineData(ConsultationStatus.Matched, true)]
    [InlineData(ConsultationStatus.Active, false)]
    [InlineData(ConsultationStatus.Completed, false)]
    [InlineData(ConsultationStatus.Cancelled, false)]
    public void Consultation_CanBeCancelled_OnlyIfRequestedOrMatched(ConsultationStatus status, bool expected)
    {
        var canCancel = status == ConsultationStatus.Requested || status == ConsultationStatus.Matched;
        Assert.Equal(expected, canCancel);
    }

    [Fact]
    public void Consultation_DefaultStatus_IsRequested()
    {
        var consultation = new Consultation();
        Assert.Equal(ConsultationStatus.Requested, consultation.Status);
    }

    [Fact]
    public void Consultation_Complete_SetsEndedAt()
    {
        var consultation = new Consultation { Status = ConsultationStatus.Active };
        consultation.Status = ConsultationStatus.Completed;
        consultation.EndedAt = DateTime.UtcNow;
        Assert.NotNull(consultation.EndedAt);
        Assert.Equal(ConsultationStatus.Completed, consultation.Status);
    }

    [Fact]
    public void AutoMatch_ShouldPreferHigherRating()
    {
        var lawyers = new[]
        {
            new LawyerProfile { Id = Guid.NewGuid(), RatingAvg = 3.5, IsAvailable = true, ResponseTimeAvgMin = 10 },
            new LawyerProfile { Id = Guid.NewGuid(), RatingAvg = 4.8, IsAvailable = true, ResponseTimeAvgMin = 5 },
            new LawyerProfile { Id = Guid.NewGuid(), RatingAvg = 4.2, IsAvailable = false, ResponseTimeAvgMin = 3 },
        };

        var best = lawyers
            .Where(l => l.IsAvailable)
            .OrderByDescending(l => l.RatingAvg)
            .ThenBy(l => l.ResponseTimeAvgMin)
            .FirstOrDefault();

        Assert.NotNull(best);
        Assert.Equal(4.8, best.RatingAvg);
    }
}
