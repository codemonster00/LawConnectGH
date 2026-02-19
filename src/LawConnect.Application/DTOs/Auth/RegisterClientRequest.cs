namespace LawConnect.Application.DTOs.Auth;

public class RegisterClientRequest
{
    public string PhoneNumber { get; set; } = string.Empty;
    public string FullName { get; set; } = string.Empty;
    public string? Email { get; set; }
    public string? Region { get; set; }
    public string? City { get; set; }
    public string PreferredLanguage { get; set; } = "en";
}
