using System.Security.Claims;
using LawConnect.Application.Interfaces;
using LawConnect.Domain.Entities;
using LawConnect.Domain.Enums;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.SignalR;

namespace LawConnect.API.Hubs;

[Authorize]
public class ChatHub : Hub
{
    private readonly IApplicationDbContext _db;

    public ChatHub(IApplicationDbContext db) => _db = db;

    private Guid GetUserId() => Guid.Parse(Context.User!.FindFirstValue(ClaimTypes.NameIdentifier)!);

    public async Task JoinConsultation(string consultationId)
    {
        await Groups.AddToGroupAsync(Context.ConnectionId, consultationId);
        await Clients.Group(consultationId).SendAsync("UserJoined", GetUserId(), DateTime.UtcNow);
    }

    public async Task LeaveConsultation(string consultationId)
    {
        await Groups.RemoveFromGroupAsync(Context.ConnectionId, consultationId);
        await Clients.Group(consultationId).SendAsync("UserLeft", GetUserId(), DateTime.UtcNow);
    }

    public async Task SendMessage(string consultationId, string content)
    {
        var userId = GetUserId();
        var message = new Message
        {
            ConsultationId = Guid.Parse(consultationId),
            SenderId = userId,
            Content = content,
            MessageType = MessageType.Text,
            CreatedAt = DateTime.UtcNow
        };
        _db.Messages.Add(message);
        await _db.SaveChangesAsync();

        await Clients.Group(consultationId).SendAsync("ReceiveMessage", new
        {
            message.Id,
            message.ConsultationId,
            message.SenderId,
            message.Content,
            message.MessageType,
            message.CreatedAt
        });
    }

    public async Task SendTyping(string consultationId)
    {
        await Clients.OthersInGroup(consultationId).SendAsync("UserTyping", GetUserId(), DateTime.UtcNow);
    }
}
