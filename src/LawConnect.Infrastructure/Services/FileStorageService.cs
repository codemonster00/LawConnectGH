using LawConnect.Application.Interfaces;

namespace LawConnect.Infrastructure.Services;

public class FileStorageService : IFileStorageService
{
    private readonly string _uploadsPath;

    public FileStorageService()
    {
        _uploadsPath = Path.Combine(Directory.GetCurrentDirectory(), "uploads");
        Directory.CreateDirectory(_uploadsPath);
    }

    public async Task<string> UploadAsync(Stream fileStream, string fileName, string contentType)
    {
        var uniqueName = $"{Guid.NewGuid():N}_{fileName}";
        var filePath = Path.Combine(_uploadsPath, uniqueName);
        using var fs = new FileStream(filePath, FileMode.Create);
        await fileStream.CopyToAsync(fs);
        return $"/uploads/{uniqueName}";
    }

    public async Task<Stream> DownloadAsync(string fileUrl)
    {
        var filePath = Path.Combine(Directory.GetCurrentDirectory(), fileUrl.TrimStart('/'));
        if (!File.Exists(filePath))
            throw new FileNotFoundException("File not found", filePath);
        return await Task.FromResult<Stream>(new FileStream(filePath, FileMode.Open, FileAccess.Read));
    }

    public async Task DeleteAsync(string fileUrl)
    {
        var filePath = Path.Combine(Directory.GetCurrentDirectory(), fileUrl.TrimStart('/'));
        if (File.Exists(filePath))
            File.Delete(filePath);
        await Task.CompletedTask;
    }
}
