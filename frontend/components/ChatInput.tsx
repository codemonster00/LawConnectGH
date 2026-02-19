"use client";

import { useState } from "react";

export default function ChatInput({ onSend }: { onSend: (text: string) => void }) {
  const [text, setText] = useState("");

  const handleSend = () => {
    if (!text.trim()) return;
    onSend(text.trim());
    setText("");
  };

  return (
    <div className="flex items-center gap-2 p-3 bg-white border-t">
      <button type="button" className="text-xl text-gray-400 hover:text-gray-600" title="Attach file">
        📎
      </button>
      <input
        type="text"
        placeholder="Type a message..."
        value={text}
        onChange={(e) => setText(e.target.value)}
        onKeyDown={(e) => e.key === "Enter" && handleSend()}
        className="flex-1 px-4 py-2 border border-gray-300 rounded-full text-sm outline-none focus:ring-2 focus:ring-primary"
      />
      <button
        onClick={handleSend}
        className="bg-primary text-white w-10 h-10 rounded-full flex items-center justify-center hover:bg-primary-light transition"
      >
        ➤
      </button>
    </div>
  );
}
