namespace LawConnect.Application.DTOs.Lawyers;

public class LawyerSearchResponse
{
    public List<LawyerProfileDto> Items { get; set; } = new();
    public int TotalCount { get; set; }
    public int Page { get; set; }
    public int PageSize { get; set; }
}
