namespace LawConnect.Application.Interfaces;

public interface IOtpService
{
    string GenerateOtp();
    Task<bool> SendOtpAsync(string phoneOrEmail, string otp);
}
