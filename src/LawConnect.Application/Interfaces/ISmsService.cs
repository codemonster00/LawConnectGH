namespace LawConnect.Application.Interfaces;

public interface ISmsService
{
    Task<bool> SendAsync(string phoneNumber, string message);
}
