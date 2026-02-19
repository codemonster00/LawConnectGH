"use client";

import { LEGAL_TOPICS } from "@/lib/constants";

export default function TopicGrid({
  onSelect,
  selected,
}: {
  onSelect?: (id: string) => void;
  selected?: string;
}) {
  return (
    <div className="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 gap-3">
      {LEGAL_TOPICS.map((topic) => (
        <button
          key={topic.id}
          type="button"
          onClick={() => onSelect?.(topic.id)}
          className={`p-4 rounded-xl border-2 text-center transition hover:shadow-md ${
            selected === topic.id
              ? "border-primary bg-primary/5"
              : "border-gray-200 hover:border-primary/30"
          }`}
        >
          <div className="text-3xl mb-2">{topic.icon}</div>
          <div className="text-sm font-semibold text-gray-800">{topic.name}</div>
        </button>
      ))}
    </div>
  );
}
