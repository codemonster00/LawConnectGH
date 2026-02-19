"use client";

import { useEffect, useState, Suspense } from "react";
import { useSearchParams } from "next/navigation";
import LawyerCard from "@/components/LawyerCard";
import LoadingSpinner from "@/components/LoadingSpinner";
import EmptyState from "@/components/EmptyState";
import { lawyersApi } from "@/lib/api";
import { LawyerProfileDto } from "@/lib/types";
import { LEGAL_TOPICS, GHANA_REGIONS } from "@/lib/constants";

function LawyersContent() {
  const searchParams = useSearchParams();
  const [lawyers, setLawyers] = useState<LawyerProfileDto[]>([]);
  const [loading, setLoading] = useState(true);
  const [totalCount, setTotalCount] = useState(0);
  const [page, setPage] = useState(1);

  const [query, setQuery] = useState("");
  const [topic, setTopic] = useState(searchParams.get("topic") || "");
  const [region, setRegion] = useState("");
  const [maxFee, setMaxFee] = useState("");

  const fetchLawyers = async (p: number = 1) => {
    setLoading(true);
    try {
      const topicObj = LEGAL_TOPICS.find((t) => t.slug === topic || t.id === topic);
      const res = await lawyersApi.search({
        query: query || undefined,
        topicId: topicObj?.id,
        region: region || undefined,
        maxFee: maxFee ? parseFloat(maxFee) : undefined,
        page: p,
        pageSize: 12,
      });
      setLawyers(res.items);
      setTotalCount(res.totalCount);
      setPage(p);
    } catch {
      // API not available — show empty
      setLawyers([]);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchLawyers();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  const handleSearch = (e: React.FormEvent) => {
    e.preventDefault();
    fetchLawyers(1);
  };

  const totalPages = Math.ceil(totalCount / 12);

  return (
    <div className="max-w-7xl mx-auto px-4 py-8">
      <h1 className="text-3xl font-bold mb-6">Find a Lawyer</h1>

      {/* Filters */}
      <form onSubmit={handleSearch} className="bg-white border border-gray-200 rounded-xl p-4 mb-6">
        <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-5 gap-3">
          <input
            type="text"
            placeholder="Search by name..."
            value={query}
            onChange={(e) => setQuery(e.target.value)}
            className="border border-gray-300 rounded-xl px-4 py-2 text-sm outline-none focus:ring-2 focus:ring-primary"
          />
          <select
            value={topic}
            onChange={(e) => setTopic(e.target.value)}
            className="border border-gray-300 rounded-xl px-4 py-2 text-sm outline-none focus:ring-2 focus:ring-primary"
          >
            <option value="">All Topics</option>
            {LEGAL_TOPICS.map((t) => (
              <option key={t.id} value={t.id}>{t.icon} {t.name}</option>
            ))}
          </select>
          <select
            value={region}
            onChange={(e) => setRegion(e.target.value)}
            className="border border-gray-300 rounded-xl px-4 py-2 text-sm outline-none focus:ring-2 focus:ring-primary"
          >
            <option value="">All Regions</option>
            {GHANA_REGIONS.map((r) => (
              <option key={r} value={r}>{r}</option>
            ))}
          </select>
          <input
            type="number"
            placeholder="Max fee (GHS)"
            value={maxFee}
            onChange={(e) => setMaxFee(e.target.value)}
            className="border border-gray-300 rounded-xl px-4 py-2 text-sm outline-none focus:ring-2 focus:ring-primary"
          />
          <button
            type="submit"
            className="bg-primary text-white rounded-full py-2 px-6 font-semibold hover:bg-primary-light transition text-sm"
          >
            Search
          </button>
        </div>
      </form>

      {loading ? (
        <LoadingSpinner />
      ) : lawyers.length === 0 ? (
        <EmptyState icon="🔍" title="No lawyers found" message="Try adjusting your filters" />
      ) : (
        <>
          <p className="text-sm text-gray-500 mb-4">{totalCount} lawyer{totalCount !== 1 ? "s" : ""} found</p>
          <div className="grid gap-4 md:grid-cols-2">
            {lawyers.map((l) => (
              <LawyerCard key={l.id} lawyer={l} />
            ))}
          </div>
          {totalPages > 1 && (
            <div className="flex justify-center gap-2 mt-8">
              {Array.from({ length: totalPages }, (_, i) => (
                <button
                  key={i}
                  onClick={() => fetchLawyers(i + 1)}
                  className={`w-10 h-10 rounded-full text-sm font-semibold ${
                    page === i + 1 ? "bg-primary text-white" : "bg-gray-100 text-gray-600 hover:bg-gray-200"
                  }`}
                >
                  {i + 1}
                </button>
              ))}
            </div>
          )}
        </>
      )}
    </div>
  );
}

export default function LawyersPage() {
  return (
    <Suspense fallback={<LoadingSpinner />}>
      <LawyersContent />
    </Suspense>
  );
}
