import { MessageDto } from "@/lib/types";

export default function ChatMessage({
  message,
  isMine,
}: {
  message: MessageDto;
  isMine: boolean;
}) {
  if (message.messageType === 3) {
    return (
      <div className="text-center text-xs text-gray-400 py-2">
        {message.content}
      </div>
    );
  }

  return (
    <div className={`flex ${isMine ? "justify-end" : "justify-start"} mb-2`}>
      <div
        className={`max-w-[75%] px-4 py-2 rounded-2xl text-sm ${
          isMine
            ? "bg-primary text-white rounded-br-md"
            : "bg-gray-100 text-gray-800 rounded-bl-md"
        }`}
      >
        <p>{message.content}</p>
        <div className={`text-[10px] mt-1 ${isMine ? "text-white/70" : "text-gray-400"} text-right`}>
          {new Date(message.createdAt).toLocaleTimeString([], { hour: "2-digit", minute: "2-digit" })}
          {isMine && <span className="ml-1">{message.isRead ? "✓✓" : "✓"}</span>}
        </div>
      </div>
    </div>
  );
}
