namespace LawConnect.Application.DTOs.Lawyers;

public class LawyerSearchRequest
{
    public string? Query { get; set; }
    public Guid? TopicId { get; set; }
    public string? Region { get; set; }
    public decimal? MaxFee { get; set; }
    public double? MinRating { get; set; }
    public bool? IsAvailable { get; set; }
    public int Page { get; set; } = 1;
    public int PageSize { get; set; } = 20;
}
