namespace LawConnect.Application.DTOs.Auth;

public class VerifyOtpDto
{
    public string PhoneOrEmail { get; set; } = string.Empty;
    public string Code { get; set; } = string.Empty;
}
