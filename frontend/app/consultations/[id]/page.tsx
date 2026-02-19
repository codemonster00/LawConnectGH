"use client";

import { useEffect, useState, useRef, useCallback } from "react";
import { useParams } from "next/navigation";
import ProtectedRoute from "@/components/ProtectedRoute";
import ChatMessage from "@/components/ChatMessage";
import ChatInput from "@/components/ChatInput";
import StatusBadge from "@/components/StatusBadge";
import RatingStars from "@/components/RatingStars";
import LoadingSpinner from "@/components/LoadingSpinner";
import { useAuth } from "@/components/AuthProvider";
import { consultationsApi, messagesApi } from "@/lib/api";
import { ConsultationDto, MessageDto } from "@/lib/types";

function ChatContent() {
  const params = useParams();
  const { user } = useAuth();
  const consultationId = params.id as string;

  const [consultation, setConsultation] = useState<ConsultationDto | null>(null);
  const [messages, setMessages] = useState<MessageDto[]>([]);
  const [loading, setLoading] = useState(true);
  const [showRating, setShowRating] = useState(false);
  const [rating, setRating] = useState(0);
  const [review, setReview] = useState("");
  const messagesEndRef = useRef<HTMLDivElement>(null);

  const fetchMessages = useCallback(async () => {
    try {
      const msgs = await messagesApi.list(consultationId);
      setMessages(msgs);
    } catch {
      // API not available
    }
  }, [consultationId]);

  useEffect(() => {
    consultationsApi.getById(consultationId).then(setConsultation).catch(() => {});
    fetchMessages().finally(() => setLoading(false));
  }, [consultationId, fetchMessages]);

  // Poll for messages every 3 seconds
  useEffect(() => {
    const interval = setInterval(fetchMessages, 3000);
    return () => clearInterval(interval);
  }, [fetchMessages]);

  useEffect(() => {
    messagesEndRef.current?.scrollIntoView({ behavior: "smooth" });
  }, [messages]);

  const handleSend = async (text: string) => {
    try {
      const msg = await messagesApi.send(consultationId, text);
      setMessages((prev) => [...prev, msg]);
    } catch {
      // Offline fallback
      setMessages((prev) => [
        ...prev,
        {
          id: Date.now().toString(),
          consultationId,
          senderId: user?.userId || "",
          content: text,
          messageType: 0,
          isRead: false,
          createdAt: new Date().toISOString(),
        },
      ]);
    }
  };

  const handleEndConsultation = async () => {
    if (!confirm("End this consultation?")) return;
    try {
      await consultationsApi.complete(consultationId);
      setConsultation((prev) => prev ? { ...prev, status: "Completed" } : prev);
      setShowRating(true);
    } catch {}
  };

  if (loading) return <LoadingSpinner />;
  if (!consultation) return <div className="text-center py-20 text-gray-500">Consultation not found</div>;

  const isCompleted = consultation.status === "Completed";
  const isLawyer = user?.role === "Lawyer";

  return (
    <div className="flex flex-col h-[calc(100vh-4rem)]">
      {/* Header */}
      <div className="bg-white border-b px-4 py-3 flex items-center justify-between shrink-0">
        <div>
          <h2 className="font-bold text-sm">
            {isLawyer ? consultation.clientName : (consultation.lawyerName || "Awaiting lawyer")}
          </h2>
          <div className="flex items-center gap-2">
            <span className="text-xs text-gray-500">{consultation.legalTopicName}</span>
            <StatusBadge status={consultation.status} />
          </div>
        </div>
        {!isCompleted && isLawyer && (
          <button
            onClick={handleEndConsultation}
            className="text-xs bg-red-500 text-white px-4 py-2 rounded-full hover:bg-red-600 transition"
          >
            End Consultation
          </button>
        )}
      </div>

      {/* Messages */}
      <div className="flex-1 overflow-y-auto px-4 py-4 bg-gray-50">
        {messages.length === 0 && (
          <div className="text-center text-gray-400 text-sm py-8">
            No messages yet. Start the conversation!
          </div>
        )}
        {messages.map((msg) => (
          <ChatMessage key={msg.id} message={msg} isMine={msg.senderId === user?.userId} />
        ))}
        <div ref={messagesEndRef} />
      </div>

      {/* Input or Completed */}
      {isCompleted ? (
        <div className="p-4 bg-gray-100 text-center text-sm text-gray-600">
          This consultation has ended.
          {!consultation.clientRating && !isLawyer && (
            <button onClick={() => setShowRating(true)} className="text-primary font-semibold ml-2">Rate this consultation</button>
          )}
        </div>
      ) : (
        <ChatInput onSend={handleSend} />
      )}

      {/* Rating Modal */}
      {showRating && (
        <div className="fixed inset-0 bg-black/50 flex items-center justify-center z-50 p-4">
          <div className="bg-white rounded-xl p-6 w-full max-w-sm">
            <h3 className="text-lg font-bold mb-4 text-center">Rate Your Experience</h3>
            <div className="flex justify-center mb-4">
              <RatingStars rating={rating} interactive onRate={setRating} />
            </div>
            <textarea
              placeholder="Write a review (optional)"
              value={review}
              onChange={(e) => setReview(e.target.value)}
              rows={3}
              className="w-full border border-gray-300 rounded-xl px-4 py-2 text-sm mb-4 outline-none focus:ring-2 focus:ring-primary"
            />
            <div className="flex gap-3">
              <button onClick={() => setShowRating(false)} className="flex-1 border border-gray-300 py-2 rounded-full text-sm">
                Skip
              </button>
              <button
                onClick={() => { setShowRating(false); alert(`Rating: ${rating} stars`); }}
                className="flex-1 bg-primary text-white py-2 rounded-full text-sm font-semibold"
              >
                Submit
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}

export default function ConsultationChatPage() {
  return (
    <ProtectedRoute>
      <ChatContent />
    </ProtectedRoute>
  );
}
